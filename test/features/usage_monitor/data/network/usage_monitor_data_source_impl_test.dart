import 'dart:convert';

import 'package:enpal_monitor/core/exceptions/network_exceptions.dart';
import 'package:enpal_monitor/core/exceptions/server_exception.dart';
import 'package:enpal_monitor/core/network/network_client.dart';
import 'package:enpal_monitor/core/network/network_request.dart';
import 'package:enpal_monitor/core/network/network_response.dart';
import 'package:enpal_monitor/features/usage_monitor/data/network/dto/usage_monitor_response.dart';
import 'package:enpal_monitor/features/usage_monitor/data/network/usage_monitor_network_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../utils/common_mocks.dart';
import 'json_response.dart';

class _MockNetworkClient extends Mock implements NetworkClient {}

void main() {
  late _MockNetworkClient networkClient;
  late MockLogger logger;
  late UsageMonitorNetworkDataSourceImpl usageMonitorNetworkDataSource;

  setUp(() {
    networkClient = _MockNetworkClient();
    logger = MockLogger();
    usageMonitorNetworkDataSource = UsageMonitorNetworkDataSourceImpl(
      networkClient,
      logger,
    );
  });

  group("UsageMonitorNetworkDataSourceImpl", () {
    group("getWeatherResponse", () {
      const mockNetworkRequest = NetworkRequest(
        url: "monitoring",
        queryParams: {
          "date": "2024-10-20",
          "type": "solar",
        },
      );
      test(
          "getUsageMonitorResponse returns UsageMonitorResponse when successful request",
          () async {
        final mockResponse = NetworkResponse(
          body: jsonDecode(jsonResponse),
          headers: {
            "Content-Type": ["application/json"]
          },
        );
        when(() => networkClient.get(request: mockNetworkRequest)).thenAnswer(
          (_) async => mockResponse,
        );
        var expectedResult = [
          UsageMonitorResponse(
            timestamp: DateTime.parse("2024-10-20T00:00:00.000Z"),
            value: 2744,
          ),
          UsageMonitorResponse(
            timestamp: DateTime.parse("2024-10-20T00:05:00.000Z"),
            value: 6033,
          ),
        ];

        final result =
            await usageMonitorNetworkDataSource.getUsageMonitorResponse(
          date: "2024-10-20",
          type: "solar",
        );

        expect(result, expectedResult);
        verify(
          () => networkClient.get(
            request: mockNetworkRequest,
          ),
        ).called(1);
      });

      test(
          "getUsageMonitorResponse throws NetworkException when NetworkClient throws NetworkException",
          () async {
        when(() => networkClient.get(request: mockNetworkRequest))
            .thenThrow(const NetworkException());

        expect(
          usageMonitorNetworkDataSource.getUsageMonitorResponse(
            date: "2024-10-20",
            type: "solar",
          ),
          throwsA(isA<NetworkException>()),
        );

        verify(
          () => networkClient.get(request: mockNetworkRequest),
        ).called(1);
      });

      test(
          "getUsageMonitorResponse throws NetworkTimeoutException when NetworkClient throws NetworkTimeoutException",
          () async {
        when(() => networkClient.get(request: mockNetworkRequest))
            .thenThrow(const NetworkTimeoutException());

        expect(
          usageMonitorNetworkDataSource.getUsageMonitorResponse(
            date: "2024-10-20",
            type: "solar",
          ),
          throwsA(isA<NetworkTimeoutException>()),
        );

        verify(
          () => networkClient.get(request: mockNetworkRequest),
        ).called(1);
      });

      test(
          "getUsageMonitorResponse throws ServerException when NetworkClient throws ServerException",
          () async {
        when(() => networkClient.get(request: mockNetworkRequest))
            .thenThrow(const ServerException());

        expect(
          usageMonitorNetworkDataSource.getUsageMonitorResponse(
            date: "2024-10-20",
            type: "solar",
          ),
          throwsA(isA<ServerException>()),
        );

        verify(
          () => networkClient.get(request: mockNetworkRequest),
        ).called(1);
      });

      test(
          "getUsageMonitorResponse rethrows any other exception when NetworkClient throws exception",
          () async {
        when(() => networkClient.get(request: mockNetworkRequest))
            .thenThrow(const FormatException());

        expect(
          usageMonitorNetworkDataSource.getUsageMonitorResponse(
            date: "2024-10-20",
            type: "solar",
          ),
          throwsA(isA<FormatException>()),
        );

        verify(
          () => networkClient.get(request: mockNetworkRequest),
        ).called(1);
      });
    });
  });
}
