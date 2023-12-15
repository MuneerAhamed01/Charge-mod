import 'package:charge_mod/repositories/auth_repostiory.dart';
import 'package:charge_mod/repositories/user_repostiroy.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'log_out_event.dart';
part 'log_out_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  LogoutBloc(this._authRepository, this._userRepository)
      : super(LogoutInitState()) {
    on<LogoutTapEvent>(_onGetLocation);
  }

  _onGetLocation(LogoutTapEvent event, Emitter<LogoutState> emit) async {
    try {
      emit(LogoutLoadingState());
      await _authRepository.logOut();
      _userRepository.logOut();

      emit(LogoutSuccessState());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        emit(LogoutErrorState('Please check your internet connection'));
        return;
      }
      emit(LogoutErrorState(e.message ?? ""));
    } catch (e) {
      emit(LogoutErrorState(e.toString()));
    }
  }
}
