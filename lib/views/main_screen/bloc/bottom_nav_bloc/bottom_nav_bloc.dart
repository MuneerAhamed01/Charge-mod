import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavigationChangeState(0)) {
    on<BottomNavigationChangeEvent>((event, emit) {
      emit(BottomNavigationChangeState(event.index));
    });
  }
}
