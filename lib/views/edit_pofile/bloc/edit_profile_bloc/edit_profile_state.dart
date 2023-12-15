part of 'edit_profile_bloc.dart';

sealed class EditProfileState {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobileNumber;
  const EditProfileState(
      {this.firstName, this.lastName, this.email, this.mobileNumber});
}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoadingState extends EditProfileState {
  final EditProfileState previousState;

  EditProfileLoadingState(this.previousState)
      : super(
          email: previousState.email,
          firstName: previousState.firstName,
          lastName: previousState.lastName,
          mobileNumber: previousState.mobileNumber,
        );
}

final class EditProfileSuccessState extends EditProfileState {
  const EditProfileSuccessState({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.mobileNumber,
  });
}

final class EditProfileErrorState extends EditProfileState {
  final String errorMessage;
  final EditProfileState previousState;

  EditProfileErrorState(this.errorMessage, this.previousState)
      : super(
          email: previousState.email,
          firstName: previousState.firstName,
          lastName: previousState.lastName,
          mobileNumber: previousState.mobileNumber,
        );
}
