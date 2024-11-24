import 'package:flutter/material.dart';

import '../enpal_extension.dart';

extension EnpalThemeExtension on BuildContext {
  EnpalExtensions get theme => Theme.of(this).extension<EnpalExtensions>()!;
}
