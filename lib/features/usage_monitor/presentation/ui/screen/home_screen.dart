import 'package:enpal_design_system/styles/util/extensions.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/ui/screen/graph_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
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
    _tabController.addListener(() {});
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
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(theme.spacingTokens.cwSpacing8),
        child: TabBarView(
          controller: _tabController,
          children: tabs.map((Tab tab) {
            return GraphScreen(
              title: tab.text ?? "",
            );
          }).toList(),
        ),
      ),
    );
  }
}
