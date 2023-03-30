import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:marvel_app/data/endpoint/characters_endpoint.dart';
import 'package:marvel_app/data/model/characters_response.dart';
import 'package:marvel_app/infrastructure/injections/injector.dart';
import 'package:marvel_app/infrastructure/services/connectivity_service.dart';
import 'package:marvel_app/infrastructure/services/local_storage_service.dart';
import 'package:provider/provider.dart';

import '../../data/dto/favorite.dart';
import '../../data/model/character.dart';
import '../../data/model/comics.dart';

class HomeViewModel extends ChangeNotifier {
  final CharacterEndpoint characterEndpoint;
  final ConnectivityServive connectivityService;
  final LocalStorageService localStorageService;

  final PagingController<int, Character> pagingController =
      PagingController(firstPageKey: 1);

  List<Character> characters = [];

  HomeViewModel._(this.connectivityService, this.localStorageService,
      {required this.characterEndpoint}) {
    _init();
  }

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

  static ChangeNotifierProvider<HomeViewModel> buildWithProvider(
      {required Widget Function(BuildContext context, Widget? child)? builder,
      Widget? child}) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (BuildContext context) => HomeViewModel._(
        injector<ConnectivityServive>(),
        injector<LocalStorageService>(),
        characterEndpoint: injector<CharacterEndpoint>(),
      )..load(),
      builder: builder,
      lazy: false,
      child: child,
    );
  }

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

  //function to save a character in local storage because it is now a favorite
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

        //save the character in local storage in favorite box
        localStorageService.switchBox('favorite');
        localStorageService.save(character.id.toString(),
            Favorite(character: character, comics: listComics));
      }
    } catch (e) {
      print(e);
    }
  }

  //function to delete a character in local storage because it is no longer a favorite
  Future<void> deleteCharacter(Character character) async {
    try {
      //delete the character in local storage in favorite box
      localStorageService.switchBox('favorite');
      localStorageService.delete(character.id.toString());
    } catch (e) {
      print(e);
    }
  }

  //function to check if a character is a favorite
  Future<bool> isFavorite(Character character) async {
    try {
      localStorageService.switchBox('favorite');
      return localStorageService.isFavorite(character.id.toString());
    } catch (e) {
      print(e);
    }
    return false;
  }

  //function to toggle a favorite character
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
