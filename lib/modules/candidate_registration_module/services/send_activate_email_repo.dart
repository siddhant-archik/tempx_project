import 'dart:io';

import 'package:tempx_project/modules/candidate_registration_module/models/send_activate_email_model.dart';
import 'package:tempx_project/utils/api_provider.dart';
import 'package:tempx_project/utils/konstants.dart';

class SendActivateEmailRepo {
  Future<String> sendActivateEmail(SendActivateEmailModel candidateData) async {
    String responceMessage = await APIProvider.instance.post(
        path: baseUrl + candidateSendActivateEmailUrl,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: candidateData);
    return responceMessage;
  }
}
