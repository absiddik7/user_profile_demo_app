import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity;
  StreamController<bool>? _connectivityController;

  ConnectivityService() : _connectivity = Connectivity();

  // connectivity status
  Stream<bool> get connectivityStream {
    _connectivityController ??= StreamController<bool>.broadcast();

    _connectivity.onConnectivityChanged.listen((results) {
      final isConnected = _checkConnectivity(results);
      _connectivityController?.add(isConnected);
    });

    return _connectivityController!.stream;
  }

  // Check current connectivity status
  Future<bool> isConnected() async {
    final results = await _connectivity.checkConnectivity();
    return _checkConnectivity(results);
  }

  // Helper to check if any connectivity result indicates connection
  bool _checkConnectivity(List<ConnectivityResult> results) {
    return results.any(
      (result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet,
    );
  }

  // Dispose the stream controller
  void dispose() {
    _connectivityController?.close();
    _connectivityController = null;
  }
}
