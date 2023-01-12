import 'package:flutter/material.dart';
import 'package:tempx_project/common_components/default_button.dart';
import 'package:tempx_project/modules/landing_module/screens/role_selection_screen.dart';
import 'package:tempx_project/utils/konstants.dart';

class LoginOrRegisterScren extends StatefulWidget {
  const LoginOrRegisterScren({super.key});

  @override
  State<LoginOrRegisterScren> createState() => _LoginOrRegisterScrenState();
}

class _LoginOrRegisterScrenState extends State<LoginOrRegisterScren> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;
    if (devHeight <= 667) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut);
        }
      });
    }
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        // physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/landing_page_bg.jpeg'),
                SafeArea(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: devHeight * 0.055),
                        child: Center(
                          child: Image.asset(
                            'assets/images/tempxlogo.png',
                            height: devHeight <= 667 ? 120 : null,
                          ),
                        ),
                      ),
                      Text(
                        'Welcome to',
                        style: montserrat500,
                      ),
                      Text(
                        'Temp X',
                        style: montserrat600,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: devHeight * 0.076,
                            bottom: devHeight <= 667
                                ? devHeight * 0.18
                                : devHeight * 0.216),
                        child: Image.asset(
                          'assets/images/jobs_icon.png',
                          height: devHeight <= 667 ? 120 : null,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: devHeight <= 667 ? devHeight * 0.07 : 0),
                        child: Text(
                          'A Career management Portal',
                          softWrap: true,
                          style: montserrat500.copyWith(
                              color: defaultDarkBlue, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: devHeight * 0.038),
                        child: Text(
                          'Please Register yourself',
                          softWrap: true,
                          style: montserrat500.copyWith(
                              color: defaultDarkBlue, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: devHeight <= 667
                                ? devHeight * 0.015
                                : devHeight * 0.033),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            DefaultBlueButton(
                                buttonText: 'Login',
                                height: devHeight * 0.065,
                                onPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const RoleSelectionScreen(
                                              isLoginOrRegistration: 'Login'),
                                    ),
                                  );
                                },
                                width: devWidth * 0.455),
                            DefaultBlueButton(
                                buttonText: 'Register',
                                height: devHeight * 0.065,
                                onPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const RoleSelectionScreen(
                                              isLoginOrRegistration:
                                                  'Registration'),
                                    ),
                                  );
                                },
                                width: devWidth * 0.447),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
