import 'package:enpal_design_system/styles/theme/theme.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/ui/screen/widget/x_axis_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  group('XAxisTitleWidget Tests', () {
    testWidgets('renders with correct formatted time and style',
        (WidgetTester tester) async {
      const testValue = 1633072800;
      final meta = TitleMeta(
        axisSide: AxisSide.bottom,
        appliedInterval: 1,
        formattedValue: '',
        max: 10,
        min: 0,
        parentAxisSize: 100,
        axisPosition: 0,
        sideTitles: SideTitles(
          reservedSize: 30,
          showTitles: true,
          interval: 100,
          getTitlesWidget: (value, meta) => XAxisTitleWidget(
            key: UniqueKey(),
            value: value,
            meta: meta,
          ),
          minIncluded: true,
          maxIncluded: true,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: ThemeMode.light,
          home: Scaffold(
            body: XAxisTitleWidget(
              value: testValue.toDouble(),
              meta: meta,
            ),
          ),
        ),
      );

      final textFinder = find.text("09:00");
      final sideTitleWidgetFinder = find.byType(SideTitleWidget);

      expect(textFinder, findsOneWidget);
      expect(sideTitleWidgetFinder, findsOneWidget);

      final text = tester.widget<Text>(textFinder);
      expect(text.style?.fontSize, 12);
      expect(text.style?.color,
          theme.light().colorScheme.primary); // Default color scheme
    });

    testWidgets('applies dark theme properly', (WidgetTester tester) async {
      const testValue = 1633072800;
      final meta = TitleMeta(
        axisSide: AxisSide.bottom,
        appliedInterval: 1,
        formattedValue: '',
        max: 10,
        min: 0,
        parentAxisSize: 100,
        axisPosition: 0,
        sideTitles: SideTitles(
          reservedSize: 30,
          showTitles: true,
          interval: 100,
          getTitlesWidget: (value, meta) => XAxisTitleWidget(
            key: UniqueKey(),
            value: value,
            meta: meta,
          ),
          minIncluded: true,
          maxIncluded: true,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: ThemeMode.dark,
          home: Scaffold(
            body: XAxisTitleWidget(
              value: testValue.toDouble(),
              meta: meta,
            ),
          ),
        ),
      );

      final textFinder = find.text("09:00");
      final sideTitleWidgetFinder = find.byType(SideTitleWidget);

      expect(textFinder, findsOneWidget);
      expect(sideTitleWidgetFinder, findsOneWidget);

      final text = tester.widget<Text>(textFinder);
      expect(text.style?.fontSize, 12);
      expect(text.style?.color,
          theme.dark().colorScheme.primary); // Default color scheme
    });
  });
}
