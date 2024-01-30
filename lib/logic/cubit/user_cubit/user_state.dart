part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserFetchError extends UserState {
  final String? errorMessage;
  UserFetchError({this.errorMessage});
}

class UserFetchLoading extends UserState {}

class UserFetchSuccess extends UserState {
  final UserModel userModel;
  UserFetchSuccess({required this.userModel});
}
