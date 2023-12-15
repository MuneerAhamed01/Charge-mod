import 'package:charge_mod/repositories/auth_repostiory.dart';
import 'package:charge_mod/services/local_storage_service.dart';
import 'package:charge_mod/utils/assets.dart';
import 'package:charge_mod/utils/colors.dart';
import 'package:charge_mod/views/authentication/bloc/auth_bloc/auth_bloc.dart';
import 'package:charge_mod/views/authentication/pages/login_entry_page.dart';
import 'package:charge_mod/views/onboarding/bloc/dot_indicator_bloc/dot_indicator_bloc.dart';
import 'package:charge_mod/views/onboarding/model/onboarding_item_model.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../authentication/bloc/mobile_number_bloc/mobile_number_bloc.dart';
import '../widgets/onboarding_item.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Center(
            child: GestureDetector(
              onTap: _goToLogin,
              child: Text(
                'SKIP',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ),
          ),
          const SizedBox(width: 29)
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            ImageAssets.onboardingBackground,
            fit: BoxFit.cover,
            width: MediaQuery.sizeOf(context).width,
          ),
          PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (value) {
              context.read<DotIndicatorBloc>().add(ChangeActiveDotEvent(value));
            },
            itemBuilder: (_, index) => OnboardingItem(
              onboardingData: OnboardingItemModel.data[index],
            ),
            itemCount: 3,
          ),
          BlocBuilder<DotIndicatorBloc, DotIndicatorState>(
            builder: (context, state) {
              final activeState = state as ActiveDotState;
              return Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: state.activeIndex != 0,
                          replacement: const SizedBox(width: 52),
                          child: GestureDetector(
                            onTap: () {
                              final int jumpToPage = state.activeIndex - 1;
                              _pageController.jumpToPage(jumpToPage);
                            },
                            child: CircleAvatar(
                              radius: 26,
                              backgroundColor: ColorTheme.color().primaryColor,
                              child: SvgPicture.asset(SvgAssets.leftArrow),
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        Center(
                          child: DotsIndicator(
                            dotsCount: 3,
                            position: activeState.activeIndex,
                            decorator: DotsDecorator(
                                activeColor:
                                    Theme.of(context).colorScheme.secondary,
                                activeSize: const Size(12, 12),
                                color: Theme.of(context).focusColor,
                                size: const Size(8, 8)),
                          ),
                        ),
                        const SizedBox(width: 40),
                        GestureDetector(
                          onTap: () {
                            final int jumpToPage = state.activeIndex + 1;
                            if (jumpToPage > 2) {
                              _goToLogin();
                            } else {
                              _pageController.jumpToPage(jumpToPage);

                              context
                                  .read<DotIndicatorBloc>()
                                  .add(ChangeActiveDotEvent(jumpToPage));
                            }
                          },
                          child: CircleAvatar(
                            radius: 26,
                            backgroundColor: ColorTheme.color().primaryColor,
                            child: SvgPicture.asset(SvgAssets.rightArrow),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16)
                  ],
                ),
              );
            },
          ),
        ],
      ),
      // bottomSheet:
    );
  }

  void _goToLogin() {
    LocalStorageService.instance.addOnboardingStatus(true);
    final authRepo = context.read<AuthRepository>();
    Navigator.of(context).pushReplacement(
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
}
