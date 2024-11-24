import "package:flutter/material.dart";

import "../../tokens/color/reference_tokens.dart";
import "../../tokens/color/system_tokens_dark.dart";
import "../../tokens/color/system_tokens_light.dart";
import "../../tokens/typography/enpal_text_theme.dart";
import "../enpal_extension.dart";

class EnpalTheme {
  final TextTheme textTheme;

  const EnpalTheme(this.textTheme);

  static EnpalScheme lightScheme() {
    return const EnpalScheme(
      brightness: Brightness.light,
      primary: epSystemPrimaryLight,
      surfaceTint: epSystemPrimaryLight,
      onPrimary: epSystemOnPrimaryLight,
      primaryContainer: epSystemPrimaryContainerLight,
      onPrimaryContainer: epSystemOnPrimaryContainerLight,
      secondary: epSystemSecondaryLight,
      onSecondary: epSystemOnSecondaryLight,
      secondaryContainer: epSystemSecondaryContainerLight,
      onSecondaryContainer: epSystemOnSecondaryContainerLight,
      tertiary: epSystemTertiaryLight,
      onTertiary: epSystemOnTertiaryLight,
      tertiaryContainer: epSystemTertiaryContainerLight,
      onTertiaryContainer: epSystemOnTertiaryContainerLight,
      error: epSystemErrorLight,
      onError: epSystemOnErrorLight,
      errorContainer: epSystemErrorContainerLight,
      onErrorContainer: epSystemOnErrorContainerLight,
      background: epSystemBackgroundLight,
      onBackground: epSystemOnBackgroundLight,
      surface: epSystemSurfaceLight,
      onSurface: epSystemOnSurfaceLight,
      surfaceVariant: epSystemSurfaceVariantLight,
      onSurfaceVariant: epSystemOnSurfaceVariantLight,
      outline: epSystemOutlineLight,
      outlineVariant: epSystemOutlineVariantLight,
      shadow: epSystemShadowLight,
      scrim: epSystemScrimLight,
      inverseSurface: epSystemInverseSurfaceLight,
      inverseOnSurface: epSystemInverseOnSurfaceLight,
      inversePrimary: epSystemInversePrimaryLight,
      primaryFixed: epSystemPrimaryContainerLight,
      onPrimaryFixed: epSystemOnPrimaryContainerLight,
      primaryFixedDim: epSystemPrimaryLight,
      onPrimaryFixedVariant: epSystemOnPrimaryLight,
      secondaryFixed: epSystemSecondaryContainerLight,
      onSecondaryFixed: epSystemOnSecondaryContainerLight,
      secondaryFixedDim: epSystemSecondaryLight,
      onSecondaryFixedVariant: epSystemOnSecondaryLight,
      tertiaryFixed: epSystemTertiaryContainerLight,
      onTertiaryFixed: epSystemOnTertiaryContainerLight,
      tertiaryFixedDim: epSystemTertiaryLight,
      onTertiaryFixedVariant: epSystemOnTertiaryLight,
      surfaceDim: epSystemSurfaceDimLight,
      surfaceBright: epSystemSurfaceBrightLight,
      surfaceContainerLowest: epSystemSurfaceContainerLowestLight,
      surfaceContainerLow: epSystemSurfaceContainerLowLight,
      surfaceContainer: epSystemSurfaceContainerLight,
      surfaceContainerHigh: epSystemSurfaceContainerHighLight,
      surfaceContainerHighest: epSystemSurfaceContainerHighestLight,
      funkyContainer: epRefFunkyLight,
      funkyOnContainer: epRefOnFunkyLight,
    );
  }

  ThemeData light() {
    return theme(
      lightScheme().toColorScheme(),
      extensions: [
        EnpalExtensions(
          textTheme: textTheme,
          colorScheme: EnpalTheme.lightScheme(),
        ),
      ],
    );
  }

