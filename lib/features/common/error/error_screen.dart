import 'package:enpal_design_system/styles/util/extensions.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;

  const ErrorScreen({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Center(
      child: Text(
        errorMessage,
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}
