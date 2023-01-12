import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tempx_project/common_blocs/get_city_by_province_bloc.dart';
import 'package:tempx_project/common_blocs/get_industry_bloc.dart';
import 'package:tempx_project/common_blocs/get_provinces_bloc.dart';
import 'package:tempx_project/common_components/default_button.dart';
import 'package:tempx_project/common_components/default_textfield.dart';
import 'package:tempx_project/common_models/city_by_province_list_model.dart';
import 'package:tempx_project/common_models/provinces_list_model.dart';
import 'package:tempx_project/common_services/send_otp_on_whatsapp.dart';
import 'package:tempx_project/modules/candidate_registration_module/bloc/candidate_registration_bloc.dart';
import 'package:tempx_project/modules/candidate_registration_module/models/candidate_registration_model.dart';
import 'package:tempx_project/modules/candidate_registration_module/screens/add_experience_screen.dart';
import 'package:tempx_project/modules/candidate_registration_module/screens/registration_completed_screen.dart';
import 'package:tempx_project/modules/candidate_registration_module/screens/verify_otp_screen.dart';
import 'package:tempx_project/utils/helpers.dart';
import 'package:tempx_project/utils/konstants.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CandidateRegistrationFormScreen extends StatefulWidget {
  final String email;
  const CandidateRegistrationFormScreen({super.key, required this.email});

  @override
  State<CandidateRegistrationFormScreen> createState() =>
      _CandidateRegistrationFormScreenState();
}

