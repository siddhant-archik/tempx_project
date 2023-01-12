import 'package:flutter/material.dart';
import 'package:tempx_project/common_components/default_button.dart';

import '../../../utils/konstants.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen(
      {super.key, required this.businessName, required this.craNumber});

  final String businessName;
  final String craNumber;

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool afterVerification = false;
  bool beforeVerification = true;
  double buttonOpacity = 0.4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          afterVerification ? 'Dashboard' : 'Verify Email',
          style: montserrat600.copyWith(fontSize: 20, color: defaultLightBlue),
        ),
        actions: [
          Visibility(
            visible: afterVerification,
            child: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.menu,
                color: defaultLightBlue,
                size: 40,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/landing_page_bg.jpeg',
            opacity: const AlwaysStoppedAnimation(.2),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Center(
                    child: Text(
                  'You have Successfully',
                  style: montserrat400.copyWith(fontSize: 24),
                )),
              ),
              Center(
                  child: Text(
                afterVerification
                    ? 'Verified on TempX as'
                    : 'Registered on TempX as',
                style: montserrat400.copyWith(fontSize: 24),
              )),
              Padding(
                padding: const EdgeInsets.only(top: 51),
                child: Center(
                    child: Text(
                  widget.businessName,
                  textAlign: TextAlign.center,
                  style: montserrat500.copyWith(fontSize: 24),
                )),
              ),
              Center(
                  child: Text(
                widget.craNumber,
                textAlign: TextAlign.center,
                style: montserrat500.copyWith(fontSize: 24),
              )),
              Visibility(
                visible: beforeVerification,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 130.0),
                      child: Center(
                          child: Text(
                        'Please check your email',
                        style: montserrat400.copyWith(fontSize: 24),
                      )),
                    ),
                    Center(
                        child: Text(
                      'click on the link to verify it',
                      style: montserrat400.copyWith(fontSize: 24),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(top: 51.0),
                      child: Center(
                          child: Text(
                        'Only after email verification',
                        style: montserrat400.copyWith(fontSize: 24),
                      )),
                    ),
                    Center(
                        child: Text(
                      'you will be able to post Jobs',
                      style: montserrat400.copyWith(fontSize: 24),
                    )),
                  ],
                ),
              ),
              Visibility(
                visible: afterVerification,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 170.0),
                      child: Center(
                          child: Text(
                        'You don\'t have',
                        style: montserrat400.copyWith(fontSize: 24),
                      )),
                    ),
                    Center(
                        child: Text(
                      'Matching results yet',
                      style: montserrat400.copyWith(fontSize: 24),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(top: 145.0),
                      child: Center(
                          child: Text(
                        'Please post your requirements',
                        style: montserrat400.copyWith(fontSize: 24),
                      )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: afterVerification ? 35 : 145.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultBlueButton(
                        opacity: buttonOpacity,
                        borderRadius: 36.5,
                        buttonText: 'Post a Requirement',
                        height: 67,
                        onPress: () {
                          afterVerification = true;
                          beforeVerification = false;
                          buttonOpacity = 1;
                          setState(() {});
                        },
                        width: 377),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
