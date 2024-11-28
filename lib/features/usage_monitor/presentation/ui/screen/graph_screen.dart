import 'package:enpal_design_system/styles/util/extensions.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/ui/screen/widget/graph_widget.dart';
import 'package:flutter/material.dart';

const double aspectRatio = 16.0 / 12.0;

class GraphScreen extends StatelessWidget {
  final String title;

  const GraphScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium,
        ),
        AspectRatio(
          aspectRatio: aspectRatio,
          child: GraphWidget(),
        ),
      ],
    );
  }
}
