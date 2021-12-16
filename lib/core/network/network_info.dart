import 'package:connectivity/connectivity.dart';

class NetworkInfo {
  Future<bool> isConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
