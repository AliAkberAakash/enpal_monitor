import 'dart:async';

import 'package:enpal_monitor/features/usage_monitor/domain/repository/usage_monitor_repository.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_event.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_state.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/error/error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsageMonitorBloc extends Bloc<UsageMonitorEvent, UsageMonitorState> {
  final UsageMonitorRepository usageMonitorRepository;

  UsageMonitorBloc(
    this.usageMonitorRepository,
  ) : super(UsageMonitorLoadingState()) {
    on<LoadUsageMonitorEvent>(_onLoadUsageMonitorEvent);
    on<DeleteAllUsageMonitorEvent>(_onDeleteAllUsageMonitorEvent);
  }

  FutureOr<void> _onLoadUsageMonitorEvent(
    final LoadUsageMonitorEvent event,
    final Emitter<UsageMonitorState> emit,
  ) async {
    emit(UsageMonitorLoadingState());
    try {
      final response = await usageMonitorRepository.getUsageMonitorData(
        date: event.date,
        type: event.type,
      );
      emit(
        UsageMonitorLoadedState(
          usageData: response,
        ),
      );
    } catch (error) {
      _handleError(emit, error);
    }
  }

  FutureOr<void> _onDeleteAllUsageMonitorEvent(
    final DeleteAllUsageMonitorEvent event,
    final Emitter<UsageMonitorState> emit,
  ) async {
    try {
      final result =
          await usageMonitorRepository.deleteDeleteAllUsageMonitorData();
      emit(UsageMonitorDeletedState(success: result));
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
}
