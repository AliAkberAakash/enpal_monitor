import 'package:enpal_design_system/styles/util/extensions.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/entity/usage_monitor_entity.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/ui/screen/widget/x_axis_title_widget.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/ui/screen/widget/y_axis_title_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

const double maxYAxisValue = 10000;
const double minYAxisValue = 0;
const underGraphGradient = LinearGradient(
  colors: [
    Color(0x66448AFF),
    Color(0x66009688),
  ],
);
const lineGradient = LinearGradient(
  colors: [
    Color(0xFF448AFF),
    Color(0xFF009688),
  ],
);

class GraphWidget extends StatelessWidget {
  final List<UsageMonitorEntity> points;

  const GraphWidget({
    super.key,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return LineChart(
      LineChartData(
        maxY: maxYAxisValue,
        minY: minYAxisValue,
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            curveSmoothness: 0.05,
            spots: _aggregateData(),
            barWidth: 4,
            gradient: lineGradient,
            preventCurveOverShooting: true,
            belowBarData: BarAreaData(
              show: true,
              gradient: underGraphGradient,
            ),
            dotData: FlDotData(
              show: false,
            ),
          ),
        ],
        borderData: FlBorderData(
          show: true,
          border: Border(
            left: BorderSide(
              color: theme.colorScheme.primary,
              width: theme.spacingTokens.cwSpacing2,
            ),
            bottom: BorderSide(
              color: theme.colorScheme.primary,
              width: theme.spacingTokens.cwSpacing2,
            ),
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 30,
              showTitles: false,
              interval: 3600 * 4,
              getTitlesWidget: (value, meta) => XAxisTitleWidget(
                value: value,
                meta: meta,
              ),
              minIncluded: false,
              maxIncluded: false,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 60,
              showTitles: true,
              interval: 1000,
              getTitlesWidget: (value, meta) => YAxisTitleWidget(
                title: "w",
                value: value.toInt(),
                meta: meta,
              ),
              minIncluded: false,
              maxIncluded: false,
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (spots) {
              return spots
                  .map(
                    (spot) => LineTooltipItem(
                      spot.y.toString(),
                      theme.textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  )
                  .toList();
            },
          ),
        ),
        gridData: FlGridData(
          show: false,
        ),
      ), // Optional
    );
  }

  List<FlSpot> _aggregateData() {
    const int interval = 12; // 1 hour = 12 intervals of 5 minutes
    return List.generate((points.length / interval).ceil(), (index) {
      final sublist = points.skip(index * interval).take(interval);
      final avgValue = sublist.map((p) => p.value).reduce((a, b) => a + b) / sublist.length;
      return FlSpot(
        sublist.first.timestamp.toDouble(), // Use the timestamp of the first point in the interval
        avgValue,
      );
    });
  }

  List<FlSpot> _getSpotsWatt() {
    return points
        .asMap()
        .entries
        .where((entry) => entry.key % 9 == 0)
        .map(
          (point) => FlSpot(
            point.value.timestamp.toDouble(),
            point.value.value.toDouble(),
          ),
        )
        .toList();
  }
}
