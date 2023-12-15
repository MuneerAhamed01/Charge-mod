import 'dart:async';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mobile_number_event.dart';
part 'mobile_number_state.dart';

class MobileNumberBloc extends Bloc<MobileNumberEvent, MobileNumberState> {
  MobileNumberBloc()
      : super(MobileNumberValuesState(selectedCountryCode: '+91')) {
    on<ChangeCountryEvent>(_changeCountryEvent);
    on<ChangeMobileNumberEvent>(_changeMobileNumberEvent);
    on<CustomValidationErrorEvent>(_customValidationEvent);
  }

  FutureOr<void> _changeCountryEvent(
    ChangeCountryEvent event,
    Emitter<MobileNumberState> emit,
  ) {
    emit(MobileNumberValuesState(selectedCountryCode: event.countryCode.code));
  }

  FutureOr<void> _changeMobileNumberEvent(
    ChangeMobileNumberEvent event,
    Emitter<MobileNumberState> emit,
  ) {
    if (state.selectedCountryCode == null) {
      emit(
        MobileNumberValuesState(
            validationError: 'Select the country first',
            selectedCountryCode: state.selectedCountryCode),
      );
    } else if (event.mobileNumber.length > 10) {
      emit(
        MobileNumberValuesState(
            selectedCountryCode: state.selectedCountryCode,
            validationError: 'Please enter the valid mobile number'),
      );
    } else {
      emit(
        MobileNumberValuesState(
          selectedCountryCode: state.selectedCountryCode,
          validationError: null,
          mobileNumber: event.mobileNumber,
        ),
      );
    }
  }

  FutureOr<void> _customValidationEvent(
    CustomValidationErrorEvent event,
    Emitter<MobileNumberState> emit,
  ) {
    emit(MobileNumberValuesState(
        validationError: event.validation,
        mobileNumber: state.mobileNumber,
        selectedCountryCode: state.selectedCountryCode));
  }
}
