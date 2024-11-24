
import "package:enpal_design_system/styles/theme/theme.dart";
import "package:flutter/material.dart";

import "../tokens/border_radius/border_radius_tokens.dart";
import "../tokens/border_width/border_width_tokens.dart";
import "../tokens/elevation/elevation_tokens.dart";
import "../tokens/icon_size/icon_size_tokens.dart";
import "../tokens/opacity/opacity_tokens.dart";
import "../tokens/spacing/spacing_tokens.dart";

class EnpalExtensions extends ThemeExtension<EnpalExtensions> {
  final EnpalScheme colorScheme;
  final TextTheme textTheme;
  late final ElevationTokens elevationTokens;
  late final BorderRadiusTokens borderRadiusTokens;
  late final BorderWidthTokens borderWidthTokens;
  late final OpacityTokens opacityTokens;
  late final SpacingTokens spacingTokens;
  late final IconSizeTokens iconSizeTokens;

  EnpalExtensions({
    required this.colorScheme,
    required this.textTheme,
  }) {
    elevationTokens = ElevationTokens();
    borderRadiusTokens = BorderRadiusTokens();
    borderWidthTokens = BorderWidthTokens();
    opacityTokens = OpacityTokens();
    spacingTokens = SpacingTokens();
    iconSizeTokens = IconSizeTokens();
  }

  @override
  EnpalExtensions copyWith({
    EnpalScheme? colorScheme,
  }) {
    return EnpalExtensions(
      textTheme: textTheme,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }

  @override
  EnpalExtensions lerp(
      covariant ThemeExtension<EnpalExtensions>? other, double t) {
    if (other is! EnpalExtensions) {
      return this;
    }

    return EnpalExtensions(
      textTheme: textTheme,
      colorScheme: colorScheme.lerp(other.colorScheme, t),
    );
  }
}
