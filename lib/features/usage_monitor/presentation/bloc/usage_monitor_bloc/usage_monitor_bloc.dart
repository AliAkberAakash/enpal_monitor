import 'dart:async';
import 'package:enpal_monitor/features/usage_monitor/domain/repository/usage_monitor_repository.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_bloc/usage_monitor_event.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_bloc/usage_monitor_state.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/error/error.dart';
import 'package:enpal_monitor/features/usage_monitor/util/constants.dart';
import 'package:enpal_monitor/features/usage_monitor/util/usage_type.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UsageMonitorBloc extends Bloc<UsageMonitorEvent, UsageMonitorState> {
  final UsageType type;
  final UsageMonitorRepository usageMonitorRepository;

  UsageMonitorBloc(
    this.usageMonitorRepository,
    this.type,
  ) : super(UsageMonitorLoadingState()) {
    on<LoadUsageMonitorEvent>(_onLoadUsageMonitorEvent);
    on<DeleteUsageMonitorEvent>(_onDeleteAllUsageMonitorEvent);
  }

  FutureOr<void> _onLoadUsageMonitorEvent(
    final LoadUsageMonitorEvent event,
    final Emitter<UsageMonitorState> emit,
  ) async {
    emit(UsageMonitorLoadingState());
    try {
      final dateString = DateFormat(dateFormat).format(event.date);
      final response = await usageMonitorRepository.getUsageMonitorData(
        date: dateString,
        type: type.name,
      );
      final flSpots = response
          .map(
            (point) => FlSpot(
              point.timestamp.toDouble(),
              point.value.toDouble(),
            ),
          )
          .toList();

      emit(
        UsageMonitorLoadedState(
          usageData: flSpots,
        ),
      );
    } catch (error) {
      _handleError(emit, error);
    }
  }

  FutureOr<void> _onDeleteAllUsageMonitorEvent(
    final DeleteUsageMonitorEvent event,
    final Emitter<UsageMonitorState> emit,
  ) async {
    try {
      final dateString = DateFormat(dateFormat).format(event.date);
      await usageMonitorRepository.deleteUsageMonitorDataByCommonId(
        date: dateString,
        type: type.name,
      );
      emit(UsageMonitorDeletedState());
    } catch (error) {
      _handleError(emit, error);
    }
  }

  void _handleError(Emitter emit, Object error) {
    if (error is BaseError) {
      emit(
        UsageMonitorErrorState(
          error: error,
        ),
      );
    } else {
      emit(
        UsageMonitorErrorState(
          error: CommonError(),
        ),
      );
    }
  }
//
// List<UsageMonitorEntity> _aggregateData(List<UsageMonitorEntity> points) {
//   const int interval = 12;
//   return List.generate((points.length / interval).ceil(), (index) {
//     final sublist = points.skip(index * interval).take(interval);
//     final avgValue =
//         sublist.map((p) => p.value).reduce((a, b) => a + b) / sublist.length;
//     return UsageMonitorEntity(
//       sublist.first.timestamp,
//       avgValue.floorToDouble(),
//     );
//   });
// }
}
