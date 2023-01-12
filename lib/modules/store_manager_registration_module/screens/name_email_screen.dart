import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempx_project/common_blocs/get_business_list_bloc.dart';
import 'package:tempx_project/common_components/default_button.dart';
import 'package:tempx_project/common_components/default_textfield.dart';
import 'package:tempx_project/modules/store_manager_registration_module/screens/link_business_screen.dart';
import 'package:tempx_project/utils/helpers.dart';
import 'package:tempx_project/utils/konstants.dart';

class ManagerNameEmailScreen extends StatefulWidget {
  final String mobileNo;
  const ManagerNameEmailScreen({super.key, required this.mobileNo});

  @override
  State<ManagerNameEmailScreen> createState() => _ManagerNameEmailScreenState();
}

class _ManagerNameEmailScreenState extends State<ManagerNameEmailScreen> {
  Helpers helper = Helpers();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  double buttonOpacity = 0.4;
  @override
  Widget build(BuildContext context) {
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
            'Store Manager\'s Registration',
            style:
                montserrat600.copyWith(fontSize: 20, color: defaultLightBlue),
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
                  padding: EdgeInsets.only(top: helper.getHeight(context, 80)),
                  child: Center(
                      child: Text('You have successfully',
                          style: montserrat500.copyWith(
                              fontSize: 20, color: defaultDarkBlue))),
                ),
                Center(
                    child: Text('Verified mobile Number',
                        style: montserrat500.copyWith(
                          fontSize: 20,
                          color: defaultDarkBlue,
                        ))),
                Padding(
                  padding: EdgeInsets.only(top: helper.getHeight(context, 50)),
                  child: Center(
                      child: Text('Please enter the Below Details',
                          style: montserrat400.copyWith(
                            fontSize: 20,
                          ))),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: helper.getWidth(context, 22),
                      bottom: 5,
                      top: helper.getHeight(context, 22)),
                  child: Text(
                    'Enter Name',
                    style: montserrat400.copyWith(
                        fontSize: 18, color: defaultDarkBlue),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: helper.getWidth(context, 8),
                      right: helper.getWidth(context, 8)),
                  child: DefaultTextField(
                    controller: nameController,
                    hintText: 'Enter Name',
                    onChanged: (value) {
                      fieldsValidator();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: helper.getWidth(context, 22),
                      bottom: 5,
                      top: helper.getHeight(context, 22)),
                  child: Text(
                    'Enter Email',
                    style: montserrat400.copyWith(
                        fontSize: 18, color: defaultDarkBlue),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: helper.getHeight(context, 70),
                      left: helper.getWidth(context, 8),
                      right: helper.getWidth(context, 8)),
                  child: DefaultTextField(
                    controller: emailController,
                    hintText: 'Enter Email',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      fieldsValidator();
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultBlueButton(
                        opacity: buttonOpacity,
                        buttonText: 'Next',
                        height: helper.getHeight(context, 60),
                        onPress: () {
                          if (buttonOpacity == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    BlocProvider<GetBusinessListBloc>(
                                  create: (context) => GetBusinessListBloc(),
                                  child: LinkBusinessScreen(
                                      mobileNo: widget.mobileNo,
                                      name: nameController.text.trim(),
                                      email: emailController.text.trim()),
                                ),
                              ),
                            );
                          }
                        },
                        buttonTextColor: secondaryButtonBlue,
                        buttonTextSize: 22,
                        width: helper.getWidth(context, 239)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void fieldsValidator() {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        !emailRegx.hasMatch(emailController.text.trim())) {
      buttonOpacity = 0.4;
    } else {
      buttonOpacity = 1;
    }
    setState(() {});
  }
}
