import 'package:enpal_design_system/styles/util/extensions.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/ui/screen/widget/x_axis_title_widget.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/ui/screen/widget/y_axis_title_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

const double maxYAxisValue = 10000;
const double minYAxisValue = 0;
const underGraphGradient = LinearGradient(
  colors: [
    Color(0x66009688),
    Color(0x66448AFF),
  ],
);
const lineGradient = LinearGradient(
  colors: [
    Color(0xFF009688),
    Color(0xFF448AFF),
  ],
);

class GraphWidget extends StatefulWidget {
  const GraphWidget({super.key});

  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
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
            spots: _getSpotsWatt(),
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
              showTitles: true,
              interval: 3600,
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

  List<FlSpot> _getSpotsWatt() => [
        FlSpot(1697769600, 2744), // "2024-10-20T00:00:00.000Z"
        FlSpot(1697769900, 6033), // "2024-10-20T00:05:00.000Z"
        FlSpot(1697770200, 6753), // "2024-10-20T00:10:00.000Z"
        FlSpot(1697770500, 5476), // "2024-10-20T00:15:00.000Z"
        FlSpot(1697770800, 2191), // "2024-10-20T00:20:00.000Z"
        FlSpot(1697771100, 6448), // "2024-10-20T00:25:00.000Z"
        FlSpot(1697771400, 3482), // "2024-10-20T00:30:00.000Z"
        FlSpot(1697771700, 7836), // "2024-10-20T00:35:00.000Z"
        FlSpot(1697772000, 1296), // "2024-10-20T00:40:00.000Z"
        FlSpot(1697772300, 8772), // "2024-10-20T00:45:00.000Z"
        FlSpot(1697772600, 3718), // "2024-10-20T00:50:00.000Z"
        FlSpot(1697772900, 8602), // "2024-10-20T00:55:00.000Z"
        FlSpot(1697773200, 2105), // "2024-10-20T01:00:00.000Z"
        FlSpot(1697773500, 1879), // "2024-10-20T01:05:00.000Z"
        FlSpot(1697773800, 3963), // "2024-10-20T01:10:00.000Z"
        FlSpot(1697774100, 1880), // "2024-10-20T01:15:00.000Z"
        FlSpot(1697774400, 8114), // "2024-10-20T01:20:00.000Z"
        FlSpot(1697774700, 6610), // "2024-10-20T01:25:00.000Z"
        FlSpot(1697775000, 2915), // "2024-10-20T01:30:00.000Z"
        FlSpot(1697775300, 5051), // "2024-10-20T01:35:00.000Z"
        FlSpot(1697775600, 5167), // "2024-10-20T01:40:00.000Z"
        FlSpot(1697775900, 7377), // "2024-10-20T01:45:00.000Z"
        FlSpot(1697776200, 3557), // "2024-10-20T01:50:00.000Z"
        FlSpot(1697776500, 1505), // "2024-10-20T01:55:00.000Z"
        FlSpot(1697776800, 7411), // "2024-10-20T02:00:00.000Z"
        FlSpot(1697777100, 2854), // "2024-10-20T02:05:00.000Z"
        FlSpot(1697777400, 6604), // "2024-10-20T02:10:00.000Z"
        FlSpot(1697777700, 2696), // "2024-10-20T02:15:00.000Z"
        FlSpot(1697778000, 1908), // "2024-10-20T02:20:00.000Z"
        FlSpot(1697778300, 7234), // "2024-10-20T02:25:00.000Z"
        FlSpot(1697778600, 7457), // "2024-10-20T02:30:00.000Z"
        FlSpot(1697778900, 8686), // "2024-10-20T02:35:00.000Z"
        FlSpot(1697779200, 3694), // "2024-10-20T02:40:00.000Z"
        FlSpot(1697779500, 7281), // "2024-10-20T02:45:00.000Z"
        FlSpot(1697779800, 7368), // "2024-10-20T02:50:00.000Z"
        FlSpot(1697780100, 4011), // "2024-10-20T02:55:00.000Z"
        FlSpot(1697780400, 4946), // "2024-10-20T03:00:00.000Z"
        FlSpot(1697780700, 5808), // "2024-10-20T03:05:00.000Z"
        FlSpot(1697781000, 1994), // "2024-10-20T03:10:00.000Z"
        FlSpot(1697781300, 3453), // "2024-10-20T03:15:00.000Z"
        FlSpot(1697781600, 7129), // "2024-10-20T03:20:00.000Z"
        FlSpot(1697781900, 7125), // "2024-10-20T03:25:00.000Z"
        FlSpot(1697782200, 8798), // "2024-10-20T03:30:00.000Z"
        FlSpot(1697782500, 2872), // "2024-10-20T03:35:00.000Z"
        FlSpot(1697782800, 7497), // "2024-10-20T03:40:00.000Z"
        FlSpot(1697783100, 3919), // "2024-10-20T03:45:00.000Z"
        FlSpot(1697783400, 7588), // "2024-10-20T03:50:00.000Z"
        FlSpot(1697783700, 2278), // "2024-10-20T03:55:00.000Z"
        FlSpot(1697784000, 4293), // "2024-10-20T04:00:00.000Z"
        FlSpot(1697784300, 2309), // "2024-10-20T04:05:00.000Z"
        FlSpot(1697784600, 5050), // "2024-10-20T04:10:00.000Z"
        FlSpot(1697784900, 3822), // "2024-10-20T04:15:00.000Z"
        FlSpot(1697785200, 3102), // "2024-10-20T04:20:00.000Z"
        FlSpot(1697785500, 3573), // "2024-10-20T04:25:00.000Z"
        FlSpot(1697785800, 6745), // "2024-10-20T04:30:00.000Z"
        FlSpot(1697786100, 7497), // "2024-10-20T04:35:00.000Z"
        FlSpot(1697786400, 7047), // "2024-10-20T04:40:00.000Z"
        FlSpot(1697786700, 6822), // "2024-10-20T04:45:00.000Z"
        FlSpot(1697787000, 3017), // "2024-10-20T04:50:00.000Z"
        FlSpot(1697787300, 8802), // "2024-10-20T04:55:00.000Z"
        FlSpot(1697787600, 2517), // "2024-10-20T05:00:00.000Z"
        FlSpot(1697787900, 2520), // "2024-10-20T05:05:00.000Z"
        FlSpot(1697788200, 7646), // "2024-10-20T05:10:00.000Z"
        FlSpot(1697788500, 2278), // "2024-10-20T05:15:00.000Z"
        FlSpot(1697788800, 5914), // "2024-10-20T05:20:00.000Z"
        FlSpot(1697789100, 1969), // "2024-10-20T05:25:00.000Z"
        FlSpot(1697789400, 7799), // "2024-10-20T05:30:00.000Z"
        FlSpot(1697789700, 2240), // "2024-10-20T05:35:00.000Z"
        FlSpot(1697790000, 2506), // "2024-10-20T05:40:00.000Z"
        FlSpot(1697790300, 2200), // "2024-10-20T05:45:00.000Z"
        FlSpot(1697790600, 8312), // "2024-10-20T05:50:00.000Z"
        FlSpot(1697790900, 3087), // "2024-10-20T05:55:00.000Z"
      ];
}
