part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthErrorState extends AuthState {
  final String? errorMessage;
  AuthErrorState({this.errorMessage});
}

class AuthLoadingState extends AuthState {}

class AuthSuccessfulState extends AuthState {
  final AuthModel authModel;
  AuthSuccessfulState({required this.authModel});
}

class AuthInvalidToken extends AuthState {
  final AuthModel? authModel;
  AuthInvalidToken({required this.authModel});
}

class AuthValidToken extends AuthState {
  final AuthModel authModel;
  AuthValidToken({required this.authModel});
}
