import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityStatusProvider = StreamProvider<bool>((ref) async* {
  final connectivity = Connectivity();

  yield _hasConnection(await connectivity.checkConnectivity());

  await for (final results in connectivity.onConnectivityChanged) {
    yield _hasConnection(results);
  }
});

bool _hasConnection(List<ConnectivityResult> results) {
  return results.any(
    (result) =>
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.vpn ||
        result == ConnectivityResult.other,
  );
}