  static EnpalScheme darkScheme() {
    return const EnpalScheme(
      brightness: Brightness.dark,
      primary: epSystemPrimaryDark,
      surfaceTint: epSystemPrimaryDark,
      onPrimary: epSystemOnPrimaryDark,
      primaryContainer: epSystemPrimaryContainerDark,
      onPrimaryContainer: epSystemOnPrimaryContainerDark,
      secondary: epSystemSecondaryDark,
      onSecondary: epSystemOnSecondaryDark,
      secondaryContainer: epSystemSecondaryContainerDark,
      onSecondaryContainer: epSystemOnSecondaryContainerDark,
      tertiary: epSystemTertiaryDark,
      onTertiary: epSystemOnTertiaryDark,
      tertiaryContainer: epSystemTertiaryContainerDark,
      onTertiaryContainer: epSystemOnTertiaryContainerDark,
      error: epSystemErrorDark,
      onError: epSystemOnErrorDark,
      errorContainer: epSystemErrorContainerDark,
      onErrorContainer: epSystemOnErrorContainerDark,
      background: epSystemBackgroundDark,
      onBackground: epSystemOnBackgroundDark,
      surface: epSystemSurfaceDark,
      onSurface: epSystemOnSurfaceDark,
      surfaceVariant: epSystemSurfaceVariantDark,
      onSurfaceVariant: epSystemOnSurfaceVariantDark,
      outline: epSystemOutlineDark,
      outlineVariant: epSystemOutlineVariantDark,
      shadow: epSystemShadowDark,
      scrim: epSystemScrimDark,
      inverseSurface: epSystemInverseSurfaceDark,
      inverseOnSurface: epSystemInverseOnSurfaceDark,
      inversePrimary: epSystemInversePrimaryDark,
      primaryFixed: epSystemPrimaryContainerDark,
      onPrimaryFixed: epSystemOnPrimaryContainerDark,
      primaryFixedDim: epSystemPrimaryDark,
      onPrimaryFixedVariant: epSystemOnPrimaryDark,
      secondaryFixed: epSystemSecondaryContainerDark,
      onSecondaryFixed: epSystemOnSecondaryContainerDark,
      secondaryFixedDim: epSystemSecondaryDark,
      onSecondaryFixedVariant: epSystemOnSecondaryDark,
      tertiaryFixed: epSystemTertiaryContainerDark,
      onTertiaryFixed: epSystemOnTertiaryContainerDark,
      tertiaryFixedDim: epSystemTertiaryDark,
      onTertiaryFixedVariant: epSystemOnTertiaryDark,
      surfaceDim: epSystemSurfaceDimDark,
      surfaceBright: epSystemSurfaceBrightDark,
      surfaceContainerLowest: epSystemSurfaceContainerLowestDark,
      surfaceContainerLow: epSystemSurfaceContainerLowDark,
      surfaceContainer: epSystemSurfaceContainerDark,
      surfaceContainerHigh: epSystemSurfaceContainerHighDark,
      surfaceContainerHighest: epSystemSurfaceContainerHighestDark,
      funkyContainer: epRefFunkyDark,
      funkyOnContainer: epRefOnFunkyDark,
    );
  }

  ThemeData dark() {
    return theme(
      darkScheme().toColorScheme(),
      extensions: [
        EnpalExtensions(
          textTheme: textTheme,
          colorScheme: EnpalTheme.darkScheme(),
        ),
      ],
    );
  }

  ThemeData theme(
    ColorScheme colorScheme, {
    List<ThemeExtension> extensions = const [],
  }) =>
      ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
        extensions: extensions,
      );
}

class EnpalScheme {
  const EnpalScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    required this.funkyContainer,
    required this.funkyOnContainer,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
  final Color funkyContainer;
  final Color funkyOnContainer;

