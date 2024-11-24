import "package:enpal_monitor/core/exceptions/network_exceptions.dart";
import "package:enpal_monitor/core/exceptions/server_exception.dart";
import "package:enpal_monitor/core/network/dio_network_client.dart";
import "package:enpal_monitor/core/network/network_request.dart";
import "package:flutter_test/flutter_test.dart";
import "package:dio/dio.dart";
import "package:mocktail/mocktail.dart";

class _MockDio extends Mock implements Dio {}

class MockInterceptor extends Mock implements Interceptor {}

class MockInterceptors extends Mock implements Interceptors {}

void main() {
  late _MockDio mockDio;
  late DioNetworkClient networkClient;
  late MockInterceptors mockInterceptors;

  group("DioNetworkClient", () {
    setUp(() {
      mockDio = _MockDio();
      networkClient = DioNetworkClient(mockDio);
      mockInterceptors = MockInterceptors();
      when(() => mockDio.interceptors).thenReturn(mockInterceptors);
    });

    group('Constructor', () {
      test('adds interceptors to Dio if interceptors list is not empty', () {
        final interceptor1 = MockInterceptor();
        final interceptor2 = MockInterceptor();
        final interceptors = [interceptor1, interceptor2];

        when(() => mockInterceptors.addAll(interceptors)).thenReturn(null);

        DioNetworkClient(mockDio, interceptors: interceptors);

        verify(() => mockDio.interceptors.addAll(interceptors)).called(1);
      });

      test('does not add any interceptors if interceptors list is empty', () {
        DioNetworkClient(mockDio);

        verifyNever(() => mockInterceptors.addAll(any()));
      });
    });

    group("DioNetworkClient.get", () {
      const testRequest =
          NetworkRequest(url: "https://example.com", queryParams: {});

      test("should return NetworkResponse on successful response", () async {
        when(
          () => mockDio.get(
            "https://example.com",
            options: any(named: "options"),
            queryParameters: {},
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: testRequest.url),
            statusCode: 200,
            data: {"key": "value"},
            headers: Headers.fromMap(
              {
                "content-type": ["application/json"]
              },
            ),
          ),
        );

        final result = await networkClient.get(testRequest);

        expect(result.body, {"key": "value"});
        expect(
          result.headers,
          {
            "content-type": ["application/json"]
          },
        );
        verify(
          () => mockDio.get(
            testRequest.url,
            options: any(named: "options"),
            queryParameters: {},
          ),
        ).called(1);
      });

      test("should throw NetworkException when network response is null",
          () async {
        when(
          () => mockDio.get(
            "https://example.com",
            options: any(named: "options"),
            queryParameters: {},
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: testRequest.url),
            statusCode: 200,
            data: null,
            headers: Headers.fromMap(
              {
                "content-type": ["application/json"]
              },
            ),
          ),
        );

        expect(
            networkClient.get(testRequest), throwsA(isA<NetworkException>()));
        verify(
          () => mockDio.get(
            testRequest.url,
            options: any(named: "options"),
            queryParameters: {},
          ),
        ).called(1);
      });

      test("throws NetworkTimeoutException on connection timeout", () async {
        when(
          () => mockDio.get(
            "https://example.com",
            options: any(named: "options"),
            queryParameters: {},
          ),
        ).thenThrow(
          DioException.connectionTimeout(
            timeout: const Duration(seconds: 10),
            requestOptions: RequestOptions(),
          ),
        );

        expect(() => networkClient.get(testRequest),
            throwsA(isA<NetworkTimeoutException>()));

        verify(
          () => mockDio.get(
            testRequest.url,
            options: any(named: "options"),
            queryParameters: {},
          ),
        ).called(1);
      });

      test("throws NetworkTimeoutException on connection timeout", () async {
        when(
          () => mockDio.get(
            "https://example.com",
            options: any(named: "options"),
            queryParameters: {},
          ),
        ).thenThrow(
          DioException.connectionTimeout(
            timeout: const Duration(seconds: 10),
            requestOptions: RequestOptions(),
          ),
        );

        expect(() => networkClient.get(testRequest),
            throwsA(isA<NetworkTimeoutException>()));

        verify(
          () => mockDio.get(
            testRequest.url,
            options: any(named: "options"),
            queryParameters: {},
          ),
        ).called(1);
      });

      test("throws NetworkException on DioException except timeout", () async {
        when(
          () => mockDio.get(
            "https://example.com",
            options: any(named: "options"),
            queryParameters: {},
          ),
        ).thenThrow(
          DioException.connectionError(
            reason: "Bad Connection",
            requestOptions: RequestOptions(),
          ),
        );

        expect(() => networkClient.get(testRequest),
            throwsA(isA<NetworkException>()));

        verify(
          () => mockDio.get(
            testRequest.url,
            options: any(named: "options"),
            queryParameters: {},
          ),
        ).called(1);
      });

      test("throws ServerException when DioException contains response",
          () async {
        when(
          () => mockDio.get(
            "https://example.com",
            options: any(named: "options"),
            queryParameters: {},
          ),
        ).thenThrow(
          DioException.badResponse(
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 500,
              statusMessage: "Internal Server Error",
            ),
            requestOptions: RequestOptions(),
            statusCode: 500,
          ),
        );

        expect(
          () => networkClient.get(testRequest),
          throwsA(
            isA<ServerException>()
                .having((e) => e.statusCode, "statusCode", 500)
                .having((e) => e.statusMessage, "statusMessage",
                    "Internal Server Error"),
          ),
        );

        verify(
          () => mockDio.get(
            testRequest.url,
            options: any(named: "options"),
            queryParameters: {},
          ),
        ).called(1);
      });

      test("throws ServerException on non-2xx status code", () async {
        when(
          () => mockDio.get(
            "https://example.com",
            options: any(named: "options"),
            queryParameters: {},
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: testRequest.url),
            statusCode: 400,
            statusMessage: "Not Found",
            headers: Headers.fromMap(
              {
                "content-type": ["application/json"]
              },
            ),
          ),
        );

        expect(
            () => networkClient.get(testRequest),
            throwsA(
              isA<ServerException>()
                  .having((e) => e.statusCode, "statusCode", 400)
                  .having((e) => e.statusMessage, "statusMessage", "Not Found"),
            ));

        verify(
          () => mockDio.get(
            testRequest.url,
            options: any(named: "options"),
            queryParameters: {},
          ),
        ).called(1);
      });
    });
  });
}
