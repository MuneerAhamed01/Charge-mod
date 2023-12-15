import 'package:charge_mod/repositories/auth_repostiory.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(AuthBlocInitial()) {
    on<OnSendOtpEvent>(_onSendOtpEvent);
    on<OnSubmitOtpEvent>(_onSubmitOtpEvent);
    on<OnChangeOtp>(_onChangeOtpEvent);
  }

  _onSendOtpEvent(OnSendOtpEvent event, Emitter<AuthBlocState> emit) async {
    if (event.mobileNumber.length < 10) {
      emit(AuthErrorState('Enter a valid mobile number', true));
      return;
    }

    try {
      emit(AuthLoadingState());
      final response = await _authRepository.sendOtp(event.mobileNumber);
      if (response) {
        emit(AuthSuccessState(mobileNumber: event.mobileNumber));
      } else {
        emit(AuthErrorState('Something went wrong', false,
            mobileNumber: state.mobileNumber));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        emit(AuthErrorState('Please check your internet connection', false,
            mobileNumber: state.mobileNumber));
        return;
      }
      emit(AuthErrorState(e.message, false, mobileNumber: state.mobileNumber));
    } catch (e) {
      emit(AuthErrorState(e, false, mobileNumber: state.mobileNumber));
    }
  }

  _onSubmitOtpEvent(OnSubmitOtpEvent event, Emitter<AuthBlocState> emit) async {
    final mobileNumber = state.mobileNumber;
    if (event.otp.length < 4) {
      emit(
        AuthErrorState(
          'Enter full otp',
          false,
          mobileNumber: state.mobileNumber,
        ),
      );
      return;
    }

    try {
      emit(AuthLoadingState());
      final response =
          await _authRepository.verifyOtp(event.otp, mobileNumber!);
      if (response) {
        emit(AuthSuccessStateAndVerified(mobileNumber: mobileNumber));
      } else {
        emit(
          AuthErrorState(
            'Something went wrong',
            false,
            mobileNumber: mobileNumber,
          ),
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        emit(AuthErrorState(
          'Please check your internet connection',
          false,
          mobileNumber: state.mobileNumber,
        ));
        return;
      }
      emit(AuthErrorState(
        e.message,
        false,
        mobileNumber: state.mobileNumber,
      ));
    } catch (e) {
      emit(AuthErrorState(
        e,
        false,
        mobileNumber: state.mobileNumber,
      ));
    }
  }

  _onChangeOtpEvent(OnChangeOtp event, Emitter<AuthBlocState> emit) {
    emit(AuthSuccessState(mobileNumber: state.mobileNumber, otp: event.otp));
  }
}
