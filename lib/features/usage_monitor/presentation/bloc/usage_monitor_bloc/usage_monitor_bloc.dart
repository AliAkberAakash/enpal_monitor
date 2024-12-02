import 'dart:async';
import 'package:enpal_monitor/features/common/error/error_message_mapper.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/error/error.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/repository/usage_monitor_repository.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_bloc/usage_monitor_event.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_bloc/usage_monitor_state.dart';
import 'package:enpal_monitor/features/usage_monitor/util/constants.dart';
import 'package:enpal_monitor/features/usage_monitor/util/usage_type.dart';
import 'package:enpal_monitor/features/usage_monitor/util/usage_unit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

const int _unitFactor = 1000;

class UsageMonitorBloc extends Bloc<UsageMonitorEvent, UsageMonitorState> {
  final UsageType type;
  final UsageMonitorRepository usageMonitorRepository;
  final ErrorMessageMapper errorMessageMapper;

  UsageMonitorBloc(
    this.usageMonitorRepository,
    this.errorMessageMapper,
    this.type,
  ) : super(UsageMonitorLoadingState()) {
    on<LoadUsageMonitorEvent>(_onLoadUsageMonitorEvent);
    on<DeleteUsageMonitorEvent>(_onDeleteAllUsageMonitorEvent);
    on<ChangeUsageUnitEvent>(_onChangeUsageUnitEvent);
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
          usageData: _aggregateData(flSpots),
          usageUnit: UsageUnit.watt,
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
          errorMessage: errorMessageMapper.mapErrorToMessage(error),
        ),
      );
    } else {
      emit(
        UsageMonitorErrorState(
          errorMessage: errorMessageMapper.mapErrorToMessage(CommonError()),
        ),
      );
    }
  }


List<FlSpot> _aggregateData(List<FlSpot> points) {
  const int interval = 12;
  return List.generate((points.length / interval).ceil(), (index) {
    final sublist = points.skip(index * interval).take(interval);
    final avgValue =
        sublist.map((p) => p.y).reduce((a, b) => a + b) / sublist.length;
    return FlSpot(
      sublist.first.x,
      avgValue.floorToDouble(),
    );
  });
}

  FutureOr<void> _onChangeUsageUnitEvent(
      final ChangeUsageUnitEvent event, final Emitter<UsageMonitorState> emit) {
    if (state is UsageMonitorLoadedState) {
      final usageData = (state as UsageMonitorLoadedState).usageData;
      final usageUnit = (state as UsageMonitorLoadedState).usageUnit;
      if (usageUnit == UsageUnit.watt) {
        emit(
          UsageMonitorLoadedState(
            usageData: usageData
                .map(
                  (data) => FlSpot(
                    data.x,
                    data.y / _unitFactor,
                  ),
                )
                .toList(),
            usageUnit: UsageUnit.kiloWatt,
          ),
        );
      } else {
        emit(
          UsageMonitorLoadedState(
            usageData: usageData
                .map(
                  (data) => FlSpot(
                    data.x,
                    data.y * _unitFactor,
                  ),
                )
                .toList(),
            usageUnit: UsageUnit.watt,
          ),
        );
      }
    }
  }
}
