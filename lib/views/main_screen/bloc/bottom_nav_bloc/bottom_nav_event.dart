part of 'bottom_nav_bloc.dart';

sealed class BottomNavEvent {}

final class BottomNavigationChangeEvent extends BottomNavEvent {
  final int index;

  BottomNavigationChangeEvent(this.index);
}
