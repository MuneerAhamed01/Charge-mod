import 'package:charge_mod/repositories/user_repostiroy.dart';
import 'package:charge_mod/utils/assets.dart';
import 'package:charge_mod/utils/colors.dart';
import 'package:charge_mod/views/edit_pofile/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:charge_mod/views/edit_pofile/bloc/form_field_bloc/form_field_bloc.dart';
import 'package:charge_mod/views/home_screen/home.dart';
import 'package:charge_mod/views/main_screen/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:charge_mod/views/main_screen/bloc/profile_bloc/profile_bloc_bloc.dart';
import 'package:charge_mod/views/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../edit_pofile/edit_profil_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return BlocConsumer<ProfileBlocBloc, ProfileBlocState>(
          listener: _profileListener,
          buildWhen: (previous, current) {
            return current is ProfileInitLoadingState ||
                current is ProfileInitSuccessState;
          },
          builder: (context, profileState) {
            if (profileState is ProfileInitLoadingState) {
              return const Material(
                child: Center(child: CircularProgressIndicator.adaptive()),
              );
            }
            return Scaffold(
              body: pages[state.index],
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: BottomNavigationBar(
                  onTap: (value) {
                    context
                        .read<BottomNavBloc>()
                        .add(BottomNavigationChangeEvent(value));
                  },
                  currentIndex: state.index,
                  selectedLabelStyle:
                      Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: 12,
                            color: ColorTheme.color().primaryColor,
                            fontWeight: FontWeight.w300,
                          ),
                  unselectedLabelStyle:
                      Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).focusColor,
                          ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                        icon: _buildSvg(
                            SvgAssets.homeIcon, context, state.index == 0),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: _buildSvg(SvgAssets.activityIcon, context,
                              state.index == 1),
                        ),
                        label: 'Activity'),
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: _buildSvg(SvgAssets.communityIcon, context,
                              state.index == 2),
                        ),
                        label: 'Community'),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: _buildSvg(
                            SvgAssets.profileIcon, context, state.index == 3),
                      ),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Padding _buildSvg(String icon, BuildContext context,
      [bool isSelected = false]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
            isSelected
                ? ColorTheme.color().primaryColor
                : Theme.of(context).focusColor,
            BlendMode.srcIn),
      ),
    );
  }

  _profileListener(BuildContext context, ProfileBlocState profileState) {
    if (profileState is ProfileInitUseFailedState) {
      if (profileState.mobileNumber == null) {
        return;
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (_) => FormFieldBloc(profileState.mobileNumber!)),
                BlocProvider(
                  create: (_) => EditProfileBloc(
                    context.read<UserRepository>(),
                  ),
                )
              ],
              child: const EditUserPage(),
            );
          },
        ),
      );
    }
  }

  List<Widget> get pages {
    return [
      const HomeScreen(),
      const Center(child: Text('Activity')),
      const Center(child: Text('Community')),
      const ProfilePage(),
    ];
  }
}
