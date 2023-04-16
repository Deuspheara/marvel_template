import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../data/dto/favorite.dart';
import '../../data/dto/place.dart';
import '../../infrastructure/injections/injector.dart';
import '../../infrastructure/services/local_storage_service.dart';

class MapsViewModel extends ChangeNotifier {
  List<Favorite> favorites = [];
  List<Place> places = [];

  final LocalStorageService localStorageService;

  MapsViewModel._(this.localStorageService) {
    _init();
  }

  Future<void> _init() async {
    load();
  }

  static ChangeNotifierProvider<MapsViewModel> buildWithProvider(
      {required Widget Function(BuildContext context, Widget? child)? builder,
      Widget? child}) {
    return ChangeNotifierProvider<MapsViewModel>(
      create: (BuildContext context) => MapsViewModel._(
        injector<LocalStorageService>(),
      )..load(),
      builder: builder,
      lazy: false,
      child: child,
    );
  }

  /// load favorites
  Future<void> load() async {
    try {
      localStorageService.switchBox<Favorite>('favorite');
      //List<dynamic> to List<Favorite>
      favorites = await localStorageService.getFavorites<Favorite>();

      favorites.forEach((favorite) {
        if (favorite.position == null) return;

        if (favorite.position?.place == null) return;

        places.add(favorite.position!.place);
      });

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
