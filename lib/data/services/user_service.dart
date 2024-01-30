import 'dart:convert';

import 'package:coding_challenge/config/app_config.dart';
import 'package:coding_challenge/data/services/http.dart';

class UserService {
  static Future<dynamic> getUserById({required int userId}) async {
    final url = "${AppConfig.getUserUrl}/$userId/profile";

    final responseBody =
        await HttpService.sendHttpRequest(method: RequestMethod.get, url: url);
    if (responseBody != null) {
      Map<String, dynamic> json = jsonDecode(responseBody);
      return json;
    }
  }
}
