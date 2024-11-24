import 'dart:async';

import 'package:enpal_monitor/features/usage_monitor/domain/repository/usage_monitor_repository.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_event.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_state.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/error/exception_to_error_key_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsageMonitorBloc extends Bloc<UsageMonitorEvent, UsageMonitorState> {
  final UsageMonitorRepository usageMonitorRepository;
  final ExceptionToErrorKeyMapper errorKeyMapper;

  UsageMonitorBloc(
    this.usageMonitorRepository,
    this.errorKeyMapper,
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
    } catch (e) {
      emit(
        UsageMonitorErrorState(
          errorKey: errorKeyMapper.map(e: e),
        ),
      );
    }
  }

  FutureOr<void> _onDeleteAllUsageMonitorEvent(
    final DeleteAllUsageMonitorEvent event,
    final Emitter<UsageMonitorState> emit,
  ) {}
}
