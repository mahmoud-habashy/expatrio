import 'dart:convert';

import 'package:coding_challenge/config/app_config.dart';
import 'package:coding_challenge/data/local_storage/secure_storage.dart';
import 'package:coding_challenge/data/models/user_model.dart';
import 'package:coding_challenge/data/services/user_service.dart';

class UserRepository {
  static Future<UserModel?> getUserById({required int userId}) async {
    UserModel? result;

    // check if User data stored in the device to use it.
    // else fetch from server.
    dynamic userJson = await readUserData();
    if (userJson != null) {
      result = UserModel.fromJson(userJson);
    } else {
      userJson = await UserService.getUserById(userId: userId);
      if (userJson != null) {
        await writeUserData(userJson);
        result = UserModel.fromJson(userJson);
      }
    }
    return result;
  }

  static Future<void> writeUserData(Map<String, dynamic> userModel) async {
    return SecureStorage().write(
        key: AppSecureStorageKey.userDataKey, value: json.encode(userModel));
  }

  static Future<dynamic> readUserData() async {
    String? user =
        await SecureStorage().read(key: AppSecureStorageKey.userDataKey);
    if (user != null && user.isNotEmpty) {
      return json.decode(user);
    }
    return null;
  }

  static Future<void> deleteUserData() async {
    return SecureStorage().delete(key: AppSecureStorageKey.userDataKey);
  }
}
