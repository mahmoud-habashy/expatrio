import 'dart:convert';

import 'package:coding_challenge/data/services/http.dart';

import 'package:coding_challenge/config/app_config.dart';

class TaxDataService {
  static Future<dynamic> getTaxDataByUserId({required int userId}) async {
    final url = "${AppConfig.getTaxDataUrl}/$userId/tax-data";

    final responseBody =
        await HttpService.sendHttpRequest(method: RequestMethod.get, url: url);
    if (responseBody != null) {
      Map<String, dynamic> json = jsonDecode(responseBody);
      return json;
    }
  }

  static Future<bool> updateTaxDataByUserId(
      {required int userId, required Map<String, dynamic> taxDataJson}) async {
    final url = "${AppConfig.updateTaxDataUrl}/$userId/tax-data";

    final responseBody = await HttpService.sendHttpRequest(
        method: RequestMethod.put, url: url, body: jsonEncode(taxDataJson));

    return responseBody != null;
  }
}
