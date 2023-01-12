import 'package:flutter/material.dart';
import 'package:tempx_project/modules/candidate_registration_module/screens/candidate_login_screen.dart';
import 'package:tempx_project/modules/candidate_registration_module/screens/enter_email_screen.dart';
import 'package:tempx_project/modules/employer_registration_module/screens/mobile_registration_screen.dart';
import 'package:tempx_project/modules/store_manager_registration_module/screens/mobile_registration_screen.dart';
import 'dart:math' as math;

import 'package:tempx_project/utils/konstants.dart';

class RoleSelectionScreen extends StatefulWidget {
  final String isLoginOrRegistration;
  const RoleSelectionScreen({super.key, required this.isLoginOrRegistration});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: defaultLightBlue,
            size: 30,
          ),
        ),
        title: Text(
          'Welcome to TempX',
          style: montserrat600.copyWith(fontSize: 22, color: defaultLightBlue),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/landing_page_bg.jpeg',
            opacity: const AlwaysStoppedAnimation(.58),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: devHeight * 0.055, bottom: devHeight * 0.022),
                child: Text(
                  'Select who you are',
                  style: montserrat600.copyWith(fontSize: 24),
                ),
              ),
              candidateContainer(devWidth, devHeight, () {
                if (widget.isLoginOrRegistration == "Login") {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const CandidateLoginScreen(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const EnterEmailScreen(
                        isForRegOrForgotPassword: 'Registration',
                      ),
                    ),
                  );
                }
              }),
              employerContainer(devHeight, devWidth, () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        MobileNumberRegisterationScreen(
                            isLoginOrRegistration:
                                widget.isLoginOrRegistration),
                  ),
                );
              }),
              supervisorContainer(devHeight, devWidth, () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        StoreManagerMobileRegistrationScreen(
                            isLoginOrRegistration:
                                widget.isLoginOrRegistration),
                  ),
                );
              })
            ],
          ),
        ],
      ),
    );
  }

  Widget supervisorContainer(
      double devHeight, double devWidth, void Function() onTap) {
    return Container(
      margin: EdgeInsets.only(top: devHeight * 0.036),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(),
          Positioned(
            left: devWidth * 0.222,
            child: Transform.rotate(
              angle: -math.pi / 55,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onTap: onTap,
                child: Container(
                  width: devWidth * 0.921,
                  height: devHeight * 0.1365,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: roleSelectionRectBorderColor,
                      )),
                ),
              ),
            ),
          ),
          Transform.rotate(
            angle: -math.pi / 50,
            child: InkWell(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.only(
                    top: devHeight * 0.038, left: devWidth * 0.012),
                child: Column(
                  children: [
                    Text(
                      'Supervisor',
                      style: montserrat500.copyWith(
                        fontSize: devHeight * 0.035,
                        shadows: [
                          const Shadow(
                            blurRadius: 8.0,
                            color: Color.fromRGBO(0, 0, 0, 0.14),
                            offset: Offset(3.0, 4.0),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Store Managers',
                      style:
                          montserrat500.copyWith(fontSize: devHeight * 0.024),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget employerContainer(
      double devHeight, double devWidth, void Function() onTap) {
    return Container(
      margin: EdgeInsets.only(top: devHeight * 0.038),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(),
          Positioned(
            left: devWidth * 0.165,
            child: Transform.rotate(
              angle: -math.pi / 49,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onTap: onTap,
                child: Container(
                  width: devWidth * 0.877,
                  height: devHeight * 0.141,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: roleSelectionRectBorderColor,
                      )),
                ),
              ),
            ),
          ),
          Transform.rotate(
            angle: -math.pi / 50,
            child: InkWell(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.only(
                    top: devHeight * 0.027, right: devWidth * 0.047),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Employer',
                      style: montserrat500.copyWith(
                        fontSize: devHeight * 0.035,
                        shadows: [
                          const Shadow(
                            blurRadius: 8.0,
                            color: Color.fromRGBO(0, 0, 0, 0.14),
                            offset: Offset(3.0, 4.0),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Looking for',
                      style:
                          montserrat500.copyWith(fontSize: devHeight * 0.024),
                    ),
                    Text(
                      'Human Resource?',
                      style:
                          montserrat500.copyWith(fontSize: devHeight * 0.024),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget candidateContainer(
      double devWidth, double devHeight, void Function() onTap) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(),
        Positioned(
          left: devWidth * 0.17,
          child: Transform.rotate(
            angle: -math.pi / 50,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onTap: onTap,
              child: Container(
                width: devWidth * 0.877,
                height: devHeight * 0.141,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: roleSelectionRectBorderColor,
                    )),
              ),
            ),
          ),
        ),
        Transform.rotate(
          angle: -math.pi / 50,
          child: InkWell(
            onTap: onTap,
            child: Container(
              margin: EdgeInsets.only(
                top: devHeight * 0.027,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Candidate',
                    style: montserrat500.copyWith(
                      fontSize: devHeight * 0.035,
                      shadows: [
                        const Shadow(
                          blurRadius: 8.0,
                          color: Color.fromRGBO(0, 0, 0, 0.14),
                          offset: Offset(3.0, 4.0),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Looking for',
                    style: montserrat500.copyWith(fontSize: devHeight * 0.024),
                  ),
                  Text(
                    'Job in Canada?',
                    style: montserrat500.copyWith(fontSize: devHeight * 0.024),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
