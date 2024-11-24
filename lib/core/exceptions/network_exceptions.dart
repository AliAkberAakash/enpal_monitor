import 'package:enpal_monitor/core/exceptions/base_exception.dart';

class NetworkException extends BaseException {
  const NetworkException();
}

class NetworkTimeoutException extends NetworkException {
  const NetworkTimeoutException();
}
