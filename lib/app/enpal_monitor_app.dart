import 'package:enpal_design_system/styles/theme/theme.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/ui/screen/home_screen.dart';
import 'package:flutter/material.dart';

class EnpalMonitorApp extends StatelessWidget {
  const EnpalMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enpal Monitor',
      theme: theme.light(),
      darkTheme: theme.dark(),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
