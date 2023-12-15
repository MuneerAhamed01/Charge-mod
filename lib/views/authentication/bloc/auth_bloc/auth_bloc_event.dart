part of 'auth_bloc.dart';

sealed class AuthBlocEvent {}

final class OnSendOtpEvent extends AuthBlocEvent {
  final String mobileNumber;

  OnSendOtpEvent(this.mobileNumber);
}

final class OnChangeOtp extends AuthBlocEvent {
  final String otp;

  OnChangeOtp(this.otp);
}

final class OnSubmitOtpEvent extends AuthBlocEvent {
  final String otp;

  OnSubmitOtpEvent(this.otp);
}
