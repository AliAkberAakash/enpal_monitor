import 'package:enpal_design_system/styles/theme/theme.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/ui/screen/widget/y_axis_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  group('YAxisTitleWidget Tests', () {
    testWidgets('renders with correct value and title',
        (WidgetTester tester) async {
      const testValue = 6725;
      const testTitle = "w";
      final meta = TitleMeta(
        axisSide: AxisSide.bottom,
        appliedInterval: 1,
        formattedValue: '',
        max: 10000,
        min: 0,
        parentAxisSize: 100,
        axisPosition: 0,
        sideTitles: SideTitles(
          reservedSize: 20,
          showTitles: true,
          interval: 1000,
          getTitlesWidget: (value, meta) => YAxisTitleWidget(
            key: UniqueKey(),
            title: "w",
            value: value.toInt(),
            meta: meta,
          ),
          minIncluded: true,
          maxIncluded: true,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          themeMode: ThemeMode.light,
          theme: theme.light(),
          darkTheme: theme.dark(),
          home: Scaffold(
            body: YAxisTitleWidget(
              value: testValue,
              title: testTitle,
              meta: meta,
            ),
          ),
        ),
      );

      final textFinder = find.text("6725 w");
      final sideTitleWidgetFinder = find.byType(SideTitleWidget);

      expect(textFinder, findsOneWidget);
      expect(sideTitleWidgetFinder, findsOneWidget);

      final text = tester.widget<Text>(textFinder);
      expect(text.style?.color,
          theme.light().colorScheme.primary); // Default color scheme
    });

    testWidgets('applied dark theme properly', (WidgetTester tester) async {
      const testValue = 6725;
      const testTitle = "w";
      final meta = TitleMeta(
        axisSide: AxisSide.bottom,
        appliedInterval: 1,
        formattedValue: '',
        max: 10000,
        min: 0,
        parentAxisSize: 100,
        axisPosition: 0,
        sideTitles: SideTitles(
          reservedSize: 20,
          showTitles: true,
          interval: 1000,
          getTitlesWidget: (value, meta) => YAxisTitleWidget(
            key: UniqueKey(),
            title: "w",
            value: value.toInt(),
            meta: meta,
          ),
          minIncluded: true,
          maxIncluded: true,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          themeMode: ThemeMode.dark,
          theme: theme.light(),
          darkTheme: theme.dark(),
          home: Scaffold(
            body: YAxisTitleWidget(
              value: testValue,
              title: testTitle,
              meta: meta,
            ),
          ),
        ),
      );

      final textFinder = find.text("6725 w");
      final sideTitleWidgetFinder = find.byType(SideTitleWidget);

      expect(textFinder, findsOneWidget);
      expect(sideTitleWidgetFinder, findsOneWidget);

      final text = tester.widget<Text>(textFinder);
      expect(text.style?.color,
          theme.dark().colorScheme.primary); // Default color scheme
    });
  });
}
