part of 'dot_indicator_bloc.dart';

sealed class DotIndicatorState {
  final int activeIndex;

  const DotIndicatorState(this.activeIndex);
}

final class ActiveDotState extends DotIndicatorState {
  const ActiveDotState(super.activeIndex);
}
