import 'package:enpal_monitor/core/network/network_client.dart';
import 'package:enpal_monitor/core/network/network_request.dart';
import 'package:enpal_monitor/features/usage_monitor/data/network/dto/usage_monitor_response.dart';
import 'package:enpal_monitor/features/usage_monitor/data/network/usage_monitor_network_data_source.dart';
import 'package:logger/logger.dart';

class UsageMonitorNetworkDataSourceImpl
    implements UsageMonitorNetworkDataSource {
  final NetworkClient _networkClient;
  final Logger _logger;

  UsageMonitorNetworkDataSourceImpl(
    this._networkClient,
    this._logger,
  );

  @override
  Future<List<UsageMonitorResponse>> getUsageMonitorResponse({
    required final String date,
    required final String type,
  }) async {
    try {
      final networkRequest = NetworkRequest(
        url: "monitoring",
        queryParams: {
          "date": date,
          "type": type,
        },
      );
      final response = await _networkClient.get(
        request: networkRequest,
      );
      final List<UsageMonitorResponse> weatherList = (response.body as List)
          .map((weatherData) => UsageMonitorResponse.fromJson(weatherData))
          .toList();

      return weatherList;
    } catch (e) {
      _logger.d(e.toString());
      rethrow;
    }
  }
}
