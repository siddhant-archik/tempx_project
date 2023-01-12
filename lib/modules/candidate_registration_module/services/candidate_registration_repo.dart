import 'dart:io';

import 'package:tempx_project/modules/candidate_registration_module/models/candidate_registration_model.dart';
import 'package:tempx_project/utils/api_provider.dart';
import 'package:tempx_project/utils/konstants.dart';

class CandidateRegitrationRepo {
  Future<String> registerCandidate(
      CandidateRegistrationModel candidateRegistrationData) async {
    String responceMessage = await APIProvider.instance.post(
        path: baseUrl + candidateRegistrationUrl,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: candidateRegistrationData);
    return responceMessage;
  }
}
