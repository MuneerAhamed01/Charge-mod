import 'package:charge_mod/views/edit_pofile/utils/validation_mixin.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'form_field_event.dart';
part 'form_field_state.dart';

class FormFieldBloc extends Bloc<FormFieldEvent, FormFieldState>
    with ValidationMixin {
  FormFieldBloc(String mobileNumber)
      : super(FormFieldInitial(mobileNumber: mobileNumber)) {
    on<FirstNameChangeEvent>(_onFirstNameChangeEvent);
    on<LastNameChangeEvent>(_onLastNameChangeEvent);
    on<EmailChangeEvent>(_onEmailChangeEvent);
  }

  _onFirstNameChangeEvent(
      FirstNameChangeEvent event, Emitter<FormFieldState> emit) {
    if (validateFirstName(event.value) != null) {
      emit(FormErrorState(
        previousState: state,
        firstNameError: validateFirstName(event.value),
      ));
    } else {
      emit(
        FormFillState(
          firstName: event.value,
          lastName: state.lastName,
          email: state.email,
          mobileNumber: state.mobileNumber,
        ),
      );
    }
  }

  _onLastNameChangeEvent(
      LastNameChangeEvent event, Emitter<FormFieldState> emit) {
    if (validateLastName(event.value) != null) {
      emit(FormErrorState(
        previousState: state,
        lastNameError: validateLastName(event.value),
      ));
    } else {
      emit(
        FormFillState(
          firstName: state.firstName,
          lastName: event.value,
          email: state.email,
          mobileNumber: state.mobileNumber,
        ),
      );
    }
  }

  _onEmailChangeEvent(EmailChangeEvent event, Emitter<FormFieldState> emit) {
    if (validateEmail(event.value) != null) {
      emit(FormErrorState(
        previousState: state,
        emailError: validateEmail(event.value),
      ));
    } else {
      emit(
        FormFillState(
          firstName: state.firstName,
          lastName: state.lastName,
          email: event.value,
          mobileNumber: state.mobileNumber,
        ),
      );
    }
  }
}
