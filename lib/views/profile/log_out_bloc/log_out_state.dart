part of 'log_out_bloc.dart';

sealed class LogoutState {}

final class LogoutLoadingState extends LogoutState {}

final class LogoutInitState extends LogoutState {}

final class LogoutSuccessState extends LogoutState {}

final class LogoutErrorState extends LogoutState {
  final String error;
  LogoutErrorState(this.error);
}
