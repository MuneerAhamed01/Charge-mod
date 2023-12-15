import 'package:charge_mod/utils/base_theme.dart';
import 'package:charge_mod/utils/colors.dart';
import 'package:charge_mod/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

enum ThemeEvents { toggleDark, toggleLight }

class ThemeBloc extends Bloc<ThemeEvent, ThemeState>
    with WidgetsBindingObserver {
  ThemeBloc(ThemeState theme) : super(theme) {
    WidgetsBinding.instance.addObserver(this);
    on<ChangeThemeEvent>(_onChangeTheme);
  }

  _onChangeTheme(ChangeThemeEvent even, Emitter<ThemeState> emit) {
    if (state is LightThemeState) {
      return emit(DarkThemeState());
    } else {
      return emit(LightThemeState());
    }
  }

  @override
  void didChangePlatformBrightness() {
    add(ChangeThemeEvent());
    super.didChangePlatformBrightness();
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}
