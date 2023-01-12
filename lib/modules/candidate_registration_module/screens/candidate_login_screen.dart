import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tempx_project/common_blocs/login_bloc.dart';
import 'package:tempx_project/common_components/default_button.dart';
import 'package:tempx_project/common_components/default_textfield.dart';
import 'package:tempx_project/common_models/login_model.dart';
import 'package:tempx_project/modules/candidate_registration_module/screens/enter_email_screen.dart';
import 'package:tempx_project/utils/helpers.dart';
import 'package:tempx_project/utils/konstants.dart';

class CandidateLoginScreen extends StatefulWidget {
  const CandidateLoginScreen({super.key});

  @override
  State<CandidateLoginScreen> createState() => _CandidateLoginScreenState();
}

class _CandidateLoginScreenState extends State<CandidateLoginScreen> {
  Helpers helper = Helpers();
  double buttonOpacity = 0.4;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: context.read<LoginBloc>(),
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Fluttertoast.showToast(
              msg: 'Logged in',
              backgroundColor: Colors.green[400],
              fontSize: 22,
              timeInSecForIosWeb: 10);
        } else if (state is LoginErrorState) {
          Fluttertoast.showToast(
              msg: state.err,
              backgroundColor: Colors.red[400],
              fontSize: 22,
              timeInSecForIosWeb: 10);
        }
        // Siddhant@007
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
            'Candidate\'s Login',
            style:
                montserrat500.copyWith(fontSize: 20, color: defaultLightBlue),
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/landing_page_bg.jpeg',
              opacity: const AlwaysStoppedAnimation(.33),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: helper.getHeight(context, 50)),
                  child: Center(
                    child: Text(
                      'Welcome to',
                      style: montserrat500.copyWith(fontSize: 24),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Temp X',
                    style: montserrat600.copyWith(fontSize: 24),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: helper.getHeight(context, 27)),
                  child: Center(
                    child: Image.asset(
                      'assets/images/tempxlogo.png',
                      height: helper.getHeight(context, 100),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: helper.getWidth(context, 23),
                      bottom: helper.getHeight(context, 5),
                      top: helper.getHeight(context, 37)),
                  child: Text(
                    'Enter your Email *',
                    textAlign: TextAlign.left,
                    style: montserrat400.copyWith(
                        fontSize: 20, color: defaultDarkBlue),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: helper.getWidth(context, 8),
                      right: helper.getWidth(context, 8)),
                  child: DefaultTextField(
                      controller: emailController,
                      hintText: 'Enter Email',
                      onChanged: (value) {
                        validator();
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: helper.getWidth(context, 23),
                      bottom: helper.getHeight(context, 5),
                      top: helper.getHeight(context, 17)),
                  child: Text(
                    'Type password *',
                    textAlign: TextAlign.left,
                    style: montserrat400.copyWith(
                        fontSize: 20, color: defaultDarkBlue),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: helper.getWidth(context, 8),
                      right: helper.getWidth(context, 8)),
                  child: DefaultTextField(
                      controller: passwordController,
                      obscureText: true,
                      hintText: 'Enter Password',
                      onChanged: (value) {
                        validator();
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(top: helper.getHeight(context, 63)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultBlueButton(
                          textOrLoader: BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                            if (state is LoginLoadingState) {
                              return const SpinKitFadingFour(
                                color: secondaryButtonBlue,
                              );
                            } else {
                              return Text(
                                'Submit',
                                style: montserrat600.copyWith(
                                    fontSize: 22, color: secondaryButtonBlue),
                              );
                            }
                          }),
                          opacity: buttonOpacity,
                          buttonText: 'Submit',
                          height: helper.getHeight(context, 60),
                          onPress: () {
                            if (buttonOpacity == 1) {
                              loginSubmitOnClick();
                            }
                          },
                          buttonTextColor: secondaryButtonBlue,
                          buttonTextSize: 22,
                          width: helper.getWidth(context, 239)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: helper.getHeight(context, 80)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const EnterEmailScreen(
                            isForRegOrForgotPassword: 'Forgot Password',
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'Forgot Passowrd',
                        style: montserrat400.copyWith(fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void loginSubmitOnClick() {
    LoginModel loginData = LoginModel(
        username: emailController.text.trim(),
        password: passwordController.text.trim(),
        userType: "candidate");
    BlocProvider.of<LoginBloc>(context).add(LoginEvent(loginData: loginData));
  }

  void validator() {
    bool emailCheck = emailRegx.hasMatch(emailController.text.trim());
    if (emailCheck == true &&
        emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty) {
      buttonOpacity = 1;
    } else {
      buttonOpacity = 0.4;
    }
    setState(() {});
  }
}
