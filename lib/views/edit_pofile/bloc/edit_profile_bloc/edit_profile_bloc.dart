import 'package:charge_mod/repositories/user_repostiroy.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UserRepository _userRepository;
  EditProfileBloc(this._userRepository) : super(EditProfileInitial()) {
    on<EditProfileDoneEvent>(_onEditProfileDoneEvent);
  }

  _onEditProfileDoneEvent(
    EditProfileDoneEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      emit(EditProfileLoadingState(state));
      final response = await _userRepository.updateUserDetails(event.toJson());
      if (response) {
        emit(
          EditProfileSuccessState(
            firstName: event.firstName,
            email: event.email,
            lastName: event.lastName,
            mobileNumber: event.mobileNumber,
          ),
        );
      } else {
        emit(EditProfileErrorState('Something went wrong', state));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        emit(EditProfileErrorState(
            'Please check your internet connection', state));
        return;
      }
      emit(EditProfileErrorState(e.message ?? 'Something went wrong', state));
    } catch (e) {
      emit(EditProfileErrorState(e.toString(), state));
    }
  }
}
