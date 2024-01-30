import 'dart:convert';

import 'package:coding_challenge/config/app_config.dart';
import 'package:coding_challenge/data/local_storage/secure_storage.dart';
import 'package:coding_challenge/data/models/tax_data_model.dart';
import 'package:coding_challenge/data/services/tax_data_service.dart';

class TaxDataRepository {
  static Future<TaxDataModel?> getTaxDataByUserId({required int userId}) async {
    TaxDataModel? result;
    // check if Tax data stored in the device to use it.
    // else fetch from server.
    dynamic taxDataJson = await readTaxData();
    if (taxDataJson != null) {
      result = TaxDataModel.fromJson(taxDataJson);
    } else {
      taxDataJson = await TaxDataService.getTaxDataByUserId(userId: userId);
      if (taxDataJson != null) {
        await writeTaxData(taxDataJson);
        result = TaxDataModel.fromJson(taxDataJson);
      }
    }
    return result;
  }

  static Future<bool> updateTaxDataByUserId(
      {required int userId, required TaxDataModel taxDataModel}) async {
    Map<String, dynamic> taxDataJson = taxDataModel.toJson();
    bool success = await TaxDataService.updateTaxDataByUserId(
        userId: userId, taxDataJson: taxDataJson);
    if (success) {
      await writeTaxData(taxDataJson);
    }
    return success;
  }

  static Future<void> writeTaxData(Map<String, dynamic> taxDataJson) async {
    return SecureStorage().write(
        key: AppSecureStorageKey.taxDataKey, value: json.encode(taxDataJson));
  }

  static Future<dynamic> readTaxData() async {
    String? taxData =
        await SecureStorage().read(key: AppSecureStorageKey.taxDataKey);
    if (taxData != null && taxData.isNotEmpty) {
      return jsonDecode(taxData);
    }
    return null;
  }

  static Future<void> deleteTaxData() async {
    return SecureStorage().delete(key: AppSecureStorageKey.taxDataKey);
  }
}
