import 'package:enpal_design_system/styles/util/extensions.dart';
import 'package:enpal_monitor/di/di.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/date_selector_cubit/date_selector_cubit.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_bloc/usage_monitor_bloc.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_bloc/usage_monitor_event.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/ui/screen/graph_screen.dart';
import 'package:enpal_monitor/features/usage_monitor/util/usage_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final UsageMonitorBloc _solarEnergyBloc = getIt.get(param1: UsageType.solar);
  final UsageMonitorBloc _homeConsumptionBloc =
      getIt.get(param1: UsageType.home);
  final UsageMonitorBloc _batteryConsumptionBloc =
      getIt.get(param1: UsageType.battery);
  final DateSelectorCubit _dateSelectorCubit = getIt.get();

  late final TabController _tabController;
  late final _tabs = [
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
    _loadUsageData(selectedDate: _dateSelectorCubit.state);
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

    return BlocListener<DateSelectorCubit, DateTime>(
      bloc: _dateSelectorCubit,
      listener: (ctx, state) {
        _loadUsageData(selectedDate: state);
      },
      child: Scaffold(
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
              onPressed: _changeUnit,
              icon: Icon(
                Icons.change_circle_outlined,
              ),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: _tabs,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(theme.spacingTokens.cwSpacing8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    GraphScreen(
                      key: UniqueKey(),
                      title: "Solar Generation",
                      usageMonitorBloc: _solarEnergyBloc,
                      dateSelectorCubit: _dateSelectorCubit,
                      onRefresh: _onSolarScreenRefresh,
                    ),
                    GraphScreen(
                      key: UniqueKey(),
                      title: "Home Consumption",
                      usageMonitorBloc: _homeConsumptionBloc,
                      dateSelectorCubit: _dateSelectorCubit,
                      onRefresh: _onHomeScreenRefresh,
                    ),
                    GraphScreen(
                      key: UniqueKey(),
                      title: "Battery Consumption",
                      usageMonitorBloc: _batteryConsumptionBloc,
                      dateSelectorCubit: _dateSelectorCubit,
                      onRefresh: _onBatteryScreenRefresh,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: theme.spacingTokens.cwSpacing24,
              ),
              MaterialButton(
                color: theme.colorScheme.errorContainer,
                onPressed: _showWarningDialog,
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Delete All Data",
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                  _deleteAllData();
                  Navigator.of(context).pop();
                }),
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
    _solarEnergyBloc.add(
      LoadUsageMonitorEvent(
        date: selectedDate,
      ),
    );
    _homeConsumptionBloc.add(
      LoadUsageMonitorEvent(
        date: selectedDate,
      ),
    );
    _batteryConsumptionBloc.add(
      LoadUsageMonitorEvent(
        date: selectedDate,
      ),
    );
  }

  void _showDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now(),
      currentDate: _dateSelectorCubit.state,
    );
    if (selectedDate != null) {
      _dateSelectorCubit.onDateChanged(selectedDate);
    }
  }

  Future<void> _onBatteryScreenRefresh() async {
    _batteryConsumptionBloc.add(
      LoadUsageMonitorEvent(
        date: _dateSelectorCubit.state,
      ),
    );
  }

  Future<void> _onHomeScreenRefresh() async {
    _homeConsumptionBloc.add(
      LoadUsageMonitorEvent(
        date: _dateSelectorCubit.state,
      ),
    );
  }

  Future<void> _onSolarScreenRefresh() async {
    _solarEnergyBloc.add(
      LoadUsageMonitorEvent(
        date: _dateSelectorCubit.state,
      ),
    );
  }

  void _deleteAllData() {
    _solarEnergyBloc.add(
      DeleteUsageMonitorEvent(
        _dateSelectorCubit.state,
      ),
    );
    _homeConsumptionBloc.add(
      DeleteUsageMonitorEvent(
        _dateSelectorCubit.state,
      ),
    );
    _batteryConsumptionBloc.add(
      DeleteUsageMonitorEvent(
        _dateSelectorCubit.state,
      ),
    );
  }

  void _changeUnit() {
    _solarEnergyBloc.add(
      ChangeUsageUnitEvent(),
    );
    _homeConsumptionBloc.add(
      ChangeUsageUnitEvent(),
    );
    _batteryConsumptionBloc.add(
      ChangeUsageUnitEvent(),
    );
  }
}
