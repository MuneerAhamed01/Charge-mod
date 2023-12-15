import 'package:charge_mod/utils/assets.dart';

class ProfileItems {
  final String icon;
  final String title;

  ProfileItems(this.icon, this.title);

  static List<ProfileItems> accountsSection() {
    return [
      ProfileItems(SvgAssets.paymentIcon, 'My Payments'),
      ProfileItems(SvgAssets.electricVehicle, 'My Electric Vehicles'),
      ProfileItems(SvgAssets.favIcon, 'My Favourite Stations'),
      ProfileItems(SvgAssets.alphaIcon, 'Alpha Membership'),
    ];
  }

  static List<ProfileItems> deviceAndOrderSection() {
    return [
      ProfileItems(SvgAssets.myDevice, 'My Devices'),
      ProfileItems(SvgAssets.myOrders, 'My Orders'),
    ];
  }

  static List<ProfileItems> customerSupportSection() {
    return [
      ProfileItems(SvgAssets.helpIcon, 'Help'),
      ProfileItems(SvgAssets.riseCompliant, 'Raise Complaint'),
      ProfileItems(SvgAssets.favIcon, 'About Us'),
      ProfileItems(SvgAssets.alphaIcon, 'Privacy Policy'),
    ];
  }
}
