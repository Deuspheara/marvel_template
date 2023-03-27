import 'package:injectable/injectable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

@singleton
class ConnectivityServive {
  final Connectivity _connectivity;

  ConnectivityServive(this._connectivity);

  Future<bool> isConnected() async {
    final ConnectivityResult result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Stream<ConnectivityResult> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;

  Future<ConnectivityResult> get connectivityResult async =>
      _connectivity.checkConnectivity();
}
