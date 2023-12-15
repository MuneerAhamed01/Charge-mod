import 'package:charge_mod/controllers/theme_bloc/theme_bloc.dart';
import 'package:charge_mod/utils/colors.dart';
import 'package:charge_mod/views/onboarding/model/onboarding_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    super.key,
    required this.onboardingData,
  });
  final OnboardingItemModel onboardingData;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final String image = state is LightThemeState
            ? onboardingData.imageDark ?? onboardingData.image
            : onboardingData.image;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                onboardingData.titleSmall,
                style: Theme.of(context)
                    .textTheme
                    
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              onboardingData.titleLarge,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 40),
            ),
            Text(
              onboardingData.titleLarge2,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 40,
                    color: ColorTheme.color().primaryColor,
                  ),
            ),
            const SizedBox(height: 16),
            Transform.translate(
              offset: const Offset(-10, 0),
              child: Image.asset(
                image,
                // fit: BoxFit.cover,
                width: 280,
                height: 300,
              ),
            ),
            // const SizedBox(height: 40),
            Text(
              onboardingData.subTitle,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 15, height: 1.5),
              textAlign: TextAlign.center,
            )
          ],
        );
      },
    );
  }
}