  EnpalScheme lerp(covariant EnpalScheme? other, double t) {
    if (other is! EnpalScheme) {
      return this;
    }

    return EnpalScheme(
      brightness: other.brightness,
      primary: Color.lerp(primary, other.primary, t)!,
      surfaceTint: Color.lerp(surfaceTint, other.surfaceTint, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryContainer:
          Color.lerp(primaryContainer, other.primaryContainer, t)!,
      onPrimaryContainer:
          Color.lerp(onPrimaryContainer, other.onPrimaryContainer, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      secondaryContainer:
          Color.lerp(secondaryContainer, other.secondaryContainer, t)!,
      onSecondaryContainer:
          Color.lerp(onSecondaryContainer, other.onSecondaryContainer, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      onTertiary: Color.lerp(onTertiary, other.onTertiary, t)!,
      tertiaryContainer:
          Color.lerp(tertiaryContainer, other.tertiaryContainer, t)!,
      onTertiaryContainer:
          Color.lerp(onTertiaryContainer, other.onTertiaryContainer, t)!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t)!,
      onErrorContainer:
          Color.lerp(onErrorContainer, other.onErrorContainer, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      onSurfaceVariant:
          Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
      inverseSurface: Color.lerp(inverseSurface, other.inverseSurface, t)!,
      inverseOnSurface:
          Color.lerp(inverseOnSurface, other.inverseOnSurface, t)!,
      inversePrimary: Color.lerp(inversePrimary, other.inversePrimary, t)!,
      primaryFixed: Color.lerp(primaryFixed, other.primaryFixed, t)!,
      onPrimaryFixed: Color.lerp(onPrimaryFixed, other.onPrimaryFixed, t)!,
      primaryFixedDim: Color.lerp(primaryFixedDim, other.primaryFixedDim, t)!,
      onPrimaryFixedVariant:
          Color.lerp(onPrimaryFixedVariant, other.onPrimaryFixedVariant, t)!,
      secondaryFixed: Color.lerp(secondaryFixed, other.secondaryFixed, t)!,
      onSecondaryFixed:
          Color.lerp(onSecondaryFixed, other.onSecondaryFixed, t)!,
      secondaryFixedDim:
          Color.lerp(secondaryFixedDim, other.secondaryFixedDim, t)!,
      onSecondaryFixedVariant: Color.lerp(
          onSecondaryFixedVariant, other.onSecondaryFixedVariant, t)!,
      tertiaryFixed: Color.lerp(tertiaryFixed, other.tertiaryFixed, t)!,
      onTertiaryFixed: Color.lerp(onTertiaryFixed, other.onTertiaryFixed, t)!,
      tertiaryFixedDim:
          Color.lerp(tertiaryFixedDim, other.tertiaryFixedDim, t)!,
      onTertiaryFixedVariant:
          Color.lerp(onTertiaryFixedVariant, other.onTertiaryFixedVariant, t)!,
      surfaceDim: Color.lerp(surfaceDim, other.surfaceDim, t)!,
      surfaceBright: Color.lerp(surfaceBright, other.surfaceBright, t)!,
      surfaceContainerLowest:
          Color.lerp(surfaceContainerLowest, other.surfaceContainerLowest, t)!,
      surfaceContainerLow:
          Color.lerp(surfaceContainerLow, other.surfaceContainerLow, t)!,
      surfaceContainer:
          Color.lerp(surfaceContainer, other.surfaceContainer, t)!,
      surfaceContainerHigh:
          Color.lerp(surfaceContainerHigh, other.surfaceContainerHigh, t)!,
      surfaceContainerHighest: Color.lerp(
          surfaceContainerHighest, other.surfaceContainerHighest, t)!,
      funkyContainer: Color.lerp(funkyContainer, other.funkyContainer, t)!,
      funkyOnContainer:
          Color.lerp(funkyOnContainer, other.funkyOnContainer, t)!,
    );
  }
}

extension MaterialSchemeUtils on EnpalScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

const theme = EnpalTheme(
  EnpalTextTheme.enpalTextTheme,
);
