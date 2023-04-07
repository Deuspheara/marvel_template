import 'package:injectable/injectable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

@singleton
class ConnectivityServive {
  final Connectivity _connectivity;

  ConnectivityServive._(this._connectivity);

  @factoryMethod
  static ConnectivityServive inject() {
    return ConnectivityServive._(Connectivity());
  }

  /// Check if the device is connected to the internet
  ///
  /// return [Future<bool>]
  Future<bool> isConnected() async {
    final ConnectivityResult result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
