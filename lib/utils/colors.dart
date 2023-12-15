import 'package:flutter/material.dart';

abstract class ColorTheme {
  static Color get commonWhite => Colors.white;

  static Color get textfieldBorder => const Color(0xffE4DFDF);

  static Color get textfieldBorderFocused => const Color(0xff534B4A);

  Color get primaryColor => const Color(0xffe28b2d);

  Color get errorColor => const Color(0xffd83300);

  Color get indicatorColor => const Color(0xff16d64c);

  Color get hintColor => const Color(0xffead907);

  Color get primaryColorLight;

  Color get primaryColorDark;

  Color get primaryIconTheme;

  Color get dividerColor;

  Color get focusColor;

  static ColorScheme get dark => DarkColorTheme._()._scheme;

  static ColorScheme get light => LightColorTheme._()._scheme;

  static ColorTheme color([bool isDark = false]) {
    return isDark ? DarkColorTheme._() : LightColorTheme._();
  }
}

class LightColorTheme extends ColorTheme {
  LightColorTheme._();

  @override
  Color get primaryColorLight => const Color(0xffffffff);

  @override
  Color get primaryColorDark => const Color(0xff2e2e2d);

  @override
  Color get primaryIconTheme => const Color(0xff3d3d3d);

  @override
  Color get dividerColor => const Color(0xffd8d2ca);

  @override
  Color get focusColor => const Color(0xff666766);

  ColorScheme get _scheme {
    return ColorScheme.light(
      primary: primaryColor,
      background: primaryColorLight,
      brightness: Brightness.light,
      error: errorColor,
      errorContainer: primaryColorDark,
      onBackground: primaryColorLight,
      secondary: primaryColorDark,
      primaryContainer: primaryColorLight,
    );
  }
}

class DarkColorTheme extends ColorTheme {
  DarkColorTheme._();

  ColorScheme get _scheme {
    return ColorScheme.dark(
      primary: primaryColor,
      background: primaryColorLight,
      brightness: Brightness.light,
      error: errorColor,
      errorContainer: primaryColorDark,
      onBackground: primaryColorLight,
      secondary: primaryColorDark,
      primaryContainer: primaryColorLight,
    );
  }

  @override
  Color get dividerColor => const Color(0xff666766);

  @override
  Color get focusColor => const Color(0xffebebeb);

  @override
  Color get primaryColorDark => const Color(0xffffffff);

  @override
  Color get primaryColorLight => const Color(0xff2e2e2d);

  @override
  Color get primaryIconTheme => const Color(0xffebebeb);
}
