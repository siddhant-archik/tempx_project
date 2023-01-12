import 'package:tempx_project/utils/api_provider.dart';
import 'package:tempx_project/utils/konstants.dart';

class SendOtpToMobileRepo {
  Future<String> sendOtpToMobile(String mobileNum) async {
    String resp = await APIProvider.instance.get(
      path: "$baseUrl$sendOtpToMobileUrl?mobileNumber=%2B1 $mobileNum",
    );
    return resp;
  }
}
