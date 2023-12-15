part of 'profile_bloc_bloc.dart';

sealed class ProfileBlocState extends Equatable {
  final User? user;

  const ProfileBlocState(this.user);

  @override
  List<Object> get props => [];
}

final class ProfileBlocInitial extends ProfileBlocState {
  const ProfileBlocInitial(super.user);
}

final class ProfileInitUseFailedState extends ProfileBlocState {
  final String? mobileNumber;
  const ProfileInitUseFailedState([this.mobileNumber]) : super(null);
}

final class ProfileInitSuccessState extends ProfileBlocState {
  const ProfileInitSuccessState(super.user);
}

final class ProfileInitLoadingState extends ProfileBlocState {
  const ProfileInitLoadingState(super.user);
}
