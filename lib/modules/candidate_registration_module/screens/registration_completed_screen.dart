import 'package:flutter/material.dart';
import 'package:tempx_project/common_components/default_button.dart';
import 'package:tempx_project/utils/helpers.dart';
import 'package:tempx_project/utils/konstants.dart';

class RegistrationCompletedScreen extends StatefulWidget {
  const RegistrationCompletedScreen({super.key});

  @override
  State<RegistrationCompletedScreen> createState() =>
      _RegistrationCompletedScreenState();
}

class _RegistrationCompletedScreenState
    extends State<RegistrationCompletedScreen> {
  Helpers helper = Helpers();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Registration Completed',
          style: montserrat500.copyWith(fontSize: 20, color: defaultLightBlue),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/landing_page_bg.jpeg',
            opacity: const AlwaysStoppedAnimation(0.5),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: helper.getHeight(context, 80),
                  ),
                  child: Center(
                      child: Text(
                    'Congratulations',
                    style: montserrat500.copyWith(color: defaultDarkBlue),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: helper.getHeight(context, 23)),
                  child: Center(
                      child: Text(
                    'You have Successfully',
                    style: montserrat500.copyWith(color: defaultDarkBlue),
                  )),
                ),
                Center(
                    child: Text(
                  'Registered on TempX',
                  style: montserrat500.copyWith(color: defaultDarkBlue),
                )),
                Padding(
                  padding: EdgeInsets.only(top: helper.getHeight(context, 54)),
                  child: Center(
                      child: Text(
                    'You will be notified',
                    style: montserrat500.copyWith(color: defaultDarkBlue),
                  )),
                ),
                Center(
                    child: Text(
                  'about the suitable openings',
                  style: montserrat500.copyWith(color: defaultDarkBlue),
                )),
                Padding(
                  padding: EdgeInsets.only(top: helper.getHeight(context, 95)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultBlueButton(
                          buttonText: 'OK',
                          height: 60,
                          onPress: () {},
                          width: 239)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
