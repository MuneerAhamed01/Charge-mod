part of 'form_field_bloc.dart';

sealed class FormFieldState extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;

  const FormFieldState({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
  });
  @override
  List<Object> get props => [firstName, lastName, email, mobileNumber];
}

final class FormFieldInitial extends FormFieldState {
  const FormFieldInitial({
    super.firstName = '',
    super.lastName = '',
    super.email = '',
    required super.mobileNumber,
  });
}

final class FormFillState extends FormFieldState {
  const FormFillState({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.mobileNumber,
  });

  FormFillState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNumber,
  }) {
    return FormFillState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
    );
  }
}

final class FormErrorState extends FormFieldState {
  final String? emailError;
  final String? firstNameError;
  final String? lastNameError;
  final FormFieldState previousState;
  FormErrorState({
    required this.previousState,
    this.emailError,
    this.firstNameError,
    this.lastNameError,
  }) : super(
          firstName: previousState.firstName,
          lastName: previousState.lastName,
          email: previousState.email,
          mobileNumber: previousState.mobileNumber,
        );

  FormErrorState copyWith({
    FormFieldState? previousState,
    String? emailError,
    String? firstNameError,
    String? lastNameError,
  }) {
    return FormErrorState(
      previousState: previousState ?? this.previousState,
      emailError: emailError ?? this.emailError,
      firstNameError: firstNameError ?? this.firstNameError,
      lastNameError: lastNameError ?? this.lastNameError,
    );
  }
}
