import 'package:enpal_design_system/styles/util/extensions.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_bloc.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_state.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/ui/screen/widget/graph_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const double aspectRatio = 16.0 / 12.0;

class GraphScreen extends StatelessWidget {
  final String title;
  final UsageMonitorBloc usageMonitorBloc;

  const GraphScreen({
    super.key,
    required this.title,
    required this.usageMonitorBloc,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge,
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
    );
  }
}
