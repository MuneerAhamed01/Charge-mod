import 'dart:async';

import 'package:charge_mod/repositories/auth_repostiory.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'resend_otp_event.dart';
part 'resend_otp_state.dart';

class ResendOtpBloc extends Bloc<ResendOtpEvent, ResendOtpState> {
  Timer? _timer;
  late final AuthRepository _authRepository;
  ResendOtpBloc(this._authRepository) : super(const ResendOtpCountDownState()) {
    on<ResendOtpStartEvent>(_countDown);
    on<TapResendOtpEvent>(_tapResendOtpEvent);
    // add(ResendOtpStartEvent());
    _countDownTimer();
  }

  _countDown(ResendOtpStartEvent event, Emitter<ResendOtpState> emit) {
    if (event.currentTick == Duration.zero) {
      emit(ResendOtpCountDownDone(recentOTP: state.recentOTP));
      return;
    } else {
      emit(
        ResendOtpCountDownState(
          recentOTP: state.recentOTP,
          currentStateTick: event.currentTick.inSeconds,
        ),
      );
    }
  }

  _countDownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final tick = Duration(seconds: state.recentOTP.inSeconds - timer.tick);

      if (tick.inSeconds == 0) {
        timer.cancel();
        add(ResendOtpStartEvent(Duration.zero));
        return;
      }
      add(ResendOtpStartEvent(tick));
    });
  }

  _tapResendOtpEvent(
      TapResendOtpEvent event, Emitter<ResendOtpState> emit) async {
    try {

      
      final response = await _authRepository.resendOtp(event.mobileNumber);

      if (response) {
        _countDownTimer();
      } else {
        emit(const ResendOtpCountDownDone(error: 'Something went wrong'));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        emit(const ResendOtpCountDownDone(
            error: 'Please check your internet connection'));
        return;
      }
      emit(ResendOtpCountDownDone(error: e.message));
    } catch (e) {
      emit(ResendOtpCountDownDone(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
