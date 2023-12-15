import 'package:charge_mod/controllers/theme_bloc/theme_bloc.dart';
import 'package:charge_mod/repositories/auth_repostiory.dart';
import 'package:charge_mod/repositories/user_repostiroy.dart';
import 'package:charge_mod/services/dio_service.dart';
import 'package:charge_mod/services/local_storage_service.dart';
import 'package:charge_mod/views/splash_screen/page/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final dio = BaseDioService.instance.dio;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(dio),
        ),
        RepositoryProvider(
          create: (_) => UserRepository(dio),
        )
      ],
      child: BlocProvider(
        create: _createThemeBloc,
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (_, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Charge Mode',
              theme: state.themeData,
              home: const SplashScreen(),
            );
          },
        ),
      ),
    );
  }

  ThemeBloc _createThemeBloc(context) {
    ThemeState themeState;
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    if (brightness == Brightness.light) {
      themeState = LightThemeState();
    } else {
      themeState = DarkThemeState();
    }
    return ThemeBloc(themeState);
  }
}
