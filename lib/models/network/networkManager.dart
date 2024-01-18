// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkManager extends ChangeNotifier {
  NetworkManager() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      isConnected = status == InternetConnectionStatus.connected;
      notifyListeners();
    });
  }

  bool isConnected = false;

  Future<bool> canLoadInformation() async {
    log(InternetConnectionChecker().hasConnection.toString());
    return await InternetConnectionChecker().hasConnection;
  }

  Future<void> checkInternetConnection() async {
    bool isNetConnected = await InternetConnectionChecker().hasConnection;

    isConnected = isNetConnected;
    log(isConnected.toString());
    notifyListeners();
  }
}
