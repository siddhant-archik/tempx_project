import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tempx_project/common_blocs/get_city_by_province_bloc.dart';
import 'package:tempx_project/common_blocs/get_provinces_bloc.dart';
import 'package:tempx_project/common_components/default_button.dart';
import 'package:tempx_project/modules/candidate_registration_module/bloc/candidate_registration_bloc.dart';
import 'package:tempx_project/modules/candidate_registration_module/bloc/set_password_bloc.dart';
import 'package:tempx_project/modules/candidate_registration_module/screens/candidate_login_screen.dart';
import 'package:tempx_project/modules/candidate_registration_module/screens/candidate_registration_form.dart';
import 'package:tempx_project/utils/helpers.dart';
import 'package:tempx_project/utils/konstants.dart';

class SetPasswordScreen extends StatefulWidget {
  final String isForRegOrForgotPassword;
  final String? emailForReg;
  const SetPasswordScreen(
      {super.key, required this.isForRegOrForgotPassword, this.emailForReg});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Helpers helper = Helpers();

  double buttonOpacity = 0.4;

  String stateErrorMessage = '';

  bool passwordIconCheckVisiblity = false;
  bool confirmPasswordIconCheckVisiblity = false;
  bool diffPasswordIconCheckVisiblity = false;
  bool confirmIconVisiblity = false;
  bool ignoreWhenLoadingState = false;
  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocListener<SetCandidatePasswordBloc, SetCandidatePasswordState>(
        bloc: context.read<SetCandidatePasswordBloc>(),
        listener: (context, state) {
          if (state is SetCandidatePasswordSuccessState) {
            ignoreWhenLoadingState = false;
            if (widget.isForRegOrForgotPassword == "Forgot Password") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const CandidateLoginScreen(),
                ),
              );
            }
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    BlocProvider<RegisterCandidateBloc>(
                  create: (context) => RegisterCandidateBloc(),
                  child: BlocProvider<GetProvinceListBloc>(
                    create: ((context) => GetProvinceListBloc()),
                    child: BlocProvider<GetCityByProvinceListBloc>(
                      create: (context) => GetCityByProvinceListBloc(),
                      child: CandidateRegistrationFormScreen(
                          email: widget.emailForReg!),
                    ),
                  ),
                ),
              ),
            );
          } else if (state is SetCandidatePasswordErrorState) {
            ignoreWhenLoadingState = false;
            stateErrorMessage = state.err;
            setState(() {});
            Fluttertoast.showToast(
                msg: stateErrorMessage,
                backgroundColor: Colors.red[400],
                fontSize: 22,
                timeInSecForIosWeb: 10);
          }
        },
        child: IgnorePointer(
          ignoring: ignoreWhenLoadingState,
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
                widget.isForRegOrForgotPassword == 'Forgot Password'
                    ? 'Forgot Password'
                    : 'Candidate Registration',
                style: montserrat500.copyWith(
                    fontSize: 20, color: defaultLightBlue),
              ),
            ),
            body: Stack(
              children: [
                Image.asset(
                  'assets/images/landing_page_bg.jpeg',
                  opacity: const AlwaysStoppedAnimation(.27),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: devHeight * 0.09, bottom: devHeight * 0.069),
                      child: Center(
                        child: Text(
                          'Set Password',
                          style: montserrat500.copyWith(color: defaultDarkBlue),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 3),
                      child: Text(
                        'Type Password',
                        style: montserrat400.copyWith(
                            color: defaultDarkBlue, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: devWidth * 0.024,
                          left: devWidth * 0.024,
                          bottom: devHeight * 0.04),
                      child: Material(
                        elevation: 15,
                        shadowColor: const Color.fromRGBO(54, 67, 115, 0.15),
                        borderRadius: BorderRadius.circular(30),
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextField(
                              controller: passwordController,
                              onChanged: (value) {
                                passwordValidator();
                              },
                              obscureText: false,
                              obscuringCharacter: '*',
                              style: const TextStyle(fontSize: 20),
                              decoration: defaultTextFieldDecoration.copyWith(
                                contentPadding: devHeight <= 667
                                    ? const EdgeInsets.all(19.0)
                                    : const EdgeInsets.all(20.0),
                                counterText: "",
                                hintText: 'Enter Password',
                              ),
                            ),
                            Visibility(
                              visible: passwordIconCheckVisiblity,
                              child: Positioned(
                                right: 20,
                                child: Image.asset(
                                  'assets/images/success_check_icon.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 3),
                      child: Text(
                        'Re-Type Password',
                        style: montserrat400.copyWith(
                            color: defaultDarkBlue, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: devWidth * 0.024,
                          left: devWidth * 0.024,
                          bottom: diffPasswordIconCheckVisiblity
                              ? devHeight * 0.01
                              : devHeight * 0.02),
                      child: Material(
                        elevation: 15,
                        shadowColor: const Color.fromRGBO(54, 67, 115, 0.15),
                        borderRadius: BorderRadius.circular(30),
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextField(
                              controller: confirmPasswordController,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  confirmIconVisiblity = false;
                                  setState(() {});
                                } else {
                                  confirmPasswordValidator();
                                }
                              },
                              obscureText: false,
                              obscuringCharacter: '*',
                              style: const TextStyle(fontSize: 20),
                              decoration: defaultTextFieldDecoration.copyWith(
                                contentPadding: devHeight <= 667
                                    ? const EdgeInsets.all(19.0)
                                    : const EdgeInsets.all(20.0),
                                counterText: "",
                                hintText: 'Confirm Password',
                              ),
                            ),
                            Visibility(
                              visible: confirmIconVisiblity,
                              child: Positioned(
                                right: 20,
                                child: Image.asset(
                                  diffPasswordIconCheckVisiblity
                                      ? 'assets/images/error_icon.png'
                                      : 'assets/images/success_check_icon.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: devHeight * 0.02),
                      child: Visibility(
                        visible: confirmIconVisiblity &&
                            diffPasswordIconCheckVisiblity,
                        child: Center(
                          child: Text(
                            'Passwords Not Matching',
                            style: montserrat400.copyWith(
                                color: const Color(0xffFC5E2C), fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Min 8 Char, min 1-Small, 1-Capital',
                        style: montserrat400.copyWith(
                            color: defaultDarkBlue, fontSize: 16),
                      ),
                    ),
                    Center(
                      child: Text(
                        '1-Numeric, 1-Special Character',
                        style: montserrat400.copyWith(
                            color: defaultDarkBlue, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: devHeight * 0.0564),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultBlueButton(
                              buttonTextSize: 24,
                              opacity: buttonOpacity,
                              textOrLoader: BlocBuilder<
                                      SetCandidatePasswordBloc,
                                      SetCandidatePasswordState>(
                                  builder: (context, state) {
                                if (state is SetCandidatePasswordLoadingState) {
                                  return const SpinKitFadingFour(
                                    color: defaultLightBlue,
                                  );
                                } else {
                                  return Text(
                                    'Submit',
                                    style: montserrat600.copyWith(
                                        fontSize: 24, color: defaultLightBlue),
                                  );
                                }
                              }),
                              buttonText: 'Submit',
                              height: helper.getHeight(context, 60),
                              onPress: () {
                                if (buttonOpacity == 1) {
                                  if (widget.isForRegOrForgotPassword ==
                                      'Forgot Password') {
                                  } else {
                                    print("object");
                                    setPasswordOnTap();
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute<void>(
                                    //     builder: (BuildContext context) =>
                                    //         BlocProvider<RegisterCandidateBloc>(
                                    //       create: (context) =>
                                    //           RegisterCandidateBloc(),
                                    //       child:
                                    //           BlocProvider<GetProvinceListBloc>(
                                    //         create: ((context) =>
                                    //             GetProvinceListBloc()),
                                    //         child: BlocProvider<
                                    //             GetCityByProvinceListBloc>(
                                    //           create: (context) =>
                                    //               GetCityByProvinceListBloc(),
                                    //           child:
                                    //               CandidateRegistrationFormScreen(
                                    //                   email:
                                    //                       widget.emailForReg!),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // );
                                  }
                                }
                              },
                              width: helper.getWidth(context, 239)),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void passwordValidator() {
    if (passwordRegx.hasMatch(passwordController.text) &&
        passwordController.text.length >= 8) {
      passwordIconCheckVisiblity = true;
    } else {
      passwordIconCheckVisiblity = false;
      buttonOpacity = 0.4;
    }
    if (passwordController.text != confirmPasswordController.text &&
        confirmPasswordController.text.isNotEmpty) {
      confirmIconVisiblity = true;
      diffPasswordIconCheckVisiblity = true;
      buttonOpacity = 0.4;
    } else if (passwordController.text == confirmPasswordController.text &&
        confirmPasswordController.text.isNotEmpty) {
      confirmIconVisiblity = true;
      diffPasswordIconCheckVisiblity = false;
      buttonOpacity = 1;
    }
    setState(() {});
  }

  void confirmPasswordValidator() {
    if (confirmPasswordController.text != passwordController.text &&
        passwordIconCheckVisiblity) {
      confirmIconVisiblity = true;
      diffPasswordIconCheckVisiblity = true;
      buttonOpacity = 0.4;
    } else if (confirmPasswordController.text == passwordController.text &&
        passwordIconCheckVisiblity == false) {
      confirmIconVisiblity = false;
      diffPasswordIconCheckVisiblity = false;
      buttonOpacity = 0.4;
    } else {
      buttonOpacity = 1;
      confirmIconVisiblity = true;
      diffPasswordIconCheckVisiblity = false;
      confirmPasswordIconCheckVisiblity = true;
    }
    setState(() {});
  }

  void setPasswordOnTap() {
    stateErrorMessage = '';
    ignoreWhenLoadingState = true;
    setState(() {});
    if (!mounted) return;
    BlocProvider.of<SetCandidatePasswordBloc>(context).add(
        SetCandidatePasswordEvent(
            email: widget.emailForReg!,
            password: passwordController.text.trim()));
  }
}
