part of 'form_field_bloc.dart';

sealed class FormFieldEvent extends Equatable {
  final String value;

  const FormFieldEvent(this.value);

  @override
  List<Object> get props => [value];
}

final class FirstNameChangeEvent extends FormFieldEvent {
  const FirstNameChangeEvent(super.value);
}

final class LastNameChangeEvent extends FormFieldEvent {
  const LastNameChangeEvent(super.value);
}

final class EmailChangeEvent extends FormFieldEvent {
  const EmailChangeEvent(super.value);
}
