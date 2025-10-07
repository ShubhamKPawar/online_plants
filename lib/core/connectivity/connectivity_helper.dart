import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  static Future<bool> isConnected() {
    return Connectivity().checkConnectivity().then((connectivityResult) {
      for (var connection in connectivityResult) {
        if (connection == ConnectivityResult.mobile ||
            connection == ConnectivityResult.wifi) {
          return true;
        }
      }
      return false;
    });
  }

  static Stream<bool> onIsConnectedChanged() {
    return Connectivity().onConnectivityChanged.map((connectivityResult) {
      for (var connection in connectivityResult) {
        if (connection == ConnectivityResult.mobile ||
            connection == ConnectivityResult.wifi) {
          return true;
        }
      }
      return false;
    });
  }
}

  // void _checkInternetConnectivity() {
  //   ConnectivityHelper.isConnected().then((isConnected) {
  //     setState(() => hasInternet = isConnected);
  //     if (!isConnected) {
  //       internetSubscription =
  //           ConnectivityHelper.onIsConnectedChanged().listen((connected) {
  //         if (connected) {
  //           internetSubscription?.cancel();
  //           setState(() => hasInternet = true);
  //         }
  //       });
  //     }
  //   });
  // }