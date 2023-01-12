import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tempx_project/common_models/business_industry_list_model.dart';
import 'package:tempx_project/utils/api_provider.dart';
import 'package:tempx_project/utils/konstants.dart';

class GetBusinessList {
  Future<dynamic> getBusinessList() async {
    try {
      var path = baseUrl + getBusinessListUrl;
      log(path);
      final resp = await http.get(
        Uri.parse(path),
        headers: {},
      );
      log("GET BUSINESS RESP: ${resp.headers}");
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        log(resp.body);
        final decodedResponce = jsonDecode(resp.body);
        List<Business> businessList = [];
        decodedResponce.forEach((v) {
          businessList.add(Business.fromJson(v));
        });
        // BusinessList businessList = BusinessList.fromJson(decodedResponce);
        return businessList;
      } else if (resp.statusCode == 401) {
        if (resp.headers.containsKey("message")) {
          // return resp.headers["message"].toString();
        }
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
  }
}
