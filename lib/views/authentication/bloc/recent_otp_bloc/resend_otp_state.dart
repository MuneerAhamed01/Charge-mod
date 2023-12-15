part of 'resend_otp_bloc.dart';

sealed class ResendOtpState extends Equatable {
  final Duration recentOTP;
  final String? error;
  final int currentStateTick;

  const ResendOtpState(
      {this.recentOTP = const Duration(seconds: 30),
      this.currentStateTick = 30,
      this.error});
}

final class ResendOtpCountDownState extends ResendOtpState {
  const ResendOtpCountDownState({super.recentOTP, super.currentStateTick});

  @override
  List<Object?> get props => [currentStateTick];
}

final class ResendOtpCountDownDone extends ResendOtpState {
  const ResendOtpCountDownDone({super.error, super.recentOTP});

  @override
  List<Object?> get props => [error];
}


