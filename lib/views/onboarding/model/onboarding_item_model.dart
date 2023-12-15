import 'package:charge_mod/utils/assets.dart';

class OnboardingItemModel {
  final String titleSmall;

  final String titleLarge;

  final String titleLarge2;

  final String? imageDark;

  final String image;

  final String subTitle;

  OnboardingItemModel({
    required this.titleSmall,
    required this.titleLarge,
    required this.titleLarge2,
    this.imageDark,
    required this.image,
    required this.subTitle,
  });

  static List<OnboardingItemModel> get data {
    return [
      OnboardingItemModel(
        titleSmall: 'Charge your EV',
        titleLarge: 'At Your',
        titleLarge2: 'Fingertips',
        image: ImageAssets.scooterLight,
        imageDark: ImageAssets.scooterDark,
        subTitle: 'Scan Charge and Go\nEffortless Charging schemas',
      ),
      OnboardingItemModel(
        titleSmall: 'Easy EV Navigation',
        titleLarge: 'Travel Route',
        titleLarge2: 'For Electrics',
        image: ImageAssets.mapLight,
        imageDark: ImageAssets.mapDark,
        subTitle:
            'Grab The Best In Class\nDigital Experience Crafted For\nEV Drivers',
      ),
      OnboardingItemModel(
        titleSmall: 'Interactions with Grid',
        titleLarge: 'RealTime',
        titleLarge2: 'Monitoring',
        image: ImageAssets.monitor,
        subTitle: 'Intelligent Sensible Devices\nAmbicharge Series',
      )
    ];
  }
}
