import 'dart:io';

import 'package:tempx_project/modules/employer_registration_module/models/employer_registration_model.dart';
import 'package:tempx_project/utils/api_provider.dart';
import 'package:tempx_project/utils/konstants.dart';

class EmployerRegistationRepo {
  Future<String> registerEmployer(
      EmployerRegistrationModel employerData) async {
    String responceMessage = await APIProvider.instance.post(
        path: baseUrl + registerEmployerUrl,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: employerData);
    return responceMessage;
  }

  Future<String> registerEmployerBySelectingBusiness(
      EmployerRegistrationBySelectingBusinessModel employerData) async {
    String responceMessage = await APIProvider.instance.post(
        path: baseUrl + registerEmployerUrl,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: employerData);
    return responceMessage;
  }
}
