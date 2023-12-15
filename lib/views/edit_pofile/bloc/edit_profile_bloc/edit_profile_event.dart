part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent {}

final class EditProfileDoneEvent extends EditProfileEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;

  EditProfileDoneEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {};

    body['mobile'] = int.parse(mobileNumber);
    body['firstName'] = firstName;
    body['lastName'] = lastName;
    body['email'] = email;

    return body;
  }
}
