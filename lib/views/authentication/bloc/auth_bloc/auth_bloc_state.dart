part of 'auth_bloc.dart';

sealed class AuthBlocState {
  final String? mobileNumber;
  final String? otp;

  AuthBlocState({
    this.mobileNumber,
    this.otp,
  });
}

final class AuthBlocInitial extends AuthBlocState {}

final class AuthLoadingState extends AuthBlocState {}

final class AuthSuccessState extends AuthBlocState {
  AuthSuccessState({super.mobileNumber, super.otp});
}

final class AuthSuccessStateAndVerified extends AuthBlocState {
  AuthSuccessStateAndVerified({super.mobileNumber});
}

final class AuthErrorState extends AuthBlocState {
  final dynamic errorMessage;
  final bool isValidationError;

  AuthErrorState(this.errorMessage, this.isValidationError,
      {super.mobileNumber});
}
