import 'package:enpal_design_system/styles/util/extensions.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/ui/screen/widget/x_axis_title_widget.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/ui/screen/widget/y_axis_title_widget.dart';
import 'package:enpal_monitor/features/usage_monitor/util/usage_unit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

const double maxYAxisValueForWatt = 10000;
const double maxYAxisValueForKiloWatt = 13;
const double yAxisDifferenceForWatt = 1000;
const double yAxisDifferenceForKiloWatt = 1;
const double leftTitleSizeForWatt = 60;
const double leftTitleSizeForKiloWatt = 50;
const double minYAxisValue = 0;
const _interval = 4 * 60 * 60 * 1000.0;
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
  final List<FlSpot> points;
  final UsageUnit usageUnit;

  const GraphWidget({
    super.key,
    required this.points,
    required this.usageUnit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return LineChart(
      chartRendererKey: UniqueKey(),
      LineChartData(
        maxY: usageUnit == UsageUnit.watt
            ? maxYAxisValueForWatt
            : maxYAxisValueForKiloWatt,
        minY: minYAxisValue,
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            curveSmoothness: 0.5,
            spots: points,
            barWidth: 6,
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
              showTitles: true,
              interval: _interval,
              getTitlesWidget: (value, meta) => XAxisTitleWidget(
                key: UniqueKey(),
                value: value,
                meta: meta,
              ),
              minIncluded: true,
              maxIncluded: false,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: usageUnit == UsageUnit.watt
                  ? leftTitleSizeForWatt
                  : leftTitleSizeForKiloWatt,
              showTitles: true,
              interval: usageUnit == UsageUnit.watt
                  ? yAxisDifferenceForWatt
                  : yAxisDifferenceForKiloWatt,
              getTitlesWidget: (value, meta) => YAxisTitleWidget(
                key: UniqueKey(),
                title: usageUnit.value,
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
          show: true,
        ),
      ), // Optional
    );
  }
}
