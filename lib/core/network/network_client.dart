import 'package:enpal_monitor/core/network/network_request.dart';
import 'package:enpal_monitor/core/network/network_response.dart';

abstract class NetworkClient<T> {
  Future<NetworkResponse> get(NetworkRequest request);
}
