import 'package:charge_mod/repositories/auth_repostiory.dart';
import 'package:charge_mod/repositories/user_repostiroy.dart';
import 'package:charge_mod/utils/assets.dart';
import 'package:charge_mod/utils/colors.dart';
import 'package:charge_mod/views/authentication/bloc/auth_bloc/auth_bloc.dart';
import 'package:charge_mod/views/authentication/bloc/mobile_number_bloc/mobile_number_bloc.dart';
import 'package:charge_mod/views/authentication/pages/login_entry_page.dart';
import 'package:charge_mod/views/profile/log_out_bloc/log_out_bloc.dart';
import 'package:charge_mod/views/profile/utils/profile_items.dart';
import 'package:charge_mod/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Hello',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Theme.of(context).focusColor),
              ),
            ),
            Center(
              child: Text(
                context.user?.userFullName ?? '',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 24),

            // Build the plus UI

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: ProfileListWidget(
                items: ProfileItems.accountsSection(),
              ),
            ),

            const SizedBox(height: 21),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: SizedBox(
                height: 38,
                width: double.infinity,
                child: PrimaryButton(
                  buttonText: 'Buy Machines From chargeMOD',
                  onTap: () {},
                ),
              ),
            ),
            const SizedBox(height: 21),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: ProfileListWidget(
                items: ProfileItems.deviceAndOrderSection(),
              ),
            ),

            const SizedBox(height: 21),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: ProfileListWidget(
                items: ProfileItems.customerSupportSection(),
              ),
            ),

            const SizedBox(height: 21),

            BlocConsumer<LogoutBloc, LogoutState>(listener: (context, state) {
              if (state is LogoutSuccessState) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                              create: (_) =>
                                  AuthBloc(context.read<AuthRepository>())),
                          BlocProvider(create: (_) => MobileNumberBloc()),
                        ],
                        child: const LoginEntry(),
                      ),
                    ),
                    (route) => false);
              }
            }, builder: (_, state) {
              return IgnorePointer(
                ignoring: state is LogoutLoadingState,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: SizedBox(
                    height: 38,
                    width: double.infinity,
                    child: PrimaryButton(
                      isLoading: state is LogoutLoadingState,
                      buttonText: 'Logout',
                      onTap: () {
                        context.read<LogoutBloc>().add(LogoutTapEvent());
                      },
                      icon: SvgAssets.logOutIcon,
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 45),

            SvgPicture.asset(
              SvgAssets.chargeModIcon,
              colorFilter: ColorFilter.mode(
                ColorTheme.color().primaryColor,
                BlendMode.srcIn,
              ),
            ),

            const SizedBox(height: 18),

            //TODO: CHANGE TO PLATFORM PACKAGE IF TIME
            Text(
              'V 1.0.0 (001)',
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
            ),

            const SizedBox(height: 18),
            Text(
              'Copyright © 2022 BPM Power Pvt Ltd.\nAll rights reserved.',
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

class ProfileListWidget extends StatelessWidget {
  const ProfileListWidget({super.key, required this.items});

  final List<ProfileItems> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary.withOpacity(.2),
            blurRadius: 5,
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return _buildTile(context, items[index]);
        },
        separatorBuilder: (_, __) => Divider(
          color: Theme.of(context).focusColor,
          thickness: 0.5,
        ),
        itemCount: items.length,
      ),
    );
  }

  ListTile _buildTile(BuildContext context, ProfileItems item) {
    return ListTile(
      dense: false,
      leading: CircleAvatar(
        radius: 19.5,
        backgroundColor: Theme.of(context).primaryIconTheme.color,
        child: SvgPicture.asset(
          item.icon,
          colorFilter: item.title != 'My Electric Vehicles'
              ? ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary,
                  BlendMode.srcIn,
                )
              : null,
        ),
      ),
      title: Text(
        item.title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      trailing: SvgPicture.asset(
        SvgAssets.rightArrow,
        colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
      ),
    );
  }
}
