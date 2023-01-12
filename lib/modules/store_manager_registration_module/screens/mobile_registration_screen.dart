import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tempx_project/common_blocs/login_bloc.dart';
import 'package:tempx_project/common_components/default_button.dart';
import 'package:tempx_project/common_blocs/send_otp_bloc.dart';
import 'package:tempx_project/modules/store_manager_registration_module/screens/manager_otp_verification_screen.dart';
import 'package:tempx_project/utils/konstants.dart';

class StoreManagerMobileRegistrationScreen extends StatefulWidget {
  final String isLoginOrRegistration;
  const StoreManagerMobileRegistrationScreen(
      {super.key, required this.isLoginOrRegistration});

  @override
  State<StoreManagerMobileRegistrationScreen> createState() =>
      _StoreManagerMobileRegistrationScreenState();
}

class _StoreManagerMobileRegistrationScreenState
    extends State<StoreManagerMobileRegistrationScreen> {
  bool isChecked = false;
  TextEditingController mobileNoController = TextEditingController();
  double buttonOpacity = 0.4;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SendOtpToMobileBloc>();
    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocListener<SendOtpToMobileBloc, SendOtpToMobileState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is SendOtpToMobileSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ManagerOtpVerificationScreen(
                    isLoginOrRegistration: widget.isLoginOrRegistration,
                    mobileNo: mobileNoController.text.trim()),
              ),
            );
          } else if (state is SendOtpToMobileErrorState) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => BlocProvider<LoginBloc>(
                  create: (context) => LoginBloc(),
                  child: ManagerOtpVerificationScreen(
                      isLoginOrRegistration: widget.isLoginOrRegistration,
                      mobileNo: mobileNoController.text.trim()),
                ),
              ),
            );
            // Navigator.push(
            //                   context,
            //                   MaterialPageRoute<void>(
            //                     builder: (BuildContext context) =>
            //                         OTPVerificationScreen(
            //                             isLoginOrRegistration:
            //                                 widget.isLoginOrRegistration,
            //                             mobileNo:
            //                                 mobileNoController.text.trim()),
            //                   ),
            //                 );
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
              style:
                  montserrat600.copyWith(fontSize: 20, color: defaultLightBlue),
            ),
          ),
          body: Stack(children: [
            Image.asset(
              'assets/images/landing_page_bg.jpeg',
              opacity: const AlwaysStoppedAnimation(.33),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: devHeight * 0.13, bottom: devHeight * 0.071),
                  child: Center(
                    child: Text(
                      'Enter your Mobile No',
                      style: montserrat600.copyWith(
                          color: defaultDarkBlue, fontSize: 24),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Make sure you can access',
                    style: widget.isLoginOrRegistration == 'Login'
                        ? montserrat400.copyWith(
                            color: defaultDarkBlue, fontSize: 20)
                        : montserrat500.copyWith(
                            color: defaultDarkBlue, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: devHeight * 0.0162),
                  child: Center(
                    child: Text(
                      'Number on this device',
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
                      bottom: devHeight * 0.119),
                  child: Stack(
                    alignment: Alignment.topLeft,
                    clipBehavior: Clip.none,
                    children: [
                      Material(
                        elevation: 15,
                        shadowColor: const Color.fromRGBO(54, 67, 115, 0.15),
                        borderRadius: BorderRadius.circular(30),
                        child: TextField(
                          controller: mobileNoController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 10,
                          onChanged: (value) {
                            buttonVisiblity();
                          },
                          style: const TextStyle(fontSize: 20),
                          keyboardType: TextInputType.phone,
                          decoration: defaultTextFieldDecoration.copyWith(
                            contentPadding: devHeight <= 667
                                ? const EdgeInsets.all(20)
                                : null,
                            prefix: const Text('+1 -       '),
                            counterText: "",
                            hintText: widget.isLoginOrRegistration == 'Login'
                                ? 'Enter Your Mobile No'
                                : 'Enter 10 digit Mobile No',
                          ),
                        ),
                      ),
                      Positioned(
                        top: devHeight * 0.005,
                        left: -devWidth * 0.008,
                        child: Image.asset(
                          'assets/images/mobile_no_prefix.png',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: devHeight * 0.02),
                  child: widget.isLoginOrRegistration == 'Login'
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
                Hero(
                  tag: 'BottomButtonTag',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultBlueButton(
                          opacity: buttonOpacity,
                          textOrLoader: BlocBuilder<SendOtpToMobileBloc,
                              SendOtpToMobileState>(builder: (context, state) {
                            if (state is SendOtpToMobileLoadingState) {
                              return const SpinKitFadingFour(
                                color: defaultLightBlue,
                              );
                            } else {
                              return Text(
                                'Next',
                                style: montserrat600.copyWith(
                                    fontSize: 22, color: secondaryButtonBlue),
                              );
                            }
                          }),
                          buttonText: 'Next',
                          height: devHeight * 0.069,
                          onPress: () {
                            if (buttonOpacity == 1) {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute<void>(
                              //     builder: (BuildContext context) =>
                              //         ManagerOtpVerificationScreen(
                              //             isLoginOrRegistration:
                              //                 widget.isLoginOrRegistration,
                              //             mobileNo:
                              //                 mobileNoController.text.trim()),
                              //   ),
                              // );
                              nextButtonOnClick();
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
    );
  }

  void nextButtonOnClick() {
    BlocProvider.of<SendOtpToMobileBloc>(context).add(
        SendOtpToMobileEvent(mobileNum: mobileNoController.text.trimRight()));
  }

  void buttonVisiblity() {
    if (widget.isLoginOrRegistration == 'Login') {
      if (mobileNoController.text.trim().length == 10) {
        buttonOpacity = 1;
      } else {
        buttonOpacity = 0.4;
      }
    } else {
      if (mobileNoController.text.trim().length == 10 && isChecked == true) {
        buttonOpacity = 1;
      } else {
        buttonOpacity = 0.4;
      }
    }
    setState(() {});
  }
}

class AlwaysActiveBorderSide extends MaterialStateBorderSide {
  @override
  BorderSide? resolve(states) => const BorderSide(color: defaultButtonBlue);
}
