part of 'mobile_number_bloc.dart';

sealed class MobileNumberEvent {}

final class ChangeCountryEvent extends MobileNumberEvent {
  final CountryCode countryCode;

  ChangeCountryEvent(this.countryCode);
}

final class ChangeMobileNumberEvent extends MobileNumberEvent {
  final String mobileNumber;

  ChangeMobileNumberEvent(this.mobileNumber);
}

final class CustomValidationErrorEvent extends MobileNumberEvent {
  final String validation;

  CustomValidationErrorEvent(this.validation);
}
