import 'package:enpal_monitor/core/network/network_request.dart';
import 'package:enpal_monitor/core/network/network_response.dart';

/// A network client interface for common methods, such as get,put,post,delete etc.
abstract class NetworkClient<T> {
  Future<NetworkResponse> get({required final NetworkRequest request});
}
