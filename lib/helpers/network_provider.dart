import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NetworkProvider extends ChangeNotifier {
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  bool _isOnline = false;
  Connectivity connectivity = Connectivity();
  NetworkProvider() {
    initConnectivity();
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e);
    }

    return updateConnectionStatus(result);
  }

  void updateConnectionStatus(ConnectivityResult result) async {
    _isOnline = (result == ConnectivityResult.wifi ||
            result == ConnectivityResult.mobile)
        ? true
        : false;
    notifyListeners();
  }

  bool get isOnline {
    return _isOnline;
  }
}
