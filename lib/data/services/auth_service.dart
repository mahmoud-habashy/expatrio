import 'dart:convert';

import 'package:coding_challenge/config/app_config.dart';
import 'package:coding_challenge/data/services/http.dart';

class AuthService {
  static Future<dynamic> login(
      {required String email, required String password}) async {
    final responseBody = await HttpService.sendHttpRequest(
        method: RequestMethod.post,
        url: AppConfig.loginUrl,
        body: jsonEncode({"email": email, "password": password}));
    if (responseBody != null) {
      Map<String, dynamic> json = jsonDecode(responseBody);
      return json;
    }
  }
}
