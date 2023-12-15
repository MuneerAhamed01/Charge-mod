part of 'mobile_number_bloc.dart';

sealed class MobileNumberState {
  final String? selectedCountryCode;
  final String? validationError;
  final String? mobileNumber;

  MobileNumberState(
      {this.selectedCountryCode, this.validationError, this.mobileNumber});

  bool get hasError => validationError != null;
}

final class MobileNumberValuesState extends MobileNumberState {
  MobileNumberValuesState({
    super.selectedCountryCode,
    super.validationError,
    super.mobileNumber,
  });
}
