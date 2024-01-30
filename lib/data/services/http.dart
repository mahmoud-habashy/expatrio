import 'dart:convert';

import 'package:coding_challenge/logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:coding_challenge/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum RequestMethod { get, post, put, delete }

class HttpService {
  static Future<String?> sendHttpRequest(
      {required RequestMethod method,
      required String url,
      String? body}) async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Accept": "*/*"
      };

      Map<String, dynamic>? tokenData =
          await AuthRepository.readLoginTokenData();
      String? token = tokenData?["token"];
      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }

      http.Response response;
      switch (method) {
        case RequestMethod.get:
          response = await http.get(Uri.parse(url), headers: headers);
        case RequestMethod.post:
          response =
              await http.post(Uri.parse(url), headers: headers, body: body);
        case RequestMethod.put:
          response =
              await http.put(Uri.parse(url), headers: headers, body: body);
        case RequestMethod.delete:
          response =
              await http.delete(Uri.parse(url), headers: headers, body: body);
      }

      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 401) {
        // Invalid Token => logout the user and delete the stored token To push him to login screen.
        AuthCubit.logout(removeTokenOnly: true);
        return null;
      } else {
        throw response.body;
      }
    } catch (err) {
      String message = "Please check your internet connection.";
      try {
        Map<String, dynamic> jsonMessage =
            jsonDecode(err.toString()) as Map<String, dynamic>;
        message = jsonMessage['clientMessage'];
      } catch (_) {
        debugPrint('The provided Error is not valid JSON Error:$err');
      }
      throw message;
    }
  }
}
