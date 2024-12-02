import 'dart:io';

import 'package:enpal_monitor/features/common/error/error_message_mapper.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/entity/usage_monitor_entity.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/error/error.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/repository/usage_monitor_repository.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_bloc/usage_monitor_bloc.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_bloc/usage_monitor_event.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_bloc/usage_monitor_state.dart';
import 'package:enpal_monitor/features/usage_monitor/util/usage_type.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockUsageMonitorRepository extends Mock
    implements UsageMonitorRepository {}

class MockErrorMessageMapper extends Mock implements ErrorMessageMapper {}

void main() {
  late UsageMonitorBloc usageMonitorBloc;
  late ErrorMessageMapper mockErrorMessageMapper;
  late UsageMonitorRepository mockUsageMonitorRepository;

  group("UsageMonitorBloc", () {
    setUp(() {
      mockUsageMonitorRepository = MockUsageMonitorRepository();
      mockErrorMessageMapper = MockErrorMessageMapper();
      usageMonitorBloc = UsageMonitorBloc(
        mockUsageMonitorRepository,
        mockErrorMessageMapper,
        UsageType.home,
      );
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
            when(
              () => mockUsageMonitorRepository.getUsageMonitorData(
                date: "2024-10-20",
                type: "home",
              ),
            ).thenThrow(
              ServerError(
                statusCode: 500,
                statusMessage: "Server Error",
              ),
            );
            when(() => mockErrorMessageMapper.mapErrorToMessage(ServerError(
                  statusCode: 500,
                  statusMessage: "Server Error",
                ))).thenAnswer(
              (_) => "Server Error",
            );
          },
          act: (bloc) => bloc.add(
            LoadUsageMonitorEvent(
              date: DateTime.parse("2024-10-20"),
            ),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorLoadingState(),
            UsageMonitorErrorState(
              errorMessage: "Server Error",
            ),
          ],
          verify: (_) {
            verify(
              () => mockUsageMonitorRepository.getUsageMonitorData(
                date: "2024-10-20",
                type: "home",
              ),
            ).called(1);
          },
        );

        blocTest(
          "Emits [UsageMonitorLoadingState, UsageMonitorErrorState(error: NetworkError())] when repository throws NetworkError",
          build: () => usageMonitorBloc,
          setUp: () {
            when(
              () => mockUsageMonitorRepository.getUsageMonitorData(
                date: "2024-10-20",
                type: "home",
              ),
            ).thenThrow(NetworkError());
            when(
              () => mockErrorMessageMapper.mapErrorToMessage(
                NetworkError(),
              ),
            ).thenAnswer(
              (_) => "Failed to load data",
            );
          },
          act: (bloc) => bloc.add(
            LoadUsageMonitorEvent(
              date: DateTime.parse("2024-10-20"),
            ),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorLoadingState(),
            UsageMonitorErrorState(errorMessage: "Failed to load data"),
          ],
          verify: (_) {
            verify(
              () => mockUsageMonitorRepository.getUsageMonitorData(
                date: "2024-10-20",
                type: "home",
              ),
            ).called(1);
          },
        );

        blocTest(
          "Emits [UsageMonitorLoadingState, UsageMonitorErrorState(error: NetworkTimeoutError())] when repository throws NetworkTimeoutError",
          build: () => usageMonitorBloc,
          setUp: () {
            when(
              () => mockUsageMonitorRepository.getUsageMonitorData(
                date: "2024-10-20",
                type: "home",
              ),
            ).thenThrow(NetworkTimeoutError());
            when(
              () => mockErrorMessageMapper.mapErrorToMessage(
                NetworkTimeoutError(),
              ),
            ).thenAnswer(
              (_) => "Please check your internet connection",
            );
          },
          act: (bloc) => bloc.add(
            LoadUsageMonitorEvent(
              date: DateTime.parse("2024-10-20"),
            ),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorLoadingState(),
            UsageMonitorErrorState(
                errorMessage: "Please check your internet connection"),
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
            when(
              () => mockUsageMonitorRepository.getUsageMonitorData(
                date: "2024-10-20",
                type: "home",
              ),
            ).thenThrow(
              CommonError(),
            );
            when(
              () => mockErrorMessageMapper.mapErrorToMessage(
                CommonError(),
              ),
            ).thenAnswer(
              (_) => "Something went wrong",
            );
          },
          act: (bloc) => bloc.add(
            LoadUsageMonitorEvent(
              date: DateTime.parse("2024-10-20"),
            ),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorLoadingState(),
            UsageMonitorErrorState(errorMessage: "Something went wrong"),
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
            when(
              () => mockUsageMonitorRepository.getUsageMonitorData(
                date: "2024-10-20",
                type: "home",
              ),
            ).thenThrow(
              SocketException(""),
            );
            when(
              () => mockErrorMessageMapper.mapErrorToMessage(
                CommonError(),
              ),
            ).thenAnswer(
              (_) => "Something went wrong",
            );
          },
          act: (bloc) => bloc.add(
            LoadUsageMonitorEvent(
              date: DateTime.parse("2024-10-20"),
            ),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorLoadingState(),
            UsageMonitorErrorState(errorMessage: "Something went wrong"),
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
          UsageMonitorEntity(
            DateTime.parse("2024-10-20T00:00:00.000Z")
                .millisecondsSinceEpoch
                .toDouble(),
            2744,
          ),
          UsageMonitorEntity(
            DateTime.parse("2024-10-20T00:00:00.000Z")
                .millisecondsSinceEpoch
                .toDouble(),
            6033,
          ),
          UsageMonitorEntity(
            DateTime.parse("2024-10-20T00:00:00.000Z")
                .millisecondsSinceEpoch
                .toDouble(),
            6753,
          ),
          UsageMonitorEntity(
            DateTime.parse("2024-10-20T00:00:00.000Z")
                .millisecondsSinceEpoch
                .toDouble(),
            5476,
          ),
        ];

        blocTest(
          "Emits [UsageMonitorLoadingState, UsageMonitorLoadedState] when repository returns success response",
          build: () => usageMonitorBloc,
          setUp: () {
            when(
              () => mockUsageMonitorRepository.getUsageMonitorData(
                date: "2024-10-20",
                type: "home",
              ),
            ).thenAnswer(
              (_) async => successResponse,
            );
          },
          act: (bloc) => bloc.add(
            LoadUsageMonitorEvent(
              date: DateTime.parse("2024-10-20"),
            ),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorLoadingState(),
            UsageMonitorLoadedState(
              usageData: successResponse
                  .map(
                    (point) => FlSpot(
                      point.timestamp.toDouble(),
                      point.value.toDouble(),
                    ),
                  )
                  .toList(),
            ),
          ],
          verify: (_) {
            verify(
              () => mockUsageMonitorRepository.getUsageMonitorData(
                date: "2024-10-20",
                type: "home",
              ),
            ).called(1);
          },
        );

        blocTest(
          "Emits [UsageMonitorLoadingState, UsageMonitorLoadedState] when repository returns empty success response",
          build: () => usageMonitorBloc,
          setUp: () {
            when(
              () => mockUsageMonitorRepository.getUsageMonitorData(
                date: "2024-10-20",
                type: "home",
              ),
            ).thenAnswer(
              (_) async => [],
            );
          },
          act: (bloc) => bloc.add(
            LoadUsageMonitorEvent(
              date: DateTime.parse("2024-10-20"),
            ),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorLoadingState(),
            UsageMonitorLoadedState(
              usageData: [],
            ),
          ],
          verify: (_) {
            verify(
              () => mockUsageMonitorRepository.getUsageMonitorData(
                date: "2024-10-20",
                type: "home",
              ),
            ).called(1);
          },
        );
      });
    });

    group(DeleteUsageMonitorEvent, () {
      group("Repository throws Exception", () {
        blocTest(
          "Emits [UsageMonitorErrorState(error: CommonError())] when repository throws CommonError",
          build: () => usageMonitorBloc,
          setUp: () {
            when(
              () => mockUsageMonitorRepository.deleteUsageMonitorDataByCommonId(
                date: "2024-10-20",
                type: "home",
              ),
            ).thenThrow(
              CommonError(),
            );
            when(
              () => mockErrorMessageMapper.mapErrorToMessage(
                CommonError(),
              ),
            ).thenAnswer(
              (_) => "Something went wrong",
            );
          },
          act: (bloc) => bloc.add(
            DeleteUsageMonitorEvent(
              DateTime.parse("2024-10-20"),
            ),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorErrorState(errorMessage: "Something went wrong"),
          ],
          verify: (_) {
            verify(
              () => mockUsageMonitorRepository.deleteUsageMonitorDataByCommonId(
                date: "2024-10-20",
                type: "home",
              ),
            ).called(1);
          },
        );

        blocTest(
          "Emits [UsageMonitorErrorState(error: CommonError())] when repository throws any other exception",
          build: () => usageMonitorBloc,
          setUp: () {
            when(
              () => mockUsageMonitorRepository.deleteUsageMonitorDataByCommonId(
                date: "2024-10-20",
                type: "home",
              ),
            ).thenThrow(
              SocketException(""),
            );
            when(
              () => mockErrorMessageMapper.mapErrorToMessage(
                CommonError(),
              ),
            ).thenAnswer(
              (_) => "Something went wrong",
            );
          },
          act: (bloc) => bloc.add(
            DeleteUsageMonitorEvent(
              DateTime.parse("2024-10-20"),
            ),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorErrorState(errorMessage: "Something went wrong"),
          ],
          verify: (_) {
            verify(
              () => mockUsageMonitorRepository.deleteUsageMonitorDataByCommonId(
                date: "2024-10-20",
                type: "home",
              ),
            ).called(1);
          },
        );
      });

      group("Repository returns success Response", () {
        blocTest(
          "Emits [UsageMonitorLoadedState] when repository returns true",
          build: () => usageMonitorBloc,
          setUp: () {
            when(
              () => mockUsageMonitorRepository.deleteUsageMonitorDataByCommonId(
                date: "2024-10-20",
                type: "home",
              ),
            ).thenAnswer(
              (_) async {},
            );
          },
          act: (bloc) => bloc.add(
            DeleteUsageMonitorEvent(
              DateTime.parse("2024-10-20"),
            ),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorDeletedState(),
          ],
          verify: (_) {
            verify(
              () => mockUsageMonitorRepository.deleteUsageMonitorDataByCommonId(
                date: "2024-10-20",
                type: "home",
              ),
            ).called(1);
          },
        );

        blocTest(
          "Emits [UsageMonitorLoadedState] when repository returns false",
          build: () => usageMonitorBloc,
          setUp: () {
            when(
              () => mockUsageMonitorRepository.deleteUsageMonitorDataByCommonId(
                date: "2024-10-20",
                type: "home",
              ),
            ).thenAnswer(
              (_) async {},
            );
          },
          act: (bloc) => bloc.add(
            DeleteUsageMonitorEvent(
              DateTime.parse("2024-10-20"),
            ),
          ),
          expect: () => <UsageMonitorState>[
            UsageMonitorDeletedState(),
          ],
          verify: (_) {
            verify(
              () => mockUsageMonitorRepository.deleteUsageMonitorDataByCommonId(
                date: "2024-10-20",
                type: "home",
              ),
            ).called(1);
          },
        );
      });
    });
  });
}
