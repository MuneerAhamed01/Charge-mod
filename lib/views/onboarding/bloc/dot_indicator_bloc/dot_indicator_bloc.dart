import 'package:flutter_bloc/flutter_bloc.dart';

part 'dot_indicator_event.dart';
part 'dot_indicator_state.dart';

class DotIndicatorBloc extends Bloc<DotIndicatorEvent, DotIndicatorState> {
  DotIndicatorBloc() : super(const ActiveDotState(0)) {
    on<ChangeActiveDotEvent>((event, emit) {
      emit(ActiveDotState(event.index));
    });
  }
}
