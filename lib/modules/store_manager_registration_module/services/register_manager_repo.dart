import 'dart:io';

import 'package:tempx_project/modules/store_manager_registration_module/models/register_manager_model.dart';
import 'package:tempx_project/utils/api_provider.dart';
import 'package:tempx_project/utils/konstants.dart';

class RegisterStoreManagerRepo {
  Future<String> registerStoreManager(
      RegisterStoreManagerModel managerData) async {
    String responceMessage = await APIProvider.instance.post(
        path: baseUrl + registerStoreManagerUrl,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: managerData);
    return responceMessage;
  }
}
