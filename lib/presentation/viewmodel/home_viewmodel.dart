import 'package:flutter/widgets.dart';
import 'package:marvel_app/data/endpoint/characters_endpoint.dart';
import 'package:marvel_app/data/model/characters_response.dart';
import 'package:marvel_app/infrastructure/injections/injector.dart';
import 'package:marvel_app/infrastructure/services/connectivity_service.dart';
import 'package:provider/provider.dart';

import '../../data/model/character.dart';

class HomeViewModel extends ChangeNotifier {
  final CharacterEndpoint characterEndpoint;
  final ConnectivityServive _connectivityServive;

  List<Character> characters = [];

  HomeViewModel._(this._connectivityServive,
      {required this.characterEndpoint}) {
    _init();
  }

  Future<void> _init() async {
    final bool isConnected = await _connectivityServive.isConnected();
    if (isConnected) {
      var response = await characterEndpoint.getCharacters();

      characters = CharacterResponse.fromJson(response.data).results ?? [];
      notifyListeners();
    }
  }

  static ChangeNotifierProvider<HomeViewModel> buildWithProvider(
      {required Widget Function(BuildContext context, Widget? child)? builder,
      Widget? child}) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (BuildContext context) => HomeViewModel._(
        injector<ConnectivityServive>(),
        characterEndpoint: injector<CharacterEndpoint>(),
      )..load(),
      builder: builder,
      lazy: false,
      child: child,
    );
  }

  Future<void> load() async {
    try {
      final bool isConnected = await _connectivityServive.isConnected();
      if (isConnected) {
        var response = await characterEndpoint.getCharacters();
        characters = response.data.map((e) => Character.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
