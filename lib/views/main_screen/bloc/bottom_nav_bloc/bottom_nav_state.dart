part of 'bottom_nav_bloc.dart';

sealed class BottomNavState {
  final int index;

  BottomNavState(this.index);
}

final class BottomNavigationChangeState extends BottomNavState {
  BottomNavigationChangeState(super.index);
}
