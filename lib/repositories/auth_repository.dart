import 'dart:convert';

import 'package:coding_challenge/config/app_config.dart';
import 'package:coding_challenge/data/local_storage/secure_storage.dart';
import 'package:coding_challenge/data/models/auth_model.dart';
import 'package:coding_challenge/data/services/auth_service.dart';

class AuthRepository {
  static Future<AuthModel?> login(
      {required String email, required String password}) async {
    AuthModel? result;
    dynamic authJson =
        await AuthService.login(email: email, password: password);
    if (authJson != null) {
      await writeLoginUserData(authJson);
      await writeLoginTokenData(
          authJson['accessToken'], authJson['accessTokenExpiresAt']);
      result = AuthModel.fromJson(authJson);
    }
    return result;
  }

  static bool hasValidToken(
      {required String? token, required DateTime? accessTokenExpiresAt}) {
    bool result = false;
    if (token != null && accessTokenExpiresAt != null) {
      result = DateTime.now().isBefore(accessTokenExpiresAt);
    }
    return result;
  }

  static Future<void> writeLoginTokenData(
      String? accessToken, String? accessTokenExpiresAt) async {
    return SecureStorage().write(
        key: AppSecureStorageKey.loginTokenKey,
        value: jsonEncode(
            {'token': accessToken, 'expiresAt': accessTokenExpiresAt}));
  }

  static Future<Map<String, dynamic>?> readLoginTokenData() async {
    String? token =
        await SecureStorage().read(key: AppSecureStorageKey.loginTokenKey);
    if (token != null && token.isNotEmpty) {
      return json.decode(token);
    }
    return null;
  }

  static Future<void> deleteLoginTokenData() async {
    return SecureStorage().delete(key: AppSecureStorageKey.loginTokenKey);
  }

  static Future<void> writeLoginUserData(Map<String, dynamic> authJson) async {
    return SecureStorage().write(
        key: AppSecureStorageKey.loginAuthDataKey, value: jsonEncode(authJson));
  }

  static Future<AuthModel?> readLoginUserData() async {
    String? auth =
        await SecureStorage().read(key: AppSecureStorageKey.loginAuthDataKey);
    if (auth != null && auth.isNotEmpty) {
      return AuthModel.fromJson(json.decode(auth));
    }
    return null;
  }

  static Future<void> deleteLoginUserData() async {
    await deleteLoginTokenData();
    return SecureStorage().delete(key: AppSecureStorageKey.loginAuthDataKey);
  }
}
