import 'dart:io';

import 'package:enpal_monitor/features/usage_monitor/domain/entity/usage_monitor_entity.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/repository/usage_monitor_repository.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_bloc.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_event.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_state.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/error/error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockUsageMonitorRepository extends Mock
    implements UsageMonitorRepository {}

void main() {
  late UsageMonitorBloc usageMonitorBloc;
  late UsageMonitorRepository mockUsageMonitorRepository;

  group("UsageMonitorBloc", () {
    setUp(() {
      mockUsageMonitorRepository = MockUsageMonitorRepository();
      usageMonitorBloc = UsageMonitorBloc(mockUsageMonitorRepository);
    });

    test("Initial state is UsageMonitorLoadingState", () {
      expect(usageMonitorBloc.state, UsageMonitorLoadingState());
      verifyZeroInteractions(mockUsageMonitorRepository);
    });

    group("LoadUsageMonitorEvent", () {
      group("Repository throws Exception", () {
        blocTest(
          "Emits [UsageMonitorLoadingState, UsageMonitorErrorState(error: ServerError())] when repository throws ServerError",
          build: () => usageMonitorBloc,
          setUp: () {
            when(() =>
                mockUsageMonitorRepository.getUsageMonitorData(
                    date: "2024-10-20", type: "home")).thenThrow(
                ServerError(statusCode: 500, statusMessage: "Server Error"));
          },
          act: (bloc) => bloc.add(
            LoadUsageMonitorEvent(
              date: "2024-10-20",
              type: "home",
            ),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorLoadingState(),
            UsageMonitorErrorState(
                error: ServerError(
                    statusCode: 500, statusMessage: "Server Error")),
          ],
          verify: (_) {
            verify(() => mockUsageMonitorRepository.getUsageMonitorData(
                  date: "2024-10-20",
                  type: "home",
                )).called(1);
          },
        );

        blocTest(
          "Emits [UsageMonitorLoadingState, UsageMonitorErrorState(error: NetworkError())] when repository throws NetworkError",
          build: () => usageMonitorBloc,
          setUp: () {
            when(() => mockUsageMonitorRepository.getUsageMonitorData(
                  date: "2024-10-20",
                  type: "home",
                )).thenThrow(NetworkError());
          },
          act: (bloc) => bloc.add(
            LoadUsageMonitorEvent(date: "2024-10-20", type: "home"),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorLoadingState(),
            UsageMonitorErrorState(error: NetworkError()),
          ],
          verify: (_) {
            verify(() => mockUsageMonitorRepository.getUsageMonitorData(
                  date: "2024-10-20",
                  type: "home",
                )).called(1);
          },
        );

        blocTest(
          "Emits [UsageMonitorLoadingState, UsageMonitorErrorState(error: NetworkTimeoutError())] when repository throws NetworkTimeoutError",
          build: () => usageMonitorBloc,
          setUp: () {
            when(() => mockUsageMonitorRepository.getUsageMonitorData(
                  date: "2024-10-20",
                  type: "home",
                )).thenThrow(NetworkTimeoutError());
          },
          act: (bloc) => bloc.add(
            LoadUsageMonitorEvent(date: "2024-10-20", type: "home"),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorLoadingState(),
            UsageMonitorErrorState(error: NetworkTimeoutError()),
          ],
          verify: (_) {
            verify(() => mockUsageMonitorRepository.getUsageMonitorData(
                  date: "2024-10-20",
                  type: "home",
                )).called(1);
          },
        );

        blocTest(
          "Emits [UsageMonitorLoadingState, UsageMonitorErrorState(error: CommonError())] when repository throws CommonError",
          build: () => usageMonitorBloc,
          setUp: () {
            when(() => mockUsageMonitorRepository.getUsageMonitorData(
                  date: "2024-10-20",
                  type: "home",
                )).thenThrow(CommonError());
          },
          act: (bloc) => bloc.add(
            LoadUsageMonitorEvent(date: "2024-10-20", type: "home"),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorLoadingState(),
            UsageMonitorErrorState(error: CommonError()),
          ],
          verify: (_) {
            verify(() => mockUsageMonitorRepository.getUsageMonitorData(
                  date: "2024-10-20",
                  type: "home",
                )).called(1);
          },
        );

        blocTest(
          "Emits [UsageMonitorLoadingState, UsageMonitorErrorState(error: CommonError())] when repository throws any other exception",
          build: () => usageMonitorBloc,
          setUp: () {
            when(() => mockUsageMonitorRepository.getUsageMonitorData(
                  date: "2024-10-20",
                  type: "home",
                )).thenThrow(SocketException(""));
          },
          act: (bloc) => bloc.add(
            LoadUsageMonitorEvent(date: "2024-10-20", type: "home"),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorLoadingState(),
            UsageMonitorErrorState(error: CommonError()),
          ],
          verify: (_) {
            verify(() => mockUsageMonitorRepository.getUsageMonitorData(
                  date: "2024-10-20",
                  type: "home",
                )).called(1);
          },
        );
      });

      group("Repository returns success response", () {
        final successResponse = [
          UsageMonitorEntity(DateTime.parse("2024-10-20T00:00:00.000Z"), 2744),
          UsageMonitorEntity(DateTime.parse("2024-10-20T00:00:00.000Z"), 6033),
          UsageMonitorEntity(DateTime.parse("2024-10-20T00:00:00.000Z"), 6753),
          UsageMonitorEntity(DateTime.parse("2024-10-20T00:00:00.000Z"), 5476),
        ];

        blocTest(
          "Emits [UsageMonitorLoadingState, UsageMonitorLoadedState] when repository returns success response",
          build: () => usageMonitorBloc,
          setUp: () {
            when(() => mockUsageMonitorRepository.getUsageMonitorData(
                  date: "2024-10-20",
                  type: "home",
                )).thenAnswer((_) async => successResponse);
          },
          act: (bloc) => bloc.add(
            LoadUsageMonitorEvent(date: "2024-10-20", type: "home"),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorLoadingState(),
            UsageMonitorLoadedState(
              usageData: successResponse,
            ),
          ],
          verify: (_) {
            verify(() => mockUsageMonitorRepository.getUsageMonitorData(
                  date: "2024-10-20",
                  type: "home",
                )).called(1);
          },
        );

        blocTest(
          "Emits [UsageMonitorLoadingState, UsageMonitorLoadedState] when repository returns empty success response",
          build: () => usageMonitorBloc,
          setUp: () {
            when(() => mockUsageMonitorRepository.getUsageMonitorData(
                  date: "2024-10-20",
                  type: "home",
                )).thenAnswer((_) async => []);
          },
          act: (bloc) => bloc.add(
            LoadUsageMonitorEvent(date: "2024-10-20", type: "home"),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorLoadingState(),
            UsageMonitorLoadedState(
              usageData: [],
            ),
          ],
          verify: (_) {
            verify(() => mockUsageMonitorRepository.getUsageMonitorData(
                date: "2024-10-20", type: "home")).called(1);
          },
        );
      });
    });
  });
}
