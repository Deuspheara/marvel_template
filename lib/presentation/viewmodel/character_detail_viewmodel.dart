import 'package:flutter/cupertino.dart';
import 'package:marvel_app/data/model/character_details.dart';
import 'package:marvel_app/data/model/comics.dart';
import 'package:provider/provider.dart';

import '../../data/endpoint/characters_endpoint.dart';
import '../../data/model/character.dart';
import '../../data/model/stories.dart';
import '../../infrastructure/injections/injector.dart';
import '../../infrastructure/services/connectivity_service.dart';
import '../../infrastructure/services/local_storage_service.dart';

class CharacterDetailViewModel extends ChangeNotifier {
  final CharacterEndpoint characterEndpoint;
  final ConnectivityServive connectivityService;
  final LocalStorageService localStorageService;

  ValueNotifier<bool> isFavoriteNotifier = ValueNotifier<bool>(false);

  CharacterDetails character = CharacterDetails();

  final int id;
  int offset = 0;
  List<Comics> comics = [];
  final ScrollController scrollController = ScrollController();

  CharacterDetailViewModel._(this.connectivityService, this.localStorageService,
      {required this.characterEndpoint, required this.id}) {
    _init();
    load();
    loadComics();
  }

  Future<void> _init() async {
    isCharacterFavorite();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadComics();
      }
    });
  }

  static ChangeNotifierProvider<CharacterDetailViewModel> buildWithProvider(
      {required Widget Function(BuildContext context, Widget? child)? builder,
      Widget? child,
      required int id}) {
    return ChangeNotifierProvider<CharacterDetailViewModel>(
      create: (BuildContext context) => CharacterDetailViewModel._(
        injector<ConnectivityServive>(),
        injector<LocalStorageService>(),
        characterEndpoint: injector<CharacterEndpoint>(),
        id: id,
      ),
      builder: builder,
      lazy: false,
      child: child,
    );
  }

  Future<void> load() async {
    try {
      final bool isConnected = await connectivityService.isConnected();
      if (isConnected && id != character.id) {
        var response = await characterEndpoint.getCharacterById(id);
        character = (response.data.results as List).map((e) {
          return CharacterDetails.fromJson(e);
        }).first;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadComics() async {
    try {
      final bool isConnected = await connectivityService.isConnected();
      if (isConnected) {
        print("oui");
        var response = await characterEndpoint.getCharacterComicsPaginated(
          id,
          20,
          offset,
        );
        comics.addAll((response.data.results as List).map((e) {
          return Comics.fromJson(e);
        }).toList());
        notifyListeners();
        offset += 20;
      }
    } catch (e) {
      print(e);
    }
  }

  //check if character id is in favorite box
  Future<void> isCharacterFavorite() async {
    try {
      localStorageService.switchBox('favorite');
      isFavoriteNotifier.value =
          await localStorageService.isFavorite(id.toString());
    } catch (e) {
      print(e);
    }
  }

  //toggle favorite
  Future<void> toggleFavorite() async {
    try {
      isFavoriteNotifier.value = !isFavoriteNotifier.value;
      await localStorageService.toggleFavorite(character.id.toString(), comics);
    } catch (e) {
      print(e);
    }
  }
}
