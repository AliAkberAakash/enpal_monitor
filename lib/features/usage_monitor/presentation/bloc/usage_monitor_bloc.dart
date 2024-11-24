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
    } on BaseError catch (e) {
      emit(
        UsageMonitorErrorState(
          error: e,
        ),
      );
    } catch (e) {
      emit(
        UsageMonitorErrorState(
          error: CommonError(),
        ),
      );
    }
  }

  FutureOr<void> _onDeleteAllUsageMonitorEvent(
    final DeleteAllUsageMonitorEvent event,
    final Emitter<UsageMonitorState> emit,
  ) {}
}
