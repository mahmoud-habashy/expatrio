import 'package:coding_challenge/data/models/auth_model.dart';
import 'package:coding_challenge/repositories/auth_repository.dart';
import 'package:coding_challenge/repositories/tax_data_repository.dart';
import 'package:coding_challenge/repositories/user_repository.dart';
import 'package:coding_challenge/util/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoadingState());
    try {
      AuthModel? result =
          await AuthRepository.login(email: email, password: password);
      if (result != null) {
        emit(AuthSuccessfulState(authModel: result));
      } else {
        emit(AuthErrorState());
      }
    } catch (message) {
      emit(AuthErrorState(errorMessage: message.toString()));
    }
  }

  static Future<void> logout({bool removeTokenOnly = false}) async {
    try {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(AppRoutes.loginScreen, (route) => false);
      if (removeTokenOnly) {
        await AuthRepository.deleteLoginTokenData();
      } else {
        await AuthRepository.deleteLoginUserData();
        await UserRepository.deleteUserData();
        await TaxDataRepository.deleteTaxData();
      }
    } catch (err) {
      debugPrint("Error logging out: $err");
    }
  }

  Future<void> getStoredUserDataAndCheckTokenValidation() async {
    try {
      AuthModel? authModel = await AuthRepository.readLoginUserData();
      bool hasValidToken = authModel != null &&
          AuthRepository.hasValidToken(
              token: authModel.accessToken,
              accessTokenExpiresAt: authModel.accessTokenExpiresAt);
      if (hasValidToken) {
        emit(AuthValidToken(authModel: authModel));
      } else {
        await AuthRepository.deleteLoginTokenData();
        emit(AuthInvalidToken(authModel: authModel));
      }
    } catch (err) {
      emit(AuthInvalidToken(authModel: null));
    }
  }
}
