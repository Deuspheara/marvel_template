import 'package:flutter/material.dart';
import 'package:marvel_app/data/dto/favorite.dart';
import 'package:marvel_app/infrastructure/injections/injector.dart';
import 'package:provider/provider.dart';

import '../../data/endpoint/characters_endpoint.dart';
import '../../infrastructure/services/connectivity_service.dart';
import '../../infrastructure/services/local_storage_service.dart';

class FavoriteViewModel extends ChangeNotifier {
  final CharacterEndpoint characterEndpoint;
  final ConnectivityServive connectivityService;
  final LocalStorageService localStorageService;

  List<Favorite> favorites = [];

  FavoriteViewModel._(this.connectivityService, this.localStorageService,
      {required this.characterEndpoint}) {
    load();
  }

  static ChangeNotifierProvider<FavoriteViewModel> buildWithProvider(
      {required Widget Function(BuildContext context, Widget? child)? builder,
      Widget? child}) {
    return ChangeNotifierProvider<FavoriteViewModel>(
      create: (_) => FavoriteViewModel._(
        injector<ConnectivityServive>(),
        injector<LocalStorageService>(),
        characterEndpoint: injector<CharacterEndpoint>(),
      ),
      builder: builder,
      lazy: false,
      child: child,
    );
  }

  //load favorites from local storage
  Future<void> load() async {
    try {
      localStorageService.switchBox<Favorite>('favorite');
      //List<dynamic> to List<Favorite>
      favorites = await localStorageService.getFavorites<Favorite>();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
