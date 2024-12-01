import 'package:enpal_design_system/styles/util/extensions.dart';
import 'package:enpal_monitor/di/di.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_bloc.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_event.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/ui/screen/graph_screen.dart';
import 'package:enpal_monitor/features/usage_monitor/util/usage_type.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final UsageMonitorBloc solarEnergyBloc = getIt.get();
  final UsageMonitorBloc homeConsumptionBloc = getIt.get();
  final UsageMonitorBloc batteryConsumptionBloc = getIt.get();

  late final TabController _tabController;
  late final tabs = [
    Tab(text: "Solar", icon: Icon(Icons.sunny)),
    Tab(text: "Home", icon: Icon(Icons.home)),
    Tab(text: "Battery", icon: Icon(Icons.battery_charging_full)),
  ];

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    _loadUsageData(selectedDate: DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Enpal Monitor"),
        actions: [
          IconButton(
            onPressed: _showDatePicker,
            icon: Icon(
              Icons.calendar_today,
            ),
          ),
          IconButton(
            onPressed: _showWarningDialog,
            icon: Icon(
              Icons.delete_outline_outlined,
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(theme.spacingTokens.cwSpacing8),
        child: TabBarView(
          controller: _tabController,
          children: [
            GraphScreen(
              key: UniqueKey(),
              title: "Solar Generation",
              usageMonitorBloc: solarEnergyBloc,
            ),
            GraphScreen(
              key: UniqueKey(),
              title: "Home Consumption",
              usageMonitorBloc: homeConsumptionBloc,
            ),
            GraphScreen(
              key: UniqueKey(),
              title: "Battery Consumption",
              usageMonitorBloc: batteryConsumptionBloc,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showWarningDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Warning"),
          content: Text('Are you sure you want to delete all data?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadUsageData({
    required final DateTime selectedDate,
  }) async {
    solarEnergyBloc.add(
      LoadUsageMonitorEvent(
        date: selectedDate,
        type: UsageType.solar.name,
      ),
    );
    homeConsumptionBloc.add(
      LoadUsageMonitorEvent(
        date: selectedDate,
        type: UsageType.home.name,
      ),
    );
    batteryConsumptionBloc.add(
      LoadUsageMonitorEvent(
        date: selectedDate,
        type: UsageType.battery.name,
      ),
    );
  }

  void _showDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      _loadUsageData(selectedDate: selectedDate);
    }
  }
}
