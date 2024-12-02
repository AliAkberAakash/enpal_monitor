import 'package:enpal_design_system/styles/util/extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class XAxisTitleWidget extends StatelessWidget {
  final double value;
  final TitleMeta meta;

  const XAxisTitleWidget({
    super.key,
    required this.value,
    required this.meta,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        _getFormattedTime(value.toInt()),
        style: theme.textTheme.titleSmall!.copyWith(
          color: theme.colorScheme.primary,
          fontSize: 12,
        ),
      ),
    );
  }

  String _getFormattedTime(int unixTimeStamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimeStamp * 1000);
    final timeString = "${dateTime.hour.toString().padLeft(2, '0')}:00";
    return timeString;
  }
}
