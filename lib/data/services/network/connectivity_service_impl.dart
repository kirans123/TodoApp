// coverage:ignore-file
import 'package:connectivity_wrapper/connectivity_wrapper.dart';

import 'connectivity_service.dart';

class ConnectivityServiceImpl implements ConnectivityService {
  @override
  Future<bool> get isConnected => ConnectivityWrapper.instance.isConnected;

  @override
  Stream<bool> get onStatusChange {
    return ConnectivityWrapper.instance.onStatusChange
        .map((event) => event == ConnectivityStatus.CONNECTED ? true : false);
  }
}
