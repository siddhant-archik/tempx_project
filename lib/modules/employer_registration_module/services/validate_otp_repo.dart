import 'package:tempx_project/utils/api_provider.dart';
import 'package:tempx_project/utils/konstants.dart';

class ValidateOtpToMobileRepo {
  Future<String> validateOtpToMobile(String mobileNum, String otp) async {
    String respMessage = await APIProvider.instance.get(
        path:
            "$baseUrl$validateOtpSentToMobile?mobileNumber=%2B1 $mobileNum&otp=$otp");
    return respMessage;
  }
}
