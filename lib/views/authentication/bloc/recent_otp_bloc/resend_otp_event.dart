part of 'resend_otp_bloc.dart';

sealed class ResendOtpEvent {}

class ResendOtpStartEvent extends ResendOtpEvent {
  final Duration currentTick;

  ResendOtpStartEvent(this.currentTick);
}

class TapResendOtpEvent extends ResendOtpEvent {
  late final String mobileNumber;
  TapResendOtpEvent({required this.mobileNumber});
}
