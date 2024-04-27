import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

extension MyExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

responsive<T>(BuildContext context, T val, T val2) {
  var screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth > 800) {
    return val;
  } else {
    return val2;
  }
}

Future<bool> isInternetConnected() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      return false;
    }
  }
