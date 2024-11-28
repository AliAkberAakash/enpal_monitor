import 'package:enpal_design_system/styles/util/extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class YAxisTitleWidget extends StatelessWidget {
  final int value;
  final String title;
  final TitleMeta meta;

  const YAxisTitleWidget({
    super.key,
    required this.value,
    required this.title,
    required this.meta,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        "$value $title",
        style: theme.textTheme.titleSmall!.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
