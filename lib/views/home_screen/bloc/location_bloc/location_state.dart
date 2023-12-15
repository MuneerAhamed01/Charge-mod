part of 'location_bloc.dart';

sealed class LocationState {
  final List<Location> location;

  LocationState({required this.location});
}

final class LocationLoadingState extends LocationState {
  LocationLoadingState() : super(location: []);
}

final class LocationSuccessState extends LocationState {
  LocationSuccessState({required super.location});
}

final class LocationErrorState extends LocationState {
  final String error;
  LocationErrorState(this.error) : super(location: []);
}
