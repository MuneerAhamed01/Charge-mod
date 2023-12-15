part of 'theme_bloc.dart';

sealed class ThemeState {
  final ThemeData themeData;

  bool get isDark => themeData is DarkThemeState;

  ThemeState(this.themeData);
}

final class LightThemeState extends ThemeState {
  LightThemeState()
      : super(
          ThemeData.light().copyWith(
              colorScheme: ColorTheme.light,
              elevatedButtonTheme: AppElevatedButtonTheme(),
              textTheme: const AppTextTheme.light(),
              scaffoldBackgroundColor: ColorTheme.color().primaryColorLight,
              bottomSheetTheme: AppBottomSheetTheme(false),
              progressIndicatorTheme: AppLinerProgressIndicator(false),
              focusColor: ColorTheme.color(false).focusColor,
              primaryIconTheme: IconThemeData(
                  color: ColorTheme.color(true).primaryIconTheme)),
        );
}

final class DarkThemeState extends ThemeState {
  DarkThemeState()
      : super(
          ThemeData.dark().copyWith(
            colorScheme: ColorTheme.dark,
            elevatedButtonTheme: AppElevatedButtonTheme(),
            textTheme: const AppTextTheme.dark(),
            scaffoldBackgroundColor: ColorTheme.color(true).primaryColorLight,
            bottomSheetTheme: AppBottomSheetTheme(true),
            progressIndicatorTheme: AppLinerProgressIndicator(true),
            focusColor: ColorTheme.color(true).focusColor,
            primaryIconTheme: IconThemeData(
                  color: ColorTheme.color(false).primaryIconTheme)

          ),
        );
}
