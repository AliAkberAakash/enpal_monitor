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
    runZonedGuarded(
      () async {
        final response = await usageMonitorRepository.getUsageMonitorData(
          date: event.date,
          type: event.type,
        );
        emit(
          UsageMonitorLoadedState(
            usageData: response,
          ),
        );
      },
      (Object error, StackTrace stack) => _handleError(emit, error, stack),
    );
  }

  FutureOr<void> _onDeleteAllUsageMonitorEvent(
    final DeleteAllUsageMonitorEvent event,
    final Emitter<UsageMonitorState> emit,
  ) {}

  void _handleError(Emitter emit, Object error, StackTrace stack) {
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
