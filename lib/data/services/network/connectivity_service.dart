abstract class ConnectivityService {
  Future<bool> get isConnected;

  Stream<bool> get onStatusChange;
}
