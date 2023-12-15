import 'package:charge_mod/models/user_model.dart';
import 'package:charge_mod/repositories/user_repostiroy.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_bloc_event.dart';
part 'profile_bloc_state.dart';

class ProfileBlocBloc extends Bloc<ProfileBlocEvent, ProfileBlocState> {
  final UserRepository _userRepository;
  ProfileBlocBloc(this._userRepository, [User? user])
      : super(ProfileBlocInitial(user)) {
    on<ProfileInitEvent>(_initUserEvent);
    if (user == null) {
      add(ProfileInitEvent());
    }
  }

  _initUserEvent(ProfileInitEvent event, Emitter<ProfileBlocState> emit) async {
    try {
      emit(const ProfileInitLoadingState(null));
      final response = await _userRepository.getUserDetails();
      final isUserRegFailed =
          response.firstName == null || response.lastName == null;

      if (isUserRegFailed) {
        emit(ProfileInitUseFailedState(response.mobile));
        return;
      } else {
        emit(ProfileInitSuccessState(response));
      }
    } catch (e) {
      emit(const ProfileInitUseFailedState());
    }
  }
}
