import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider with ChangeNotifier {
  bool _isConnected = true;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  bool get isConnected => _isConnected;

  ConnectivityProvider() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      // Create a list with the single result
      _updateConnectionStatus([results.first]);
    } catch (e) {
      print('Error checking connectivity: $e');
      _isConnected = false;
      notifyListeners();
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    // Check if any result indicates an active connection
    _isConnected = results.any((result) => result != ConnectivityResult.none);
    print('Connection status: $results');
    notifyListeners();
  }

  String getConnectionType(List<ConnectivityResult> results) {
    if (results.isEmpty) return 'No Connection';

    final types = results
        .map((result) {
          switch (result) {
            case ConnectivityResult.wifi:
              return 'WiFi';
            case ConnectivityResult.mobile:
              return 'Mobile Data';
            case ConnectivityResult.ethernet:
              return 'Ethernet';
            case ConnectivityResult.vpn:
              return 'VPN';
            case ConnectivityResult.none:
              return 'No Connection';
            default:
              return 'Unknown';
          }
        })
        .toSet()
        .join(', ');

    return types.isEmpty ? 'No Connection' : types;
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
