import 'package:charge_mod/utils/colors.dart';
import 'package:flutter/material.dart';

class AppTextTheme extends TextTheme {
  // static AppTextTheme instance = const AppTextTheme.dark();

  const AppTextTheme.dark() : isDark = true;

  const AppTextTheme.light() : isDark = false;

  final bool isDark;

  static const String abeezee = 'ABeeZee-Regular';

  static const String airbnbCereal = 'AirbnbCereal';

  static const String poppins = 'Poppins';

  @override
  TextStyle? get displayLarge {
    return const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      fontFamily: airbnbCereal,
    );
  }

  @override
  TextStyle? get displayMedium {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w100,
      fontFamily: airbnbCereal,
    );
  }

  @override
  TextStyle? get headlineLarge {
    return TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.w700,
      letterSpacing: 1,
      color: ColorTheme.color(isDark).primaryColorDark,
      fontFamily: poppins,
    );
  }

  @override
  TextStyle? get titleLarge {
    return TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: ColorTheme.color(isDark).primaryColorDark,
        fontFamily: poppins);
  }

  @override
  TextStyle? get titleMedium {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 1,
      color: ColorTheme.color(isDark).primaryColorDark,
      fontFamily: poppins,
    );
  }

  @override
  TextStyle? get titleSmall {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: ColorTheme.color(isDark).primaryColorDark,
      fontFamily: poppins,
    );
  }

  @override
  TextStyle? get labelLarge {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 1,
      fontFamily: poppins,
    );
  }

  @override
  TextStyle? get labelMedium {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: ColorTheme.color(isDark).primaryColorDark,
      fontFamily: poppins,
    );
  }

  @override
  TextStyle? get labelSmall {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: ColorTheme.color(isDark).focusColor,
      fontFamily: poppins,
    );
  }

  @override
  TextStyle? get bodyLarge {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: abeezee,
      color: ColorTheme.color(isDark).primaryColorDark,
    );
  }

  @override
  TextStyle? get bodyMedium {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      fontFamily: abeezee,
      color: ColorTheme.color(isDark).primaryColorDark,
    );
  }

  @override
  TextStyle? get bodySmall {
    return TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.w400,
      color: ColorTheme.color(isDark).focusColor,
      fontFamily: poppins,
    );
  }
}
