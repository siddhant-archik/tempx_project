import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tempx_project/common_blocs/login_bloc.dart';
import 'package:tempx_project/common_components/default_button.dart';
import 'package:tempx_project/common_blocs/send_otp_bloc.dart';
import 'package:tempx_project/common_blocs/validate_otp_bloc.dart';
import 'package:tempx_project/common_models/login_model.dart';
import 'package:tempx_project/modules/store_manager_registration_module/screens/name_email_screen.dart';
import 'package:tempx_project/utils/helpers.dart';
import 'package:tempx_project/utils/konstants.dart';

class ManagerOtpVerificationScreen extends StatefulWidget {
  final String mobileNo;
  final String isLoginOrRegistration;
  const ManagerOtpVerificationScreen(
      {super.key, required this.mobileNo, required this.isLoginOrRegistration});

  @override
  State<ManagerOtpVerificationScreen> createState() =>
      _ManagerOtpVerificationScreen();
}

class _ManagerOtpVerificationScreen
    extends State<ManagerOtpVerificationScreen> {
  TextEditingController otpController = TextEditingController();
  double buttonOpacity = 0.4;

  int _start = 30;

  int wrongOtpCounter = 5;
  bool otpSentOnVisiblity = true;
  bool wrongOtpVisiblity = false;
  bool wrongOtpFiveTimesVisiblity = false;

  Helpers helper = Helpers();

  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;
    final bloc = context.read<ValidateOtpToMobileBloc>();
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocListener<LoginBloc, LoginState>(
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
        },
        child: BlocListener<ValidateOtpToMobileBloc, ValidateOtpToMobileState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is ValidateOtpToMobileSuccessState) {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      ManagerNameEmailScreen(mobileNo: widget.mobileNo),
                ),
              );
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute<void>(
              //     builder: (BuildContext context) =>
              //         BlocProvider<RegisterEmployerBloc>(
              //             create: (context) => RegisterEmployerBloc(),
              //             child: EmployerRegistrationFormScreen(
              //                 contactNumber: widget.mobileNo)),
              //   ),
              // );
            } else if (state is ValidateOtpToMobileErrorState) {
              if (state.err == "You have entered the Wrong Otp") {
                if (wrongOtpCounter <= 1) {
                  startTimer();
                  buttonOpacity = 0.4;
                  wrongOtpVisiblity = false;
                  wrongOtpCounter = wrongOtpCounter - 1;
                  wrongOtpFiveTimesVisiblity = true;
                } else {
                  otpSentOnVisiblity = false;
                  wrongOtpCounter = wrongOtpCounter - 1;
                  wrongOtpVisiblity = true;
                }
                setState(() {});
              }
            }
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
                'Store Manager\'s ${widget.isLoginOrRegistration}',
                style: montserrat600.copyWith(
                    fontSize: 20, color: defaultLightBlue),
              ),
            ),
            body: Stack(children: [
              Image.asset(
                'assets/images/landing_page_bg.jpeg',
                opacity: const AlwaysStoppedAnimation(.33),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Visibility(
                    visible: otpSentOnVisiblity,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: devHeight * 0.13),
                          child: Center(
                            child: Text(
                              'OTP Sent on',
                              style: montserrat600.copyWith(
                                  color: defaultDarkBlue, fontSize: 24),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: devHeight * 0.071),
                          child: Center(
                            child: Text(
                              '+1-${widget.mobileNo.substring(0, 3)}-${widget.mobileNo.substring(3, 6)}-${widget.mobileNo.substring(6, 8)}-${widget.mobileNo.substring(8, widget.mobileNo.length)}',
                              style: montserrat600.copyWith(
                                  color: defaultDarkBlue, fontSize: 24),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: wrongOtpVisiblity,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: helper.getHeight(context, 95),
                              bottom: helper.getHeight(context, 25)),
                          child: Text(
                            'You have entered Wrong OTP',
                            style: montserrat500.copyWith(
                                fontSize: 20, color: const Color(0xffEF3209)),
                          ),
                        ),
                        Text(
                          'Please enter correct OTP Sent on',
                          style: montserrat500.copyWith(
                              fontSize: 20, color: const Color(0xffEF3209)),
                        ),
                        Text(
                          '+1-${widget.mobileNo.substring(0, 3)}-${widget.mobileNo.substring(3, 6)}-${widget.mobileNo.substring(6, 8)}-${widget.mobileNo.substring(8, widget.mobileNo.length)}',
                          style: montserrat500.copyWith(
                              fontSize: 20, color: const Color(0xffEF3209)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: helper.getHeight(context, 28),
                              bottom: helper.getHeight(context, 25)),
                          child: Text(
                            '($wrongOtpCounter -Trails Left)',
                            style: montserrat500.copyWith(
                                fontSize: 20, color: const Color(0xffEF3209)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: wrongOtpFiveTimesVisiblity,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: helper.getHeight(context, 130),
                          ),
                          child: Text(
                            'You have entered Wrong OTP',
                            style: montserrat500.copyWith(
                                fontSize: 20, color: const Color(0xffEF3209)),
                          ),
                        ),
                        Text(
                          '5 times',
                          style: montserrat500.copyWith(
                              fontSize: 20, color: const Color(0xffEF3209)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: helper.getHeight(context, 25),
                              bottom: helper.getHeight(context, 30)),
                          child: Text(
                            'Please try after $_start mins',
                            style: montserrat500.copyWith(
                                fontSize: 20, color: const Color(0xffEF3209)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: devHeight * 0.022),
                    child: Center(
                      child: Text(
                        'Enter OTP',
                        style: widget.isLoginOrRegistration == 'Login'
                            ? montserrat400.copyWith(
                                color: defaultDarkBlue, fontSize: 20)
                            : montserrat500.copyWith(
                                color: defaultDarkBlue, fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: devWidth * 0.024,
                        left: devWidth * 0.024,
                        bottom: devHeight * 0.022),
                    child: Material(
                      elevation: 15,
                      shadowColor: const Color.fromRGBO(54, 67, 115, 0.15),
                      borderRadius: BorderRadius.circular(30),
                      child: TextField(
                        controller: otpController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        maxLength: 6,
                        onChanged: (value) {
                          buttonVisiblity();
                        },
                        style: const TextStyle(fontSize: 20),
                        keyboardType: TextInputType.phone,
                        decoration: defaultTextFieldDecoration.copyWith(
                          contentPadding: devHeight <= 667
                              ? const EdgeInsets.all(19.0)
                              : const EdgeInsets.all(20.0),
                          counterText: "",
                          hintText: widget.isLoginOrRegistration == 'Login'
                              ? 'Enter OTP'
                              : 'Enter OTP received on phone',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: devHeight * 0.076),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          onTap: () {
                            if (wrongOtpCounter == 0) {
                              return;
                            }
                            BlocProvider.of<SendOtpToMobileBloc>(context).add(
                                SendOtpToMobileEvent(
                                    mobileNum: widget.mobileNo));
                          },
                          child: Container(
                            width: devWidth * 0.25,
                            height: devHeight * 0.0555,
                            decoration: BoxDecoration(
                                color: wrongOtpCounter == 0
                                    ? Colors.grey[300]
                                    : resendLightBlue,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: wrongOtpCounter == 0
                                        ? Colors.grey
                                        : defaultDarkBlue)),
                            child: BlocBuilder<SendOtpToMobileBloc,
                                    SendOtpToMobileState>(
                                builder: (context, state) {
                              if (state is SendOtpToMobileLoadingState) {
                                return const Center(
                                  child: SpinKitFadingFour(
                                    size: 25,
                                    color: lightDefaultDarkBlue,
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    'Resend',
                                    style: montserrat500.copyWith(fontSize: 16),
                                  ),
                                );
                              }
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Hero(
                    tag: 'BottomButtonTag',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultBlueButton(
                            opacity: buttonOpacity,
                            textOrLoader:
                                widget.isLoginOrRegistration == 'Login'
                                    ? BlocBuilder<LoginBloc, LoginState>(
                                        builder: (context, state) {
                                        if (state is LoginLoadingState) {
                                          return const SpinKitFadingFour(
                                            color: defaultLightBlue,
                                          );
                                        } else {
                                          return Text(
                                            'Submit',
                                            style: montserrat600.copyWith(
                                                fontSize: 22,
                                                color: secondaryButtonBlue),
                                          );
                                        }
                                      })
                                    : BlocBuilder<ValidateOtpToMobileBloc,
                                            ValidateOtpToMobileState>(
                                        builder: (context, state) {
                                        if (state
                                            is ValidateOtpToMobileLoadingState) {
                                          return const SpinKitFadingFour(
                                            color: defaultLightBlue,
                                          );
                                        } else {
                                          return Text(
                                            'Submit',
                                            style: montserrat600.copyWith(
                                                fontSize: 22,
                                                color: secondaryButtonBlue),
                                          );
                                        }
                                      }),
                            buttonText: 'Submit',
                            height: devHeight * 0.069,
                            onPress: () {
                              if (buttonOpacity == 1) {
                                if (widget.isLoginOrRegistration == 'Login') {
                                  loginSubmitOnClick();
                                } else {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute<void>(
                                  //     builder: (BuildContext context) =>
                                  //         const ManagerNameEmailScreen(),
                                  //   ),
                                  // );
                                  submitOnClick();
                                }
                              }
                            },
                            buttonTextColor: secondaryButtonBlue,
                            buttonTextSize: 22,
                            width: devWidth * 0.56),
                      ],
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  void submitOnClick() {
    BlocProvider.of<ValidateOtpToMobileBloc>(context).add(
        ValidateOtpToMobileEvent(
            mobileNum: widget.mobileNo, otp: otpController.text.trim()));
  }

  void loginSubmitOnClick() {
    LoginModel loginData = LoginModel(
        username: widget.mobileNo,
        password: otpController.text,
        userType: "storeManager");
    BlocProvider.of<LoginBloc>(context).add(LoginEvent(loginData: loginData));
  }

  void startTimer() {
    const oneMin = Duration(seconds: 1);
    Timer.periodic(
      oneMin,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            wrongOtpCounter = 5;
            otpSentOnVisiblity = true;
            wrongOtpVisiblity = false;
            wrongOtpFiveTimesVisiblity = false;
            buttonOpacity = 1;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void buttonVisiblity() {
    if (otpController.text.trim().length == 6) {
      buttonOpacity = 1;
    } else {
      buttonOpacity = 0.4;
    }
    setState(() {});
  }
}
