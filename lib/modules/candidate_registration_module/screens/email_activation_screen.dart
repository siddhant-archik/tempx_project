import 'package:flutter/material.dart';
import 'package:tempx_project/modules/candidate_registration_module/screens/set_password_screen.dart';
import 'package:tempx_project/utils/konstants.dart';

class EmailActivationScreen extends StatefulWidget {
  final String email;
  const EmailActivationScreen({super.key, required this.email});

  @override
  State<EmailActivationScreen> createState() => _EmailActivationScreenState();
}

class _EmailActivationScreenState extends State<EmailActivationScreen> {
  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
            'Candidate Registration',
            style:
                montserrat500.copyWith(fontSize: 20, color: defaultLightBlue),
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/landing_page_bg.jpeg',
              opacity: const AlwaysStoppedAnimation(.27),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: devHeight * 0.18, bottom: devHeight * 0.061),
                  child: Center(
                    child: Text(
                      'Activate the link',
                      style: montserrat600.copyWith(
                          color: defaultDarkBlue, fontSize: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: devHeight * 0.01),
                  child: Center(
                    child: Text(
                      'Open the email',
                      style: montserrat500.copyWith(fontSize: 20),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    widget.email,
                    style: montserrat500.copyWith(fontSize: 20),
                  ),
                ),
                Center(
                  child: Text(
                    'on this device',
                    style: montserrat500.copyWith(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: devHeight * 0.03),
                  child: Center(
                    child: Text(
                      'Click on the link sent by TempX',
                      style: montserrat500.copyWith(fontSize: 20),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'to set password',
                    style: montserrat500.copyWith(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: devHeight * 0.04, bottom: devHeight * 0.015),
                  child: Center(
                    child: Text(
                      'Didn\'t receive Email?',
                      style: montserrat400.copyWith(fontSize: 20),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                SetPasswordScreen(
                                    emailForReg: widget.email,
                                    isForRegOrForgotPassword: 'Registration'),
                          ),
                        );
                      },
                      child: Container(
                        width: devWidth * 0.37,
                        height: devHeight * 0.0555,
                        decoration: BoxDecoration(
                            color: resendLightBlue,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: defaultDarkBlue)),
                        child: Center(
                          child: Text(
                            'Resend Link',
                            style: montserrat500.copyWith(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: devHeight * 0.167),
                  child: Center(
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onTap: () {},
                      child: Text(
                        'About Us',
                        style: montserrat400.copyWith(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
