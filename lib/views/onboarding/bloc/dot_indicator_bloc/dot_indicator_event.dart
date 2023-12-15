part of 'dot_indicator_bloc.dart';

sealed class DotIndicatorEvent {}

final class ChangeActiveDotEvent extends DotIndicatorEvent {
  final int index;

  ChangeActiveDotEvent(this.index);
}
