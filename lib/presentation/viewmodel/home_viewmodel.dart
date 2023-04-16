import 'dart:io';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:marvel_app/data/dto/character_position.dart';
import 'package:marvel_app/data/dto/country_code.dart';
import 'package:marvel_app/data/endpoint/characters_endpoint.dart';
import 'package:marvel_app/data/model/characters_response.dart';
import 'package:marvel_app/infrastructure/injections/injector.dart';
import 'package:marvel_app/infrastructure/services/connectivity_service.dart';
import 'package:marvel_app/infrastructure/services/local_storage_service.dart';
import 'package:marvel_app/infrastructure/services/ressource_service.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'dart:typed_data';

import 'package:provider/provider.dart';

import '../../data/dto/favorite.dart';
import '../../data/model/character.dart';
import '../../data/model/comics.dart';

class HomeViewModel extends ChangeNotifier {
  final CharacterEndpoint characterEndpoint;
  final ConnectivityServive connectivityService;
  final LocalStorageService localStorageService;
  final RessourceService ressourceService;

  final PagingController<int, Character> pagingController =
      PagingController(firstPageKey: 1);

  List<Character> characters = [];

  HomeViewModel._(
      this.connectivityService, this.localStorageService, this.ressourceService,
      {required this.characterEndpoint}) {
    _init();
  }

  /// Init
  Future<void> _init() async {
    final bool isConnected = await connectivityService.isConnected();
    if (isConnected) {
      var response = await characterEndpoint.getCharacters();

      characters = (response.data.results as List).map((e) {
        return Character.fromJson(e);
      }).toList();

      _fetchPage(1);

      pagingController.addPageRequestListener((pageKey) {
        _fetchPage(pageKey);
      });

      notifyListeners();
    }
  }

  /// Fetch page
  /// take [pageKey] as parameter
  Future<void> _fetchPage(int pageKey) async {
    final bool isConnected = await connectivityService.isConnected();
    if (isConnected) {
      try {
        final newPage =
            await characterEndpoint.getCharactersPaginated(20, pageKey);
        final previouslyFetchedItemsCount =
            pagingController.itemList?.length ?? 0;

        final isLastPage = newPage.data.total! <=
            previouslyFetchedItemsCount + newPage.data.results.length;
        final newItems = (newPage.data.results as List).map((e) {
          return Character.fromJson(e);
        }).toList();

        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 20;
          pagingController.appendPage(newItems, nextPageKey);
        }
      } catch (error) {
        pagingController.error = error;
      }
    }
  }

  /// Build with provider
  /// take [builder] and [child] as parameters
  ///
  /// return [ChangeNotifierProvider<HomeViewModel>]
  static ChangeNotifierProvider<HomeViewModel> buildWithProvider(
      {required Widget Function(BuildContext context, Widget? child)? builder,
      Widget? child}) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (BuildContext context) => HomeViewModel._(
        injector<ConnectivityServive>(),
        injector<LocalStorageService>(),
        injector<RessourceService>(),
        characterEndpoint: injector<CharacterEndpoint>(),
      )..load(),
      builder: builder,
      lazy: false,
      child: child,
    );
  }

  /// Function to load data
  Future<void> load() async {
    try {
      final bool isConnected = await connectivityService.isConnected();
      if (isConnected) {
        var response = await characterEndpoint.getCharacters();

        characters = (response.data.results as List).map((e) {
          return Character.fromJson(e);
        }).toList();

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  /// Function to save a character in local storage because it is a favorite
  ///
  /// take [character] as parameter
  Future<void> saveCharacter(Character character) async {
    try {
      final bool isConnected = await connectivityService.isConnected();
      if (isConnected) {
        //get the 20 first comics linked to this character
        final List<Comics> listComics = await characterEndpoint
            .getCharacterComicsPaginated(character.id, 20, 0)
            .then((value) => (value.data.results as List).map((e) {
                  return Comics.fromJson(e);
                }).toList());

        Uint8List image = await ressourceService.getImage(
          "${character.thumbnail?.path}.${character.thumbnail?.extension}",
        );

        //save the character image/comics in local storage
        final newPath = await ressourceService.saveRessource(
            character.id.toString(),
            character.thumbnail?.extension ?? "",
            image);

        //update the character thumbnail path and extension
        character.thumbnail?.path = newPath["path"];
        character.thumbnail?.extension = newPath["extension"];

        //save the character in local storage in favorite box
        localStorageService.switchBox<Favorite>('favorite');

        var countryCode =
            CountryCode.values[Random().nextInt(CountryCode.values.length)];
        var latLng = countryCode.getRandomLatLng();

        localStorageService.save(
            character.id.toString(),
            Favorite(
                character: character,
                comics: listComics,
                position: CharacterPosition(
                    latitude: latLng.latitude,
                    longitude: latLng.longitude,
                    country: countryCode)));

        localStorageService.updateField(
            character.id.toString(), "character", character);
      }
    } catch (e) {
      print(e);
    }
  }

  /// Function to delete a character in local storage because it is not a favorite anymore
  Future<void> deleteCharacter(Character character) async {
    try {
      //delete the character in local storage in favorite box
      localStorageService.switchBox<Favorite>('favorite');
      localStorageService.delete<Favorite>(character.id.toString());
    } catch (e) {
      print(e);
    }
  }

  /// Function to check if a character is favorite
  Future<bool> isFavorite(Character character) async {
    try {
      localStorageService.switchBox<Favorite>('favorite');
      return localStorageService.isFavorite<Favorite>(character.id.toString());
    } catch (e) {
      print(e);
    }
    return false;
  }

  /// Function to toggle a character favorite
  Future<void> toggleFavorite(Character character) async {
    try {
      if (await isFavorite(character)) {
        await deleteCharacter(character);
      } else {
        await saveCharacter(character);
      }
    } catch (e) {
      print(e);
    }
  }
}
