import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:tempx_project/common_models/login_model.dart';
import 'package:tempx_project/utils/api_provider.dart';
import 'package:tempx_project/utils/konstants.dart';
import 'package:http/http.dart' as http;

class LoginRepo {
  Future<String> loginUser(LoginModel loginData) async {
    var path = baseUrl + loginUrl;

    try {
      var finalLoginData = {
        "username": loginData.username,
        "password": loginData.password,
        "userType": loginData.userType
      };
      final resp = await http.post(
        Uri.parse(path),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: finalLoginData,
      );
      print(finalLoginData);
      log("RESP $path :- ${resp.headers}");
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        return resp.headers['message'].toString();
      } else if (resp.statusCode == 400) {
        return resp.headers['message'].toString();
      } else if (resp.statusCode == 401) {
        throw CustomException('Unauthorized');
      } else if (resp.statusCode == 500) {
        throw CustomException('Server Error');
      } else {
        throw CustomException('Something went wrong');
      }
    } on SocketException {
      throw CustomException('No Internet connection');
    } on HttpException {
      throw CustomException('Something went wrong');
    } on FormatException {
      throw CustomException('Bad request');
    } catch (e) {
      throw CustomException(e.toString());
    }
    // return responceMessage;
  }
}
