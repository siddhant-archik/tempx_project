import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tempx_project/common_components/default_button.dart';
import 'package:tempx_project/utils/helpers.dart';
import 'package:tempx_project/utils/konstants.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String verifyOrNumNotFoundCheck;
  const VerifyOtpScreen({super.key, required this.verifyOrNumNotFoundCheck});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  Helpers helper = Helpers();
  bool wrongOTPEnteredFiveTimesErrorMessage = false;
  bool wrongOTPEnteredErrorMessage = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'Candidate Registration',
            style:
                montserrat500.copyWith(fontSize: 20, color: defaultLightBlue),
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/landing_page_bg.jpeg',
              opacity: const AlwaysStoppedAnimation(0.4),
            ),
            Card(
              margin: EdgeInsets.only(
                  top: helper.getHeight(context, 70),
                  bottom: helper.getHeight(context, 265),
                  right: helper.getWidth(context, 5),
                  left: helper.getWidth(context, 5)),
              elevation: 0,
              color: const Color(0xffFFFFFF).withOpacity(0.8),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: secondaryBorderColor, width: 1.5),
                borderRadius: BorderRadius.circular(21.0),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  widget.verifyOrNumNotFoundCheck == "VerifyOTP"
                      ? verifyOTPSection(context)
                      : wrongWhatsappNumSection(context),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close, size: 35)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column wrongWhatsappNumSection(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: helper.getHeight(context, 70),
              bottom: helper.getHeight(context, 25)),
          child: Center(
            child: Text(
              'Sorry!',
              style: montserrat500.copyWith(
                  fontSize: 20, color: const Color(0xffFF5E5E)),
            ),
          ),
        ),
        Center(
          child: Text(
            'We don\'t find a Whatsapp',
            style: montserrat500.copyWith(
                fontSize: 20, color: const Color(0xffFF5E5E)),
          ),
        ),
        Center(
          child: Text(
            'account linked to the number',
            style: montserrat500.copyWith(
                fontSize: 20, color: const Color(0xffFF5E5E)),
          ),
        ),
        Center(
          child: Text(
            'you have provided',
            style: montserrat500.copyWith(
                fontSize: 20, color: const Color(0xffFF5E5E)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom: helper.getHeight(context, 44),
              top: helper.getHeight(context, 15)),
          child: Center(
              child: Text(
            '+1-123-456-7890',
            style: montserrat500.copyWith(color: defaultDarkBlue, fontSize: 22),
          )),
        ),
        Center(
          child: Text(
            'Please go back and enter the',
            style: montserrat500.copyWith(
                fontSize: 20, color: const Color(0xffFF5E5E)),
          ),
        ),
        Center(
          child: Text(
            'correct whatsapp number',
            style: montserrat500.copyWith(
                fontSize: 20, color: const Color(0xffFF5E5E)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: helper.getHeight(context, 20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultBlueButton(
                  buttonColor: const Color(0XFF526197),
                  buttonText: 'OK',
                  height:
                      helper.getHeight(context, helper.getHeight(context, 73)),
                  borderRadius: 36,
                  onPress: () {
                    wrongOTPEnteredErrorMessage = !wrongOTPEnteredErrorMessage;
                    setState(() {});
                  },
                  width: helper.getWidth(context, 270))
            ],
          ),
        )
      ],
    );
  }

  Column verifyOTPSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: helper.getHeight(context, 35),
          ),
          child: Center(
              child: Text(
            'Verify OTP',
            style: montserrat500.copyWith(color: defaultDarkBlue, fontSize: 20),
          )),
        ),
        Visibility(
          visible: wrongOTPEnteredFiveTimesErrorMessage,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: helper.getHeight(context, 40)),
                child: Center(
                  child: Text(
                    'You have entered Wrong OTP',
                    style: montserrat500.copyWith(
                        fontSize: 20, color: const Color(0xffFF5E5E)),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'more than 5 times',
                  style: montserrat500.copyWith(
                      fontSize: 20, color: const Color(0xffFF5E5E)),
                ),
              ),
              Center(
                child: Text(
                  'Please try verifying after 30 Mins',
                  style: montserrat500.copyWith(
                      fontSize: 20, color: const Color(0xffFF5E5E)),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: wrongOTPEnteredErrorMessage,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: helper.getHeight(context, 40)),
                child: Center(
                  child: Text(
                    'The OTP you have entered',
                    style: montserrat500.copyWith(
                        fontSize: 20, color: const Color(0xffFF5E5E)),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'is wrong Please check',
                  style: montserrat500.copyWith(
                      fontSize: 20, color: const Color(0xffFF5E5E)),
                ),
              ),
              Center(
                child: Text(
                  'correctly and',
                  style: montserrat500.copyWith(
                      fontSize: 20, color: const Color(0xffFF5E5E)),
                ),
              ),
              Center(
                child: Text(
                  'Enter OTP Received on',
                  style: montserrat500.copyWith(
                      fontSize: 20, color: const Color(0xffFF5E5E)),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: wrongOTPEnteredFiveTimesErrorMessage == false &&
              wrongOTPEnteredErrorMessage == false,
          child: Padding(
            padding: EdgeInsets.only(top: helper.getHeight(context, 110)),
            child: Center(
                child: Text(
              'Enter OTP Received on',
              style: montserrat400.copyWith(color: Colors.black, fontSize: 20),
            )),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: wrongOTPEnteredFiveTimesErrorMessage
                  ? helper.getHeight(context, 25)
                  : wrongOTPEnteredErrorMessage
                      ? helper.getHeight(context, 10)
                      : 0),
          child: Center(
              child: Text(
            '+1-123-456-7890',
            style: montserrat500.copyWith(color: defaultDarkBlue, fontSize: 20),
          )),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: helper.getHeight(context, 10),
              right: helper.getWidth(context, 8),
              left: helper.getWidth(context, 8)),
          child: Material(
            elevation: 15,
            shadowColor: const Color.fromRGBO(54, 67, 115, 0.15),
            borderRadius: BorderRadius.circular(30),
            child: TextField(
              // controller: otpController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 6,
              onChanged: (value) {
                // buttonVisiblity();
              },
              style: const TextStyle(fontSize: 20),
              keyboardType: TextInputType.phone,
              decoration: defaultTextFieldDecoration.copyWith(
                  suffixIcon: const Icon(Icons.close),
                  contentPadding: MediaQuery.of(context).size.hashCode <= 667
                      ? const EdgeInsets.all(19.0)
                      : const EdgeInsets.all(20.0),
                  counterText: "",
                  hintText: 'Enter OTP'),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: helper.getHeight(context, 100)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultBlueButton(
                  buttonColor: const Color(0XFF526197),
                  buttonText: 'Verify',
                  height:
                      helper.getHeight(context, helper.getHeight(context, 73)),
                  borderRadius: 36,
                  onPress: () {
                    wrongOTPEnteredErrorMessage = !wrongOTPEnteredErrorMessage;
                    setState(() {});
                  },
                  width: helper.getWidth(context, 270))
            ],
          ),
        )
      ],
    );
  }
}
