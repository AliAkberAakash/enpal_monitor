import 'package:enpal_design_system/styles/util/extensions.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/date_selector_cubit/date_selector_cubit.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_bloc/usage_monitor_bloc.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_bloc/usage_monitor_state.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/ui/screen/widget/graph_widget.dart';
import 'package:enpal_monitor/features/usage_monitor/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

const double aspectRatio = 16.0 / 12.0;

class GraphScreen extends StatelessWidget {
  final String title;
  final UsageMonitorBloc usageMonitorBloc;
  final DateSelectorCubit dateSelectorCubit;
  final Future<void> Function() onRefresh;

  const GraphScreen({
    super.key,
    required this.title,
    required this.usageMonitorBloc,
    required this.onRefresh,
    required this.dateSelectorCubit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return RefreshIndicator(
      onRefresh: onRefresh,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge,
                ),
                BlocBuilder<DateSelectorCubit, DateTime>(
                  bloc: dateSelectorCubit,
                  builder: (ctx, state) {
                    final dateString = DateFormat(dateFormat).format(state);
                    return Text(
                      dateString,
                      style: theme.textTheme.titleSmall,
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: theme.spacingTokens.cwSpacing16,
            ),
            AspectRatio(
              aspectRatio: aspectRatio,
              child: BlocBuilder<UsageMonitorBloc, UsageMonitorState>(
                bloc: usageMonitorBloc,
                builder: (ctx, state) {
                  if (state is UsageMonitorLoadingState) {
                    // todo show loader
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is UsageMonitorLoadedState) {
                    return GraphWidget(
                      key: UniqueKey(),
                      points: state.usageData,
                    );
                  } else {
                    // todo show error
                    return Center(
                      child: Text("Failed to load graph data"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