class _CandidateRegistrationFormScreenState
    extends State<CandidateRegistrationFormScreen> {
  Helpers helper = Helpers();
  List<int> selectedIndustryIndex = [1];

  List<Province>? provinceForAddExp = [];

  int residentInCanadaToggleValue = 1;
  int workPermitInCanadaToggleValue = 1;
  int genderToggleValue = 1;
  int doYouDriveToggleValue = 1;
  int doYouHaveCarToggleValue = 1;
  TextEditingController dobController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  List<int> selectedCities = [];
  bool sendOtpLoading = false;

  int yearCount = 0;

  TextEditingController mobileNocontroller = TextEditingController();
  List<CandidateExperienceModel> candidateExperienceList = [];

  Province? provinceValue;
  var cityByProvienceValue;
  String qualificationValue = '';
  String countryCode = '';
  String statusValue = '';

  @override
  void initState() {
    BlocProvider.of<GetIndustryListBloc>(context).add(GetIndustryListEvent());
    BlocProvider.of<GetProvinceListBloc>(context).add(GetProvinceListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocListener<GetProvinceListBloc, GetProvinceListState>(
        bloc: BlocProvider.of<GetProvinceListBloc>(context),
        listener: (context, state) {
          if (state is GetProvinceListSuccessState) {
            provinceForAddExp = state.provinceList;
            setState(() {});
          }
        },
        child: BlocListener<RegisterCandidateBloc, RegisterCandidateState>(
          bloc: BlocProvider.of<RegisterCandidateBloc>(context),
          listener: ((context, state) {
            if (state is RegisterCandidateSuccessState) {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const RegistrationCompletedScreen(),
                ),
              );
            } else if (state is RegisterCandidateErrorState) {
              Fluttertoast.showToast(
                  // msg: customMessage == ''
                  //     ? spllited[0].trimRight() + output
                  //     : customMessage,
                  msg: state.err,
                  backgroundColor: Colors.red[400],
                  fontSize: 22,
                  timeInSecForIosWeb: 10);
            }
          }),
          child: Scaffold(
            backgroundColor: lightBlueFillColor,
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
                style: montserrat500.copyWith(
                    fontSize: 20, color: defaultLightBlue),
              ),
            ),
            body: Scrollbar(
              thickness: 6,
              radius: const Radius.circular(10),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: helper.getHeight(context, 23),
                            bottom: helper.getHeight(context, 24)),
                        child: Center(
                          child: Text(
                            'Enter Details Below',
                            style: montserrat500.copyWith(
                                fontSize: 20, color: defaultDarkBlue),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15), bottom: 3),
                        child: Text(
                          'Select Country Code for Mobile',
                          style: montserrat400.copyWith(
                              fontSize: 18, color: defaultDarkBlue),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: helper.getHeight(context, 5),
                            bottom: helper.getHeight(context, 0)),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(18, 8, 12, 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: textFieldBorderColor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: const SizedBox(),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              size: 45,
                            ),
                            value: countryCode == '' ? null : countryCode,
                            hint: const Text('Canada  (+1)'),
                            style: montserrat400.copyWith(
                                fontSize: 20, color: defaultDarkBlue),
                            items: <String>[
                              'Canada  (+1)',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              countryCode = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: helper.getHeight(context, 24),
                            left: helper.getWidth(context, 15),
                            right: helper.getWidth(context, 15),
                            bottom: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Enter Whatsapp Number',
                              style: montserrat500.copyWith(
                                  fontSize: 18, color: defaultDarkBlue),
                            ),
                            Text(
                              'Not Verified',
                              style: montserrat400.copyWith(
                                  fontSize: 18, color: const Color(0xffF07503)),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Material(
                            elevation: 15,
                            shadowColor:
                                const Color.fromRGBO(54, 67, 115, 0.15),
                            borderRadius: BorderRadius.circular(30),
                            child: TextField(
                              controller: mobileNocontroller,
                              onChanged: (value) {},
                              style: const TextStyle(fontSize: 20),
                              decoration: defaultTextFieldDecoration.copyWith(
                                  contentPadding: const EdgeInsets.all(20),
                                  counterText: "",
                                  hintText: '123-456-7890',
                                  filled: true,
                                  fillColor: textFieldFillColor,
                                  hintStyle: GoogleFonts.montserrat(
                                      color: textFieldHintTextLightBlue,
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 20)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.close),
                              SizedBox(
                                width: helper.getWidth(context, 5),
                              ),
                              DefaultBlueButton(
                                  textOrLoader: sendOtpLoading == true
                                      ? const SpinKitFadingFour(
                                          color: defaultLightBlue,
                                          size: 20,
                                        )
                                      : Text(
                                          'Send OTP',
                                          style: montserrat600.copyWith(
                                              fontSize: 18,
                                              color: defaultLightBlue),
                                        ),
                                  buttonBorderColor: Colors.transparent,
                                  buttonColor: const Color(0xff5D6B9F),
                                  buttonText: 'Send OTP',
                                  height: helper.getHeight(context, 63),
                                  onPress: () {
                                    // sendOtpLoading = true;
                                    SendOtpOnWhatsapp sendOtp =
                                        SendOtpOnWhatsapp();
                                    sendOtp.sendOtpWhastapp(
                                        mobileNocontroller.text.trim());
                                    setState(() {});
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute<void>(
                                    //     builder: (BuildContext context) =>
                                    //         const VerifyOtpScreen(
                                    //             verifyOrNumNotFoundCheck:
                                    //                 // 'VerifyOTP'
                                    //                 'NumNotFound'),
                                    //   ),
                                    // );
                                  },
                                  width: helper.getWidth(context, 128)),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 5),
                            top: helper.getHeight(context, 25)),
                        child: Text(
                          'Select Industry',
                          style: montserrat400.copyWith(
                              fontSize: 20, color: defaultDarkBlue),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            helper.getWidth(context, 15),
                            0,
                            helper.getWidth(context, 15),
                            0),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff667BC3))),
                        ),
                      ),
                      selectIndustrySection(),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 5),
                            top: 0),
                        child: Text(
                          'Enter Name *',
                          style: montserrat400.copyWith(
                              fontSize: 18, color: defaultDarkBlue),
                        ),
                      ),
                      DefaultTextField(
                          controller: nameController,
                          devHeight: devHeight,
                          hintText: 'Enter Name',
                          onChanged: (value) {}),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 5),
                            top: helper.getHeight(context, 15)),
                        child: Text(
                          'Enter Year of Experience *',
                          style: montserrat400.copyWith(
                              fontSize: 18, color: defaultDarkBlue),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        clipBehavior: Clip.none,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                            elevation: 15,
                            shadowColor:
                                const Color.fromRGBO(54, 67, 115, 0.15),
                            child: Container(
                              // width: helper.getWidth(context, 420),
                              height: helper.getHeight(context, 62),
                              decoration: BoxDecoration(
                                  color: textFieldFillColor,
                                  border:
                                      Border.all(color: textFieldBorderColor),
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                          Positioned(
                            left: 30,
                            child: Text(
                              yearCount.toString(),
                              style: montserrat400.copyWith(
                                  fontSize: 20, color: defaultDarkBlue),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: helper.getWidth(context, 20)),
                            child: Column(
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    yearCount += 1;
                                    setState(() {});
                                  },
                                  child: const Icon(
                                    Icons.arrow_drop_up_outlined,
                                    color: secondaryBorderColor,
                                    size: 40,
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    if (yearCount == 0) {
                                      return;
                                    } else {
                                      yearCount -= 1;
                                    }
                                    setState(() {});
                                  },
                                  child: const Icon(
                                    Icons.arrow_drop_down_outlined,
                                    color: secondaryBorderColor,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            right: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 15),
                            top: helper.getHeight(context, 15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Residing in Canada ?',
                              style: montserrat400.copyWith(
                                  fontSize: 18, color: defaultDarkBlue),
                            ),
                            ToggleSwitch(
                              cornerRadius: 30.0,
                              activeBgColor: const [Color(0xff5D6B9F)],
                              inactiveBgColor: const Color(0xffD9E0FA),
                              customWidths: const [83, 83],
                              minHeight: 50,
                              initialLabelIndex: residentInCanadaToggleValue,
                              totalSwitches: 2,
                              customTextStyles: [
                                residentInCanadaToggleValue == 0
                                    ? montserrat600.copyWith(
                                        color: Colors.white, fontSize: 18)
                                    : montserrat400.copyWith(
                                        color: const Color(0xff667BC3),
                                        fontSize: 18),
                                residentInCanadaToggleValue == 1
                                    ? montserrat600.copyWith(
                                        color: Colors.white, fontSize: 18)
                                    : montserrat400.copyWith(
                                        color: const Color(0xff667BC3),
                                        fontSize: 18)
                              ],
                              labels: const ['No', 'Yes'],
                              radiusStyle: true,
                              onToggle: (index) {
                                residentInCanadaToggleValue = index!;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 5),
                            top: helper.getHeight(context, 15)),
                        child: Text(
                          'Select Province',
                          style: montserrat400.copyWith(
                              fontSize: 18, color: defaultDarkBlue),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(18, 8, 12, 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: textFieldBorderColor),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButton(
                          menuMaxHeight: helper.getHeight(context, 300),
                          isExpanded: true,
                          underline: const SizedBox(),
                          hint: const Text('Province'),
                          value: provinceValue ?? null,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 45,
                          ),
                          style: montserrat400.copyWith(
                              fontSize: 20, color: const Color(0xff5265A8)),
                          items: provinceForAddExp!.map((e) {
                            return DropdownMenuItem(
                                value: e, child: Text(e.provinceName));
                          }).toList(),
                          onChanged: (value) {
                            provinceValue = value;
                            cityByProvienceValue = null;
                            selectedCities = [];
                            setState(() {});
                            BlocProvider.of<GetCityByProvinceListBloc>(context)
                                .add(GetCityByProvinceListEvent(
                                    provinceId:
                                        provinceValue!.provinceId.toString()));
                            // print(provinceValue.provinceName);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 5),
                            top: helper.getHeight(context, 15)),
                        child: Text(
                          'Select City',
                          style: montserrat400.copyWith(
                              fontSize: 18, color: defaultDarkBlue),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(18, 8, 12, 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: textFieldBorderColor),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: BlocBuilder<GetCityByProvinceListBloc,
                                GetCityByProvinceListState>(
                            builder: (context, state) {
                          if (state is GetCityByProvinceListSuccessState) {
                            return DropdownButton(
                              menuMaxHeight: helper.getHeight(context, 300),
                              isExpanded: true,
                              underline: const SizedBox(),
                              hint: const Text('City'),
                              value: cityByProvienceValue ?? null,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                size: 45,
                              ),
                              style: montserrat400.copyWith(
                                  fontSize: 20, color: const Color(0xff5265A8)),
                              items: state.cityByProvinceList.map((e) {
                                return DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.cityName,
                                      // style: TextStyle(
                                      //     fontSize: 19,
                                      //     color: Colors.black),
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                cityByProvienceValue = value;
                                setState(() {});
                              },
                            );
                          }
                          return DropdownButton<String>(
                            isExpanded: true,
                            underline: const SizedBox(),
                            hint: const Text('City'),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              size: 45,
                            ),
                            style: montserrat400.copyWith(
                                fontSize: 18, color: const Color(0xff5265A8)),
                            items: <String>[].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          );
                        }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            right: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 5),
                            top: helper.getHeight(context, 15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Do you have',
                                  softWrap: true,
                                  style: montserrat400.copyWith(
                                      fontSize: 18, color: defaultDarkBlue),
                                ),
                                Text(
                                  'Canada Work Permit?',
                                  softWrap: true,
                                  style: montserrat400.copyWith(
                                      fontSize: 18, color: defaultDarkBlue),
                                ),
                              ],
                            ),
                            ToggleSwitch(
                              cornerRadius: 30.0,
                              activeBgColor: const [Color(0xff5D6B9F)],
                              inactiveBgColor: const Color(0xffD9E0FA),
                              customWidths: const [83, 83],
                              minHeight: 50,
                              initialLabelIndex: workPermitInCanadaToggleValue,
                              totalSwitches: 2,
                              customTextStyles: [
                                workPermitInCanadaToggleValue == 0
                                    ? montserrat600.copyWith(
                                        color: Colors.white, fontSize: 18)
                                    : montserrat400.copyWith(
                                        color: const Color(0xff667BC3),
                                        fontSize: 18),
                                workPermitInCanadaToggleValue == 1
                                    ? montserrat600.copyWith(
                                        color: Colors.white, fontSize: 18)
                                    : montserrat400.copyWith(
                                        color: const Color(0xff667BC3),
                                        fontSize: 18)
                              ],
                              labels: const ['No', 'Yes'],
                              radiusStyle: true,
                              onToggle: (index) {
                                workPermitInCanadaToggleValue = index!;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 5),
                            top: helper.getHeight(context, 20)),
                        child: Text(
                          'Select 3 Preffered Cities in Canada *',
                          style: montserrat400.copyWith(
                              fontSize: 18, color: defaultDarkBlue),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(18, 8, 12, 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: textFieldBorderColor),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: BlocBuilder<GetCityByProvinceListBloc,
                                GetCityByProvinceListState>(
                            builder: (context, state) {
                          if (state is GetCityByProvinceListSuccessState) {
                            return DropdownButton(
                              menuMaxHeight: helper.getHeight(context, 300),
                              isExpanded: true,
                              underline: const SizedBox(),
                              // hint: const Text('City'),
                              // value: cityByProvienceValue ?? null,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                size: 45,
                              ),
                              style: montserrat400.copyWith(
                                  fontSize: 20, color: const Color(0xff5265A8)),
                              items: state.cityByProvinceList.map((e) {
                                return DropdownMenuItem(
                                    value: e,
                                    child: StatefulBuilder(
                                        builder: (context, setState) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e.cityName,
                                            style: selectedCities
                                                    .contains(e.cityId)
                                                ? montserrat600.copyWith(
                                                    fontSize: 18,
                                                    color:
                                                        const Color(0xff223A92))
                                                : montserrat500.copyWith(
                                                    fontSize: 18,
                                                    color: const Color(
                                                        0xff6781D4)),
                                          ),
                                          Checkbox(
                                              value: selectedCities
                                                      .contains(e.cityId)
                                                  ? true
                                                  : false,
                                              activeColor:
                                                  const Color(0xffA9B7E9),
                                              checkColor:
                                                  const Color(0xffA9B7E9),
                                              shape:
                                                  const RoundedRectangleBorder(),
                                              side: MaterialStateBorderSide
                                                  .resolveWith(
                                                (states) => const BorderSide(
                                                    width: 1.0,
                                                    color: defaultDarkBlue),
                                              ),
                                              // side: const BorderSide(
                                              //     color: defaultDarkBlue),
                                              onChanged: (value) {
                                                print(e.cityId);
                                                if (selectedCities
                                                    .contains(e.cityId)) {
                                                  selectedCities
                                                      .remove(e.cityId);
                                                } else {
                                                  if (selectedCities.length <=
                                                      2) {
                                                    selectedCities
                                                        .add(e.cityId);
                                                  }
                                                }
                                                setState(() {});
                                              }),
                                        ],
                                      );
                                    }));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {});
                                setState(() {});
                              },
                            );
                          }
                          return DropdownButton<String>(
                            isExpanded: true,
                            underline: const SizedBox(),
                            // hint: const Text('City'),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              size: 45,
                            ),
                            style: montserrat400.copyWith(
                                fontSize: 18, color: const Color(0xff5265A8)),
                            items: <String>[].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          );
                        }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 5),
                            top: helper.getHeight(context, 20)),
                        child: Text(
                          'Do you Drive ?',
                          style: montserrat400.copyWith(
                              fontSize: 18, color: defaultDarkBlue),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            right: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 5),
                            top: helper.getHeight(context, 0)),
                        child: ToggleSwitch(
                          cornerRadius: 30.0,
                          activeBgColor: const [Color(0xff5D6B9F)],
                          inactiveBgColor: const Color(0xffD9E0FA),
                          customWidths: [
                            helper.getHeight(context, 194),
                            helper.getHeight(context, 194)
                          ],
                          minHeight: helper.getHeight(context, 53),
                          initialLabelIndex: doYouDriveToggleValue,
                          totalSwitches: 2,
                          customTextStyles: [
                            doYouDriveToggleValue == 0
                                ? montserrat600.copyWith(
                                    color: Colors.white, fontSize: 18)
                                : montserrat400.copyWith(
                                    color: const Color(0xff667BC3),
                                    fontSize: 18),
                            doYouDriveToggleValue == 1
                                ? montserrat600.copyWith(
                                    color: Colors.white, fontSize: 18)
                                : montserrat400.copyWith(
                                    color: const Color(0xff667BC3),
                                    fontSize: 18)
                          ],
                          labels: const ['No', 'Yes'],
                          radiusStyle: true,
                          onToggle: (index) {
                            doYouDriveToggleValue = index!;
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 5),
                            top: helper.getHeight(context, 20)),
                        child: Text(
                          'Do you have a Car ?',
                          style: montserrat400.copyWith(
                              fontSize: 18, color: defaultDarkBlue),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            right: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 5),
                            top: helper.getHeight(context, 0)),
                        child: ToggleSwitch(
                          cornerRadius: 30.0,
                          activeBgColor: const [Color(0xff5D6B9F)],
                          inactiveBgColor: const Color(0xffD9E0FA),
                          customWidths: [
                            helper.getHeight(context, 194),
                            helper.getHeight(context, 194)
                          ],
                          minHeight: helper.getHeight(context, 53),
                          initialLabelIndex: doYouHaveCarToggleValue,
                          totalSwitches: 2,
                          customTextStyles: [
                            doYouHaveCarToggleValue == 0
                                ? montserrat600.copyWith(
                                    color: Colors.white, fontSize: 18)
                                : montserrat400.copyWith(
                                    color: const Color(0xff667BC3),
                                    fontSize: 18),
                            doYouHaveCarToggleValue == 1
                                ? montserrat600.copyWith(
                                    color: Colors.white, fontSize: 18)
                                : montserrat400.copyWith(
                                    color: const Color(0xff667BC3),
                                    fontSize: 18)
                          ],
                          labels: const ['No', 'Yes'],
                          radiusStyle: true,
                          onToggle: (index) {
                            doYouHaveCarToggleValue = index!;
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 5),
                            top: helper.getHeight(context, 20)),
                        child: Text(
                          'Qualification',
                          style: montserrat400.copyWith(
                              fontSize: 18, color: defaultDarkBlue),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: helper.getHeight(context, 5),
                            bottom: helper.getHeight(context, 0)),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(18, 8, 12, 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: textFieldBorderColor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: const SizedBox(),
                            // hint: const Text('Visitor'),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              size: 45,
                            ),
                            value: qualificationValue == ''
                                ? null
                                : qualificationValue,
                            style: montserrat400.copyWith(
                                fontSize: 20, color: defaultDarkBlue),
                            items: <String>['Graduate', 'Under Graduate']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              qualificationValue = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 5),
                            top: helper.getHeight(context, 20)),
                        child: Text(
                          'Gender',
                          style: montserrat400.copyWith(
                              fontSize: 18, color: defaultDarkBlue),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 10),
                            right: helper.getWidth(context, 10),
                            bottom: helper.getHeight(context, 5),
                            top: helper.getHeight(context, 0)),
                        child: ToggleSwitch(
                          cornerRadius: 30.0,
                          activeBgColor: const [Color(0xff5D6B9F)],
                          inactiveBgColor: const Color(0xffD9E0FA),
                          // minWidth: 383,
                          customWidths: [
                            helper.getHeight(context, 110),
                            helper.getHeight(context, 110),
                            helper.getHeight(context, 177)
                          ],
                          minHeight: helper.getHeight(context, 53),
                          initialLabelIndex: genderToggleValue,
                          totalSwitches: 3,
                          customTextStyles: [
                            genderToggleValue == 0
                                ? montserrat600.copyWith(
                                    color: Colors.white, fontSize: 18)
                                : montserrat400.copyWith(
                                    color: const Color(0xff667BC3),
                                    fontSize: 18),
                            genderToggleValue == 1
                                ? montserrat600.copyWith(
                                    color: Colors.white, fontSize: 18)
                                : montserrat400.copyWith(
                                    color: const Color(0xff667BC3),
                                    fontSize: 18),
                            genderToggleValue == 2
                                ? montserrat600.copyWith(
                                    color: Colors.white, fontSize: 18)
                                : montserrat400.copyWith(
                                    color: const Color(0xff667BC3),
                                    fontSize: 18)
                          ],
                          labels: const ['Female', 'Male', 'Not Disclosing'],
                          radiusStyle: true,
                          onToggle: (index) {
                            genderToggleValue = index!;
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            bottom: helper.getHeight(context, 5),
                            top: helper.getHeight(context, 20)),
                        child: Text(
                          'Date of Birth',
                          style: montserrat400.copyWith(
                              fontSize: 18, color: defaultDarkBlue),
                        ),
                      ),
                      DefaultTextField(
                          devHeight: devHeight,
                          readOnly: true,
                          controller: dobController,
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime.now())
                                .then((value) {
                              dobController.text =
                                  DateFormat.yMMMd().format(value!);
                            });
                          },
                          hintText: '',
                          onChanged: (value) {}),
                      Padding(
                        padding: EdgeInsets.only(
                            left: helper.getWidth(context, 15),
                            top: helper.getHeight(context, 20)),
                        child: Text(
                          'Select Status',
                          style: montserrat400.copyWith(
                              fontSize: 20, color: const Color(0xff364373)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: helper.getHeight(context, 5),
                            bottom: helper.getHeight(context, 0)),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(18, 8, 12, 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: textFieldBorderColor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: const SizedBox(),
                            value: statusValue == '' ? 'Visitor' : statusValue,
                            // hint: const Text('Visitor'),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              size: 45,
                            ),
                            style: montserrat400.copyWith(
                                fontSize: 20, color: defaultDarkBlue),
                            items: <String>[
                              'Visitor',
                              'Student',
                              'Work Permit',
                              'PR'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              statusValue = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      candidateExperienceList.isEmpty ||
                              candidateExperienceList == [null]
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(0, 22, 0, 30),
                              child: ListView.builder(
                                  itemCount: candidateExperienceList.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        height: helper.getHeight(context, 310),
                                        width: helper.getWidth(context, 400),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: defaultDarkBlue),
                                            borderRadius:
                                                BorderRadius.circular(21)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15.0, 15.0, 15.0, 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      candidateExperienceList
                                                          .removeAt(index);
                                                      setState(() {});
                                                    },
                                                    child: const Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.red,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      final experienceData =
                                                          await Navigator.push(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              BlocProvider<
                                                                  GetProvinceListBloc>(
                                                            create: ((context) =>
                                                                GetProvinceListBloc()),
                                                            child: BlocProvider<
                                                                GetCityByProvinceListBloc>(
                                                              create: ((context) =>
                                                                  GetCityByProvinceListBloc()),
                                                              child:
                                                                  AddExperienceScreen(
                                                                editExpData:
                                                                    candidateExperienceList[
                                                                        index],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                      candidateExperienceList[
                                                              index] =
                                                          experienceData
                                                              as CandidateExperienceModel;
                                                      setState(() {});
                                                    },
                                                    child: Text(
                                                      'Edit',
                                                      style: montserrat400
                                                          .copyWith(),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 10, 10, 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Experience-${candidateExperienceList[index].startYear} - ${candidateExperienceList[index].endYear}',
                                                    style:
                                                        montserrat500.copyWith(
                                                            color:
                                                                defaultDarkBlue,
                                                            fontSize: 20),
                                                  ),
                                                  Divider(
                                                    color: defaultDarkBlue,
                                                    height: helper.getHeight(
                                                        context, 30),
                                                    thickness: 1,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Company',
                                                            style: montserrat400
                                                                .copyWith(),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                top: helper
                                                                    .getHeight(
                                                                        context,
                                                                        22),
                                                                bottom: helper
                                                                    .getHeight(
                                                                        context,
                                                                        22)),
                                                            child: Text(
                                                              'Designation',
                                                              style: montserrat400
                                                                  .copyWith(),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                bottom: helper
                                                                    .getHeight(
                                                                        context,
                                                                        22)),
                                                            child: Text(
                                                              'Province',
                                                              style: montserrat400
                                                                  .copyWith(),
                                                            ),
                                                          ),
                                                          Text(
                                                            'City',
                                                            style: montserrat400
                                                                .copyWith(),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: helper.getWidth(
                                                            context, 45),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            candidateExperienceList[
                                                                    index]
                                                                .companyName,
                                                            style: montserrat400
                                                                .copyWith(),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                top: helper
                                                                    .getHeight(
                                                                        context,
                                                                        22),
                                                                bottom: helper
                                                                    .getHeight(
                                                                        context,
                                                                        22)),
                                                            child: Text(
                                                              candidateExperienceList[
                                                                      index]
                                                                  .designation,
                                                              style: montserrat400
                                                                  .copyWith(),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                bottom: helper
                                                                    .getHeight(
                                                                        context,
                                                                        22)),
                                                            child: Text(
                                                              candidateExperienceList[
                                                                      index]
                                                                  .province,
                                                              style: montserrat400
                                                                  .copyWith(),
                                                            ),
                                                          ),
                                                          Text(
                                                            candidateExperienceList[
                                                                    index]
                                                                .city,
                                                            style: montserrat400
                                                                .copyWith(),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: helper.getHeight(context, 58),
                            bottom: helper.getHeight(context, 61)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              onTap: () async {
                                final experienceData = await Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        BlocProvider<GetProvinceListBloc>(
                                      create: ((context) =>
                                          GetProvinceListBloc()),
                                      child: BlocProvider<
                                          GetCityByProvinceListBloc>(
                                        create: ((context) =>
                                            GetCityByProvinceListBloc()),
                                        child: AddExperienceScreen(
                                            provinceForAddExp:
                                                provinceForAddExp == []
                                                    ? null
                                                    : provinceForAddExp),
                                      ),
                                    ),
                                  ),
                                );
                                if (experienceData
                                        as CandidateExperienceModel !=
                                    null) {
                                  candidateExperienceList.add(experienceData);
                                  setState(() {});
                                }
                              },
                              child: Container(
                                width: helper.getWidth(context, 257),
                                height: helper.getHeight(context, 54),
                                decoration: BoxDecoration(
                                    color: const Color(0xffAFBCEE),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: defaultDarkBlue)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Add Experience',
                                        style: montserrat600.copyWith(
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: helper.getWidth(context, 8),
                                      ),
                                      const Icon(Icons.add)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: helper.getHeight(context, 5),
                                top: helper.getHeight(context, 0)),
                            child: Container(
                              width: helper.getWidth(context, 294),
                              height: helper.getHeight(context, 63),
                              decoration: BoxDecoration(
                                  color: const Color(0xffAFBCEE),
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: defaultDarkBlue)),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Attach Resume',
                                      style:
                                          montserrat500.copyWith(fontSize: 20),
                                    ),
                                    Text(
                                      'with 2 References',
                                      style:
                                          montserrat400.copyWith(fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'pdf, doc files only',
                            style: montserrat400.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: helper.getHeight(context, 33),
                            top: helper.getHeight(context, 30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultBlueButton(
                                textOrLoader: BlocBuilder<RegisterCandidateBloc,
                                        RegisterCandidateState>(
                                    builder: (context, state) {
                                  if (state is RegisterCandidateLoadingState) {
                                    return const SpinKitFadingFour(
                                      color: defaultLightBlue,
                                    );
                                  } else {
                                    return Text(
                                      'Submit',
                                      style: montserrat600.copyWith(
                                          fontSize: 24,
                                          color: defaultLightBlue),
                                    );
                                  }
                                }),
                                buttonText: 'Submit',
                                borderRadius: 36,
                                height: helper.getHeight(context, 73),
                                onPress: () {
                                  submitOnTap();
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute<void>(
                                  //     builder: (BuildContext context) =>
                                  //         const RegistrationCompletedScreen(),
                                  //   ),
                                  // );
                                },
                                width: helper.getWidth(context, 269)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validator() {}

  void submitOnTap() {
    final CandidateRegistrationModel candidateData = CandidateRegistrationModel(
        email: widget.email,
        candidateName: nameController.text.trim(),
        contactNumber: mobileNocontroller.text.trim(),
        canadianResidence: residentInCanadaToggleValue == 0 ? false : true,
        province: provinceValue!.provinceName,
        city: cityByProvienceValue.cityName,
        canDrive: doYouDriveToggleValue == 0 ? false : true,
        haveCar: doYouHaveCarToggleValue == 0 ? false : true,
        dob: dobController.text.trim(),
        gender: genderToggleValue == 0
            ? 'Female'
            : genderToggleValue == 1
                ? 'Male'
                : 'Not Disclosing',
        immigStatus: statusValue,
        industryIds: selectedIndustryIndex,
        permittedToWork: workPermitInCanadaToggleValue == 0 ? false : true,
        qualification: qualificationValue,
        candidateExperiences: candidateExperienceList,
        preferredCityIds: selectedCities,
        yrOfExp: yearCount,
        resumeExtension: '.png',
        resumeName: '',
        resume: '');
    BlocProvider.of<RegisterCandidateBloc>(context)
        .add(RegisterCandidateEvent(candidateData: candidateData));
  }

  Widget selectIndustrySection() {
    return BlocBuilder<GetIndustryListBloc, GetIndustryListState>(
        builder: (context, state) {
      if (state is GetIndustryListLoadingState) {
        return const SpinKitFadingFour(
          color: defaultDarkBlue,
        );
      } else if (state is GetIndustryListSuccessState) {
        return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.industryList.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3.3,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: Colors.transparent,
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onTap: () {
                  if (selectedIndustryIndex
                      .contains(state.industryList[index].industryId)) {
                    selectedIndustryIndex
                        .remove(state.industryList[index].industryId);
                    if (selectedIndustryIndex.isEmpty) {
                      selectedIndustryIndex
                          .add(state.industryList[0].industryId);
                    }
                  } else {
                    selectedIndustryIndex
                        .add(state.industryList[index].industryId);
                  }
                  setState(() {});
                },
                child: Container(
                  height: 45,
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                      color: selectedIndustryIndex
                              .contains(state.industryList[index].industryId)
                          ? const Color(0xff5D6B9F)
                          : const Color(0xffC8D3FB),
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Text(
                      state.industryList[index].industryName,
                      style: selectedIndustryIndex
                              .contains(state.industryList[index].industryId)
                          ? montserrat500.copyWith(
                              fontSize: 17,
                              color: const Color(0xffFBFEFF),
                            )
                          : montserrat400.copyWith(
                              fontSize: 17,
                              color: defaultButtonBlue,
                            ),
                    ),
                  ),
                ),
              );
            });
      } else {
        return const Text('Can\'t featch industried');
      }
    });
  }
}
