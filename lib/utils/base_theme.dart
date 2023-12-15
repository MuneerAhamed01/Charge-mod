import 'package:charge_mod/utils/colors.dart';
import 'package:flutter/material.dart';

class AppElevatedButtonTheme extends ElevatedButtonThemeData {
  AppElevatedButtonTheme()
      : super(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return null;
                } else {
                  return ColorTheme.color().primaryColor;
                }
              },
            ),
            elevation: const MaterialStatePropertyAll(0),
            foregroundColor: MaterialStateProperty.resolveWith(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return null;
                } else {
                  return ColorTheme.commonWhite;
                }
              },
            ),
          ),
        );
}

class AppBottomSheetTheme extends BottomSheetThemeData {
  final bool isDark;
  AppBottomSheetTheme(this.isDark)
      : super(backgroundColor: ColorTheme.color(isDark).primaryColorLight);
}

class AppLinerProgressIndicator extends ProgressIndicatorThemeData {
  final bool isDark;
  AppLinerProgressIndicator(this.isDark)
      : super(
          linearTrackColor: ColorTheme.color(isDark).dividerColor,
          refreshBackgroundColor: ColorTheme.color(isDark).focusColor,
        );
}
