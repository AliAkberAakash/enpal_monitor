import 'package:enpal_monitor/core/exceptions/base_exception.dart';

/// Represents any kind of network exception other than timeout
class NetworkException extends BaseException {
  const NetworkException();
}

/// Represents timeout exceptions, for example, slow connection or no internet
class NetworkTimeoutException extends NetworkException {
  const NetworkTimeoutException();
}
