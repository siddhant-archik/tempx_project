import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tempx_project/common_components/default_button.dart';
import 'package:tempx_project/modules/candidate_registration_module/bloc/send_activate_email_bloc.dart';
import 'package:tempx_project/modules/candidate_registration_module/screens/email_activation_screen.dart';
import 'package:tempx_project/modules/candidate_registration_module/screens/set_password_screen.dart';
import 'package:tempx_project/modules/employer_registration_module/screens/mobile_registration_screen.dart';
import 'package:tempx_project/utils/helpers.dart';
import 'package:tempx_project/utils/konstants.dart';

class EnterEmailScreen extends StatefulWidget {
  final String isForRegOrForgotPassword;
  const EnterEmailScreen({super.key, required this.isForRegOrForgotPassword});

  @override
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  double buttonOpacity = 0.4;
  bool isChecked = false;
  bool emailLimitValidationError = false;
  bool ignoreWhenLoadingState = false;
  String stateErrorMessage = '';
  Helpers helper = Helpers();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;
    final bloc = context.read<SendActivateEmailBloc>();
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocListener<SendActivateEmailBloc, SendActivateEmailState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is SendActivateEmailSuccessState) {
            ignoreWhenLoadingState = false;
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    EmailActivationScreen(email: emailController.text),
              ),
            );
          } else if (state is SendActivateEmailErrorState) {
            ignoreWhenLoadingState = false;
            stateErrorMessage = state.err;
            setState(() {});
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
                  opacity: const AlwaysStoppedAnimation(.33),
                ),
                Column(
                  children: [
                    widget.isForRegOrForgotPassword == 'Forgot Password'
                        ? Container()
                        : Visibility(
                            visible: emailLimitValidationError,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: devHeight * 0.028),
                                  child: Center(
                                    child: Text('You have exceeded',
                                        style: montserrat500.copyWith(
                                            color: defaultRed, fontSize: 20)),
                                  ),
                                ),
                                Center(
                                  child: Text('maximum limit of entering',
                                      style: montserrat500.copyWith(
                                          color: defaultRed, fontSize: 20)),
                                ),
                                Center(
                                  child: Text('differnt Emails',
                                      style: montserrat500.copyWith(
                                          color: defaultRed, fontSize: 20)),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: devHeight * 0.025),
                                  child: Center(
                                    child: Text('Please try after 30 mins',
                                        style: montserrat500.copyWith(
                                            color: defaultRed, fontSize: 20)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: emailLimitValidationError
                              ? devHeight * 0.021
                              : devHeight * 0.16,
                          bottom: devHeight * 0.061),
                      child: Center(
                        child: Text(
                          'Enter your Email',
                          style: montserrat600.copyWith(
                              color: defaultDarkBlue, fontSize: 24),
                        ),
                      ),
                    ),
                    Center(
                      child: Text('Make sure you can access',
                          style: montserrat400.copyWith(
                              color: defaultDarkBlue, fontSize: 20)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: devHeight * 0.032),
                      child: Center(
                        child: Text('the email on this device',
                            style: montserrat400.copyWith(
                                color: defaultDarkBlue, fontSize: 20)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: devWidth * 0.024,
                          left: devWidth * 0.024,
                          bottom: devHeight * 0.092),
                      child: Column(
                        children: [
                          Material(
                            elevation: 15,
                            shadowColor:
                                const Color.fromRGBO(54, 67, 115, 0.15),
                            borderRadius: BorderRadius.circular(30),
                            child: TextField(
                              controller: emailController,
                              // inputFormatters: [FilteringTextInputFormatter],
                              onChanged: (value) {
                                buttonVisiblity();
                              },
                              style: const TextStyle(fontSize: 20),
                              keyboardType: TextInputType.emailAddress,
                              decoration: defaultTextFieldDecoration.copyWith(
                                  contentPadding: devHeight <= 667
                                      ? const EdgeInsets.all(19.0)
                                      : const EdgeInsets.all(20.0),
                                  counterText: "",
                                  hintText: 'Enter Email',
                                  hintStyle: montserrat300Normal),
                            ),
                          ),
                          stateErrorMessage == ''
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.only(
                                      top: helper.getHeight(context, 10)),
                                  child: Text(stateErrorMessage,
                                      style: montserrat500.copyWith(
                                          color: defaultRed, fontSize: 16)),
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: devHeight * 0.03),
                      child: widget.isForRegOrForgotPassword ==
                              'Forgot Password'
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: devWidth * 0.043,
                                  height: devHeight * 0.018,
                                  child: Material(
                                    child: Checkbox(
                                      value: isChecked,
                                      checkColor: defaultButtonBlue,
                                      side: AlwaysActiveBorderSide(),
                                      fillColor: MaterialStateColor.resolveWith(
                                        (states) {
                                          return Colors.white;
                                        },
                                      ),
                                      onChanged: ((value) {
                                        setState(() {
                                          isChecked = value!;
                                          buttonVisiblity();
                                        });
                                      }),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: devWidth * 0.038,
                                ),
                                Text(
                                  ' I Accept Terms & Conditions',
                                  style: montserrat400,
                                )
                              ],
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultBlueButton(
                            opacity: buttonOpacity,
                            textOrLoader: BlocBuilder<SendActivateEmailBloc,
                                    SendActivateEmailState>(
                                builder: (context, state) {
                              if (state is SendActivateEmailLoadingState) {
                                return const SpinKitFadingFour(
                                  color: defaultLightBlue,
                                );
                              } else {
                                return Text(
                                  'Submit',
                                  style: montserrat600.copyWith(
                                      fontSize: 20, color: defaultLightBlue),
                                );
                              }
                            }),
                            buttonText: 'Submit',
                            height: devHeight * 0.069,
                            onPress: () {
                              if (buttonOpacity == 1) {
                                if (widget.isForRegOrForgotPassword ==
                                    'Forgot Password') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const SetPasswordScreen(
                                              isForRegOrForgotPassword:
                                                  'Forgot Password'),
                                    ),
                                  );
                                } else {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute<void>(
                                  //     builder: (BuildContext context) =>
                                  //         EmailActivationScreen(
                                  //             email: emailController.text),
                                  //   ),
                                  // );
                                  sendActivationEmailOnTap();
                                }
                              }
                            },
                            buttonTextColor: secondaryButtonBlue,
                            buttonTextSize: 22,
                            width: devWidth * 0.56),
                      ],
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

  void sendActivationEmailOnTap() async {
    stateErrorMessage = '';
    ignoreWhenLoadingState = true;
    setState(() {});
    String? deviceId = await helper.getDeviceId();
    if (!mounted) return;
    BlocProvider.of<SendActivateEmailBloc>(context).add(SendActivateEmailEvent(
        email: emailController.text.trimRight(), deviceId: deviceId ?? ""));
  }

  void buttonVisiblity() {
    bool emailCheck = emailRegx.hasMatch(emailController.text.trim());
    if (widget.isForRegOrForgotPassword == 'Forgot Password') {
      if (emailCheck) {
        buttonOpacity = 1;
      } else {
        buttonOpacity = 0.4;
      }
    } else if (emailCheck && isChecked == true) {
      buttonOpacity = 1;
    } else {
      buttonOpacity = 0.4;
    }

    setState(() {});
  }
}
