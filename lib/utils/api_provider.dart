import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class APIProvider {
  APIProvider._privateConstructor();
  static final APIProvider instance = APIProvider._privateConstructor();

  Future<String> get({
    required String path,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      log(path);
      final resp = await http.get(
        Uri.parse(path),
        headers: headers,
      );
      log("GET RESP: ${resp.headers}");
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        return resp.headers["message"].toString();
        // return CustomResponse(
        //     statusCode: resp.statusCode, data: responseDecoded);
      } else if (resp.statusCode == 401) {
        if (resp.headers.containsKey("message")) {
          return resp.headers["message"].toString();
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

  Future<String> post({
    required String path,
    required var body,
    Map<String, String>? headers = const {},
  }) async {
    try {
      String finalBody = convert.jsonEncode(body);
      log(finalBody);
      final resp = await http.post(
        Uri.parse(path),
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
        body: finalBody,
      );
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
  }

  static Future<CustomResponse> patch({
    required String path,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      String body = convert.jsonEncode(path);
      final resp = await http.patch(
        Uri.parse(path),
        headers: headers,
        body: body,
      );

      Map<String, dynamic> responseDecoded = convert.jsonDecode(resp.body);
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        return CustomResponse(
            statusCode: resp.statusCode, data: responseDecoded);
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
  }
}

class CustomResponse {
  CustomResponse({
    required this.statusCode,
    required this.data,
  });

  final int? statusCode;
  final Map<String, dynamic> data;
}

class CustomException implements Exception {
  CustomException(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}
