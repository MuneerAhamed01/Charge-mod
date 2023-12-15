import 'package:charge_mod/controllers/theme_bloc/theme_bloc.dart';
import 'package:charge_mod/repositories/auth_repostiory.dart';
import 'package:charge_mod/repositories/location_repostiory.dart';
import 'package:charge_mod/repositories/user_repostiroy.dart';
import 'package:charge_mod/services/dio_service.dart';
import 'package:charge_mod/services/local_storage_service.dart';
import 'package:charge_mod/utils/assets.dart';
import 'package:charge_mod/utils/colors.dart';
import 'package:charge_mod/views/authentication/bloc/auth_bloc/auth_bloc.dart';
import 'package:charge_mod/views/authentication/bloc/mobile_number_bloc/mobile_number_bloc.dart';
import 'package:charge_mod/views/authentication/pages/login_entry_page.dart';
import 'package:charge_mod/views/home_screen/bloc/location_bloc/location_bloc.dart';
import 'package:charge_mod/views/main_screen/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:charge_mod/views/main_screen/bloc/profile_bloc/profile_bloc_bloc.dart';
import 'package:charge_mod/views/main_screen/main_screeen.dart';
import 'package:charge_mod/views/onboarding/bloc/dot_indicator_bloc/dot_indicator_bloc.dart';
import 'package:charge_mod/views/onboarding/pages/onbaording.dart';
import 'package:charge_mod/views/profile/log_out_bloc/log_out_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        String logo =
            state is LightThemeState ? SvgAssets.logoLight : SvgAssets.logoDark;
        return Scaffold(
          body: Center(
            child: SvgPicture.asset(logo),
          ),
          bottomSheet: Container(
            alignment: Alignment.bottomCenter,
            height: 60,
            color: ColorTheme.color(state is LightThemeState).primaryColorDark,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TweenAnimationBuilder<double>(
                    onEnd: () => _onEndProgress(context),
                    duration: const Duration(seconds: 5),
                    curve: Curves.easeInOut,
                    tween: Tween<double>(
                      begin: 0,
                      end: 1,
                    ),
                    builder: (context, value, _) {
                      return SizedBox(
                        width: 226,
                        child: LinearProgressIndicator(
                          value: value,
                        ),
                      );
                    }),
                const SizedBox(height: 7),
                Text(
                  'Connecting to chargeMOD',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                      ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onEndProgress(BuildContext context) async {
    LocalStorageService.getInstance().then(
      (value) {
        // Show the onboarding at the first time
        if (!value.getOnBoardingStatus()) {
          return Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => BlocProvider<DotIndicatorBloc>(
                create: (_) => DotIndicatorBloc(),
                child: const Onboarding(),
              ),
            ),
          );
        }

        // if user is null then go to the login page
        if (value.getUserStatus() == null) {
          final authRepo = context.read<AuthRepository>();
          return Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => AuthBloc(authRepo)),
                  BlocProvider(create: (_) => MobileNumberBloc()),
                ],
                child: const LoginEntry(),
              ),
            ),
          );
        }
        // Else go to the main page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => RepositoryProvider(
              create: (context) =>
                  LocationRepository(dio: BaseDioService.instance.dio),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => BottomNavBloc()),
                  BlocProvider(
                    create: (context) =>
                        ProfileBlocBloc(context.read<UserRepository>()),
                  ),
                  BlocProvider(
                    create: (context) =>
                        LocationBloc(context.read<LocationRepository>()),
                  ),
                  BlocProvider(
                    create: (context) => LogoutBloc(
                        context.read<AuthRepository>(),
                        context.read<UserRepository>()),
                  ),
                ],
                child: const MainScreen(),
              ),
            ),
          ),
        );
      },
    );
  }
}
