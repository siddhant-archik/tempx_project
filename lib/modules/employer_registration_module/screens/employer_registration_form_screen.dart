import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tempx_project/common_components/default_button.dart';
import 'package:tempx_project/common_components/default_textfield.dart';
import 'package:tempx_project/common_models/provinces_list_model.dart';
import 'package:tempx_project/modules/employer_registration_module/bloc/get_business_list_bloc.dart';
import 'package:tempx_project/common_blocs/get_city_by_province_bloc.dart';
import 'package:tempx_project/common_blocs/get_industry_bloc.dart';
import 'package:tempx_project/common_blocs/get_provinces_bloc.dart';
import 'package:tempx_project/modules/employer_registration_module/bloc/register_employer_bloc.dart';
import 'package:tempx_project/common_models/business_industry_list_model.dart';
import 'package:tempx_project/modules/employer_registration_module/models/employer_registration_model.dart';
import 'package:tempx_project/modules/employer_registration_module/screens/select_business_screen.dart';
import 'package:tempx_project/modules/employer_registration_module/screens/verify_email_screen.dart';
import 'package:tempx_project/utils/helpers.dart';
import 'package:tempx_project/utils/konstants.dart';

class EmployerRegistrationFormScreen extends StatefulWidget {
  final String contactNumber;
  const EmployerRegistrationFormScreen(
      {super.key, required this.contactNumber});

  @override
  State<EmployerRegistrationFormScreen> createState() =>
      _EmployerRegistrationFormScreenState();
}

class _EmployerRegistrationFormScreenState
    extends State<EmployerRegistrationFormScreen> {
  List<int> selectedIndustryIndex = [1];

  double submitButtonOpacity = 1;

  bool mandatoryTextVisiblity = false;
  bool alreadyRegisteredBusinessIdErrorVisiblity = false;
  bool noBusinessSelectedOrAddedError = false;
  bool emailFieldError = false;
  bool empNameFieldError = false;
  bool empContactFieldError = false;
  bool businessAddressError = false;

  Business? selectedBusiness;

  String addressErrorSpecificField = '';

  final FocusNode emailFieldFocusNode = FocusNode();
  final FocusNode nameFieldFocusNode = FocusNode();
  final FocusNode contactNoFieldFocusNode = FocusNode();
  final FocusNode noBusinessSelectedFocusNode = FocusNode();
  final FocusNode addressL1FocusNode = FocusNode();
  final FocusNode postalFieldFocusNode = FocusNode();

  Helpers helper = Helpers();
  TextEditingController selectABusinessController = TextEditingController();
  TextEditingController legalNameOfBusinessController = TextEditingController();
  TextEditingController businessIdController = TextEditingController();
  TextEditingController operatingNameOfBusinessController =
      TextEditingController();
  TextEditingController businessAddress1Controller = TextEditingController();
  TextEditingController businessAddress2Controller = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController empContactNoController = TextEditingController();
  TextEditingController craNumberController = TextEditingController();
  TextEditingController authorisedPersonNameController =
      TextEditingController();
  TextEditingController authorisedPersonContactController =
      TextEditingController();
  TextEditingController noOfStoresController = TextEditingController();
  String deviceId = '';
  var provinceValue;
  var cityByProvienceValue;
  final _scrollController = ScrollController();
  @override
  void initState() {
    getDeviceId();
    if (!mounted) return;
    BlocProvider.of<GetIndustryListBloc>(context).add(GetIndustryListEvent());
    BlocProvider.of<GetProvinceListBloc>(context).add(GetProvinceListEvent());

    super.initState();
  }

  void getDeviceId() async {
    deviceId = (await helper.getDeviceId())!;
    log(deviceId);
  }

  _animateToIndex(double index) {
    _scrollController.animateTo(index,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocListener<RegisterEmployerBloc, RegisterEmployerState>(
        listener: (context, state) {
          if (state is RegisterEmployerSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => VerifyEmailScreen(
                  businessName: selectedBusiness != null
                      ? selectedBusiness!.legalBusinessName
                      : legalNameOfBusinessController.text.trim(),
                  craNumber: selectedBusiness != null
                      ? selectedBusiness!.craNumber
                      : craNumberController.text.trim(),
                ),
              ),
            );
          } else if (state is RegisterEmployerErrorState) {
            final spllited = state.err.split("key");
            final output = spllited[1].replaceAll(RegExp('[^A-Za-z0-9]'), ' ');
            String customMessage = '';
            if (output.contains("employer profile email")) {
              // emailFieldFocusNode.requestFocus();
              customMessage = 'Already registered email address';
              emailFieldError = true;
              _animateToIndex(1100);
              setState(() {});
            }
            if (state.err ==
                'Duplicate entry \'${widget.contactNumber}\' for key \'employer_profile.registered_contact_number\'') {
              customMessage = 'Already registered mobile number';
              Navigator.pop(context, false);
            }
            Fluttertoast.showToast(
                msg: customMessage == ''
                    ? spllited[0].trimRight() + output
                    : customMessage,
                backgroundColor: Colors.red[400],
                fontSize: 22,
                timeInSecForIosWeb: 10);
          }
        },
        bloc: BlocProvider.of<RegisterEmployerBloc>(context),
        child: Scaffold(
          backgroundColor: lightBlueFillColor,
          appBar: AppBar(
            title: Text(
              'Employer Registration',
              style:
                  montserrat600.copyWith(fontSize: 20, color: defaultLightBlue),
            ),
            automaticallyImplyLeading: false,
          ),
          body: Scrollbar(
            thickness: 6,
            controller: _scrollController,
            radius: const Radius.circular(10),
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: devHeight * 0.013,
                      ),
                      child: Center(
                        child: Text(
                          'You have successfully',
                          style: montserrat400.copyWith(fontSize: 20),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Verified mobile Number',
                        style: montserrat400.copyWith(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: devHeight * 0.017, bottom: devHeight * 0.0135),
                      child: Center(
                        child: Text(
                          'Please Enter the Below details',
                          style: montserrat500.copyWith(
                              color: defaultDarkBlue, fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      height: helper.getHeight(context, 260),
                      decoration: BoxDecoration(
                          color: textFieldFillColor,
                          border: Border.all(color: defaultDarkBlue),
                          borderRadius: BorderRadius.circular(21)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Text(
                              'Select a Business *',
                              style: montserrat400.copyWith(
                                  fontSize: 18, color: defaultDarkBlue),
                            ),
                          ),
                          Material(
                            elevation: 15,
                            shadowColor:
                                const Color.fromRGBO(54, 67, 115, 0.15),
                            borderRadius: BorderRadius.circular(30),
                            child: TextField(
                              readOnly: true,
                              controller: selectABusinessController,
                              onTap: () async {
                                final selectedBusinessPopResp =
                                    await Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        BlocProvider(
                                      create: (context) =>
                                          GetBusinessListBloc(),
                                      child: SelectBusinessScreen(
                                        alreadySelectedBusiness:
                                            selectedBusiness,
                                      ),
                                    ),
                                  ),
                                );
                                selectedBusiness =
                                    selectedBusinessPopResp as Business;
                                if (selectedBusiness != null) {
                                  selectABusinessController.text =
                                      selectedBusiness!.legalBusinessName;
                                  operatingNameOfBusinessController.text =
                                      selectedBusiness!.opBusinessName;
                                  businessAddress1Controller.text =
                                      selectedBusiness!.addrL1;
                                  businessAddress2Controller.text =
                                      selectedBusiness!.addrL2;
                                  postalCodeController.text =
                                      selectedBusiness!.postcode;
                                  craNumberController.text =
                                      selectedBusiness!.craNumber;
                                  selectedIndustryIndex =
                                      selectedBusiness!.industryIds != null
                                          ? selectedBusiness!.industryIds!
                                          : selectedIndustryIndex;
                                  cityByProvienceValue = selectedBusiness!.city;
                                  provinceValue = selectedBusiness!.province;
                                } else {
                                  selectABusinessController.text = '';
                                  operatingNameOfBusinessController.text = '';
                                  businessAddress1Controller.text = '';
                                  businessAddress2Controller.text = '';
                                  postalCodeController.text = '';
                                  craNumberController.text = '';
                                  selectedIndustryIndex = [1];
                                  cityByProvienceValue = null;
                                  provinceValue = null;
                                }
                                noBusinessSelectedOrAddedError = false;
                                businessAddressError = false;
                                emailFieldError = false;
                                empNameFieldError = false;
                                empContactFieldError = false;
                                mandatoryTextVisiblity = false;
                                addressErrorSpecificField = '';
                                setState(() {});
                              },
                              onChanged: (value) {},
                              style: const TextStyle(fontSize: 20),
                              decoration: defaultTextFieldDecoration.copyWith(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: textFieldBorderColor),
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  contentPadding: devHeight <= 667
                                      ? const EdgeInsets.all(20)
                                      : null,
                                  counterText: "",
                                  hintText: 'Select Business',
                                  filled: true,
                                  fillColor: textFieldFillColor,
                                  hintStyle: GoogleFonts.montserrat(
                                      color: textFieldHintTextLightBlue,
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 20)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'OR',
                                style: montserrat600.copyWith(
                                    fontSize: 20, color: defaultDarkBlue),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Text(
                              'Legal Name of Business *',
                              style: montserrat400.copyWith(
                                  fontSize: 18,
                                  color: noBusinessSelectedOrAddedError == true
                                      ? const Color(0xffF0122D)
                                      : defaultDarkBlue),
                            ),
                          ),
                          DefaultTextField(
                              // errorBorder: noBusinessSelectedOrAddedError,
                              focusNode: noBusinessSelectedFocusNode,
                              controller: legalNameOfBusinessController,
                              devHeight: devHeight,
                              hintText: 'Enter Name of Business',
                              onChanged: (value) {
                                if (value.trim().isNotEmpty) {
                                  noBusinessSelectedOrAddedError = false;
                                  setState(() {});
                                }
                              }),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, bottom: 5, top: 25),
                      child: Text(
                        'Enter Business-ID (CRA)',
                        style: montserrat400.copyWith(
                            fontSize: 18, color: defaultDarkBlue),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Material(
                            elevation: 15,
                            shadowColor:
                                const Color.fromRGBO(54, 67, 115, 0.15),
                            borderRadius: BorderRadius.circular(30),
                            child: TextField(
                              readOnly: selectedBusiness != null ? true : false,
                              controller: craNumberController,
                              onChanged: (value) {},
                              style: const TextStyle(fontSize: 20),
                              decoration: defaultTextFieldDecoration.copyWith(
                                  contentPadding: const EdgeInsets.all(20),
                                  counterText: "",
                                  suffixIcon: const Icon(Icons.close),
                                  hintText: 'B900112233',
                                  filled: true,
                                  fillColor: textFieldFillColor,
                                  hintStyle: GoogleFonts.montserrat(
                                      color: textFieldHintTextLightBlue,
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 20)),
                            ),
                          ),
                        ),
                        DefaultBlueButton(
                            buttonText: 'Check',
                            height: helper.getHeight(context, 60),
                            onPress: () {},
                            width: helper.getWidth(context, 107))
                      ],
                    ),
                    Visibility(
                      visible: alreadyRegisteredBusinessIdErrorVisiblity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              'Business-ID is Already registed @ TempX',
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: montserrat400.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Text(
                            'Please check & enter correct ID',
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: montserrat400.copyWith(
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 22),
                            child: Text(
                              'or contact TempX admin',
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: montserrat400.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, bottom: 5, top: 25),
                      child: Text(
                        'Operating Name of Business',
                        style: montserrat400.copyWith(
                            fontSize: 18, color: defaultDarkBlue),
                      ),
                    ),
                    DefaultTextField(
                        readOnly: selectedBusiness != null ? true : false,
                        controller: operatingNameOfBusinessController,
                        devHeight: devHeight,
                        hintText: 'Enter Name of Business',
                        onChanged: (value) {}),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        height: 578,
                        decoration: BoxDecoration(
                            color: const Color(0xffFDFEFF),
                            border: Border.all(color: defaultDarkBlue),
                            borderRadius: BorderRadius.circular(21)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, bottom: 5),
                              child: Text(
                                'Select a Business Location *',
                                style: montserrat400.copyWith(
                                    fontSize: 18,
                                    color: businessAddressError == true
                                        ? Colors.red
                                        : defaultDarkBlue),
                              ),
                            ),
                            Material(
                              elevation: 15,
                              shadowColor:
                                  const Color.fromRGBO(54, 67, 115, 0.15),
                              borderRadius: BorderRadius.circular(30),
                              child: TextField(
                                readOnly:
                                    selectedBusiness != null ? true : false,
                                onChanged: (value) {},
                                style: const TextStyle(fontSize: 20),
                                decoration: defaultTextFieldDecoration.copyWith(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: textFieldBorderColor),
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    contentPadding: devHeight <= 667
                                        ? const EdgeInsets.all(20)
                                        : null,
                                    counterText: "",
                                    hintText: 'Select Location on Map',
                                    filled: true,
                                    fillColor: textFieldFillColor,
                                    hintStyle: GoogleFonts.montserrat(
                                        color: textFieldHintTextLightBlue,
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 20)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'OR',
                                  style: montserrat600.copyWith(
                                      fontSize: 20, color: defaultDarkBlue),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, bottom: 5),
                              child: Text(
                                'Enter Business Address *',
                                style: montserrat400.copyWith(
                                    fontSize: 18,
                                    color: businessAddressError == true
                                        ? Colors.red
                                        : defaultDarkBlue),
                              ),
                            ),
                            DefaultTextField(
                                readOnly:
                                    selectedBusiness != null ? true : false,
                                controller: businessAddress1Controller,
                                focusNode: addressL1FocusNode,
                                devHeight: devHeight,
                                hintTextColor:
                                    addressErrorSpecificField == 'addressL1'
                                        ? Colors.red
                                        : null,
                                hintText: 'Address-line-1',
                                onChanged: (value) {}),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: DefaultTextField(
                                  readOnly:
                                      selectedBusiness != null ? true : false,
                                  controller: businessAddress2Controller,
                                  devHeight: devHeight,
                                  hintText: 'Address-line-2',
                                  onChanged: (value) {}),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(18, 8, 12, 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: textFieldBorderColor),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: provinceValue.runtimeType == String
                                  ? IgnorePointer(
                                      ignoring: selectedBusiness != null
                                          ? true
                                          : false,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        underline: const SizedBox(),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          size: 45,
                                        ),
                                        value: provinceValue,
                                        style: montserrat400.copyWith(
                                            fontSize: 18,
                                            color: const Color(0xff5265A8)),
                                        items: <String>[provinceValue]
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              provinceValue,
                                              style: const TextStyle(
                                                  fontSize: 19.3,
                                                  color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (_) {
                                          return;
                                        },
                                      ),
                                    )
                                  : BlocBuilder<GetProvinceListBloc,
                                          GetProvinceListState>(
                                      builder: (context, state) {
                                      if (state
                                          is GetProvinceListSuccessState) {
                                        return IgnorePointer(
                                          ignoring: selectedBusiness != null
                                              ? true
                                              : false,
                                          child: DropdownButton(
                                            menuMaxHeight:
                                                helper.getHeight(context, 300),
                                            isExpanded: true,
                                            underline: const SizedBox(),
                                            hint: Text(
                                              'Province',
                                              style: TextStyle(
                                                color:
                                                    addressErrorSpecificField ==
                                                            'province'
                                                        ? Colors.red
                                                        : null,
                                              ),
                                            ),
                                            value: provinceValue ?? null,
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              size: 45,
                                            ),
                                            style: montserrat400.copyWith(
                                                fontSize: 18,
                                                color: const Color(0xff5265A8)),
                                            items: state.provinceList.map((e) {
                                              return DropdownMenuItem(
                                                  value: e,
                                                  child: Text(
                                                    e.provinceName,
                                                    style: const TextStyle(
                                                        fontSize: 19.3,
                                                        color: Colors.black),
                                                  ));
                                            }).toList(),
                                            onChanged: (value) {
                                              if (selectedBusiness != null) {
                                                return;
                                              }
                                              provinceValue = value;
                                              cityByProvienceValue = null;
                                              setState(() {});
                                              BlocProvider.of<
                                                          GetCityByProvinceListBloc>(
                                                      context)
                                                  .add(
                                                      GetCityByProvinceListEvent(
                                                          provinceId:
                                                              provinceValue
                                                                  .provinceId
                                                                  .toString()));
                                              // print(provinceValue.provinceName);
                                            },
                                          ),
                                        );
                                      } else {
                                        return DropdownButton(
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          hint: Text(
                                            'Province',
                                            style: TextStyle(
                                              color:
                                                  addressErrorSpecificField ==
                                                          'province'
                                                      ? Colors.red
                                                      : null,
                                            ),
                                          ),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            size: 45,
                                          ),
                                          style: montserrat400.copyWith(
                                              fontSize: 18,
                                              color: const Color(0xff5265A8)),
                                          items: <String>[].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (_) {},
                                        );
                                      }
                                    }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(18, 8, 12, 8),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: textFieldBorderColor),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: cityByProvienceValue.runtimeType ==
                                        String
                                    ? IgnorePointer(
                                        ignoring: selectedBusiness != null
                                            ? true
                                            : false,
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            size: 45,
                                          ),
                                          value: cityByProvienceValue,
                                          style: montserrat400.copyWith(
                                              fontSize: 18,
                                              color: const Color(0xff5265A8)),
                                          items: <String>[cityByProvienceValue]
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                cityByProvienceValue,
                                                style: const TextStyle(
                                                    fontSize: 19.3,
                                                    color: Colors.black),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (_) {
                                            return;
                                          },
                                        ),
                                      )
                                    : BlocBuilder<GetCityByProvinceListBloc,
                                            GetCityByProvinceListState>(
                                        builder: (context, state) {
                                        if (state
                                            is GetCityByProvinceListSuccessState) {
                                          return IgnorePointer(
                                            ignoring: selectedBusiness != null
                                                ? true
                                                : false,
                                            child: DropdownButton(
                                              menuMaxHeight: helper.getHeight(
                                                  context, 300),
                                              isExpanded: true,
                                              underline: const SizedBox(),
                                              hint: Text(
                                                'City',
                                                style: TextStyle(
                                                  color:
                                                      addressErrorSpecificField ==
                                                              'city'
                                                          ? Colors.red
                                                          : null,
                                                ),
                                              ),
                                              value:
                                                  cityByProvienceValue ?? null,
                                              icon: const Icon(
                                                Icons.arrow_drop_down,
                                                size: 45,
                                              ),
                                              style: montserrat400.copyWith(
                                                  fontSize: 18,
                                                  color:
                                                      const Color(0xff5265A8)),
                                              items: state.cityByProvinceList
                                                  .map((e) {
                                                return DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e.cityName,
                                                      style: const TextStyle(
                                                          fontSize: 19.3,
                                                          color: Colors.black),
                                                    ));
                                              }).toList(),
                                              onChanged: (value) {
                                                cityByProvienceValue = value;
                                                setState(() {});
                                              },
                                            ),
                                          );
                                        }
                                        return DropdownButton<String>(
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          hint: Text(
                                            'City',
                                            style: TextStyle(
                                              color:
                                                  addressErrorSpecificField ==
                                                          'city'
                                                      ? Colors.red
                                                      : null,
                                            ),
                                          ),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            size: 45,
                                          ),
                                          style: montserrat400.copyWith(
                                              fontSize: 18,
                                              color: const Color(0xff5265A8)),
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
                            ),
                            DefaultTextField(
                                readOnly:
                                    selectedBusiness != null ? true : false,
                                controller: postalCodeController,
                                keyboardType: TextInputType.number,
                                devHeight: devHeight,
                                focusNode: postalFieldFocusNode,
                                hintTextColor:
                                    addressErrorSpecificField == 'postal'
                                        ? Colors.red
                                        : null,
                                hintText: 'Postal Code',
                                onChanged: (value) {}),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, bottom: 5, top: 15),
                      child: Text(
                        'Enter Email *',
                        style: montserrat400.copyWith(
                            fontSize: 18,
                            color: emailFieldError == true
                                ? Colors.red
                                : defaultDarkBlue),
                      ),
                    ),
                    DefaultTextField(
                        focusNode: emailFieldFocusNode,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        devHeight: devHeight,
                        hintText: 'Enter Email',
                        onChanged: (value) {
                          emailFieldError = false;
                          setState(() {});
                        }),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, bottom: 5, top: 15),
                      child: Text(
                        'Employer Name *',
                        style: montserrat400.copyWith(
                            fontSize: 18,
                            color: empNameFieldError == true
                                ? Colors.red
                                : defaultDarkBlue),
                      ),
                    ),
                    DefaultTextField(
                        focusNode: nameFieldFocusNode,
                        controller: nameController,
                        devHeight: devHeight,
                        hintText: 'Employer Name',
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            empNameFieldError = false;
                            setState(() {});
                          }
                        }),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, bottom: 5, top: 15),
                      child: Text(
                        'Employer Contact No *',
                        style: montserrat400.copyWith(
                            fontSize: 18,
                            color: empContactFieldError == true
                                ? Colors.red
                                : defaultDarkBlue),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.topLeft,
                      clipBehavior: Clip.none,
                      children: [
                        Material(
                          elevation: 15,
                          shadowColor: const Color.fromRGBO(54, 67, 115, 0.15),
                          borderRadius: BorderRadius.circular(30),
                          child: TextField(
                            focusNode: contactNoFieldFocusNode,
                            controller: empContactNoController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            maxLength: 10,
                            onChanged: (value) {
                              // if (value.isNotEmpty || value.length > 9) {
                              empContactFieldError = false;
                              setState(() {});
                              // }
                            },
                            style: const TextStyle(fontSize: 20),
                            keyboardType: TextInputType.number,
                            decoration: defaultTextFieldDecoration.copyWith(
                              filled: true,
                              fillColor: textFieldFillColor,
                              contentPadding: devHeight <= 667
                                  ? const EdgeInsets.all(20)
                                  : null,
                              prefix: const Text('+1 -       '),
                              counterText: "",
                              hintText: 'Enter Contact No',
                            ),
                          ),
                        ),
                        Positioned(
                          top: devHeight * 0.004,
                          left: -devWidth * 0.008,
                          child: Image.asset(
                            'assets/images/mobile_no_prefix.png',
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, bottom: 5, top: 15),
                      child: Text(
                        'Authorised Person’s Name',
                        style: montserrat400.copyWith(
                            fontSize: 18, color: defaultDarkBlue),
                      ),
                    ),
                    DefaultTextField(
                        controller: authorisedPersonNameController,
                        devHeight: devHeight,
                        hintText: 'Enter Name',
                        onChanged: (value) {}),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, bottom: 5, top: 15),
                      child: Text(
                        'Authorised Person’s Contact',
                        style: montserrat400.copyWith(
                            fontSize: 18, color: defaultDarkBlue),
                      ),
                    ),
                    DefaultTextField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        controller: authorisedPersonContactController,
                        devHeight: devHeight,
                        hintText: 'Enter Contact No',
                        onChanged: (value) {}),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, bottom: 5, top: 15),
                      child: Text(
                        'No. of stores',
                        style: montserrat400.copyWith(
                            fontSize: 18, color: defaultDarkBlue),
                      ),
                    ),
                    DefaultTextField(
                        keyboardType: TextInputType.number,
                        controller: noOfStoresController,
                        devHeight: devHeight,
                        hintText: '',
                        onChanged: (value) {}),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, bottom: 5, top: 25),
                      child: Text(
                        'Select Industry',
                        style: montserrat400.copyWith(
                            fontSize: 20, color: defaultDarkBlue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff667BC3))),
                      ),
                    ),
                    selectIndustrySection(),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            onTap: () {},
                            child: Container(
                              height: 51,
                              width: 294,
                              decoration: BoxDecoration(
                                  color: const Color(0xffC8D3FB),
                                  border: Border.all(color: defaultButtonBlue),
                                  borderRadius: BorderRadius.circular(18)),
                              child: Center(
                                child: Text(
                                  'Upload brand Image',
                                  style: montserrat400.copyWith(
                                      fontSize: 20, color: defaultButtonBlue),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        'jpg, jpeg, png files only',
                        style: montserrat400.copyWith(
                            fontSize: 16, color: defaultButtonBlue),
                      ),
                    ),
                    Visibility(
                      visible: mandatoryTextVisiblity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Center(
                              child: Text(
                                'Please fill all the Mandatory Fields',
                                style: montserrat400.copyWith(
                                    fontSize: 16, color: defaultRed),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Center(
                              child: Text(
                                'Highlighted with *',
                                style: montserrat400.copyWith(
                                    fontSize: 16, color: defaultRed),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultBlueButton(
                              opacity: submitButtonOpacity,
                              textOrLoader: BlocBuilder<RegisterEmployerBloc,
                                      RegisterEmployerState>(
                                  builder: (context, state) {
                                if (state is RegisterEmployerLoadingState) {
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
                              buttonTextSize: 24,
                              buttonText: 'Submit',
                              height: helper.getHeight(context, 60),
                              onPress: () {
                                mandatoryTextVisiblity = false;
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute<void>(
                                //     builder: (BuildContext context) =>
                                //         VerifyEmailScreen(
                                //       businessName: selectedBusiness != null
                                //           ? selectedBusiness!.legalBusinessName
                                //           : legalNameOfBusinessController.text
                                //               .trim(),
                                //       craNumber: selectedBusiness != null
                                //           ? selectedBusiness!.craNumber
                                //           : craNumberController.text.trim(),
                                //     ),
                                //   ),
                                // );

                                setState(() {});
                                submitOpacityValidator();
                                // submitOnClick();
                              },
                              width: helper.getWidth(context, 239)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submitOpacityValidator() {
    if ((selectedBusiness != null ||
            legalNameOfBusinessController.text.trim().isNotEmpty) &&
        (businessAddress1Controller.text.trim().isNotEmpty &&
            provinceValue != null &&
            cityByProvienceValue != null &&
            postalCodeController.text.trim().isNotEmpty &&
            emailController.text.trim().isNotEmpty &&
            nameController.text.trim().isNotEmpty &&
            empContactNoController.text.length == 10)) {
      log("FORM VALIDATION SUCCESSFULL");
      noBusinessSelectedOrAddedError = false;
      businessAddressError = false;
      emailFieldError = false;
      empNameFieldError = false;
      empContactFieldError = false;
      addressErrorSpecificField = '';
      setState(() {});
      submitOnClick();
      return;
    } else {
      log("FORM VALIDATION FAILED");
      if (selectedBusiness == null) {
        print(1);
        noBusinessSelectedOrAddedError =
            legalNameOfBusinessController.text.isEmpty;
        businessAddressError = businessAddress1Controller.text.trim().isEmpty;
        if (businessAddressError == true) {
          addressErrorSpecificField = 'addressL1';
        }
        if (businessAddressError == false && provinceValue == null) {
          businessAddressError = true;
          addressErrorSpecificField = 'province';
        } else if (businessAddressError == false &&
            cityByProvienceValue == null) {
          businessAddressError = true;
          addressErrorSpecificField = 'city';
        } else if (businessAddressError == false &&
            postalCodeController.text.trim().isEmpty) {
          businessAddressError = postalCodeController.text.trim().isEmpty;
          addressErrorSpecificField = 'postal';
        }
        if (noBusinessSelectedOrAddedError == true ||
            businessAddressError == true) {
          mandatoryTextVisiblity = true;
        }
        if (noBusinessSelectedOrAddedError == true) {
          Timer(const Duration(milliseconds: 500), () {
            noBusinessSelectedFocusNode.requestFocus();
            _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn);
          });
        } else if (businessAddressError == true) {
          Timer(const Duration(milliseconds: 500), () {
            _animateToIndex(600);
            return;
          });
        }
      }
      if ((legalNameOfBusinessController.text.trim().isNotEmpty &&
              businessAddressError == false) ||
          selectedBusiness != null) {
        print(2);
        if (emailController.text.isEmpty) {
          emailFieldError = true;
          mandatoryTextVisiblity = true;
        }
        if (emailController.text.trim().isNotEmpty &&
            emailRegx.hasMatch(emailController.text.trim()) == false) {
          emailFieldError = true;
        }
        if (nameController.text.trim().isEmpty) {
          mandatoryTextVisiblity = true;
          empNameFieldError = true;
        }
        if (empContactNoController.text.trim().isEmpty) {
          mandatoryTextVisiblity = true;
          empContactFieldError = true;
        }
        if (empContactNoController.text.trim().isNotEmpty &&
            empContactNoController.text.length < 10) {
          empContactFieldError = true;
        }
        if (noBusinessSelectedOrAddedError == true ||
            businessAddressError == true) {
          mandatoryTextVisiblity = true;
        }
        if (emailFieldError == true) {
          Timer(const Duration(milliseconds: 500), () {
            emailFieldFocusNode.requestFocus();
            _animateToIndex(1100);
          });
        } else if (empNameFieldError == true) {
          Timer(const Duration(milliseconds: 500), () {
            nameFieldFocusNode.requestFocus();
            _animateToIndex(1150);
          });
        } else if (empContactFieldError == true) {
          Timer(const Duration(milliseconds: 500), () {
            contactNoFieldFocusNode.requestFocus();
            _animateToIndex(1250);
          });
        }
      }
    }
    setState(() {});
  }

  void submitOnClick() async {
    if (selectedBusiness != null) {
      EmployerRegistrationBySelectingBusinessModel finalData =
          EmployerRegistrationBySelectingBusinessModel(
              email: emailController.text.trim(),
              employerName: nameController.text.trim(),
              contactNumber: widget.contactNumber,
              deviceId: deviceId,
              employerContactNumber: empContactNoController.text.trim(),
              business: selectedBusiness!);
      BlocProvider.of<RegisterEmployerBloc>(context).add(
          RegisterEmployerEvent(employerDataBySelectingBusiness: finalData));
    } else {
      BusinessInEmpReg finalBusinessData = BusinessInEmpReg(
          craNumber: craNumberController.text.trim(),
          legalBusinessName: legalNameOfBusinessController.text.trim(),
          opBusinessName: operatingNameOfBusinessController.text.trim(),
          addrL1: businessAddress1Controller.text.trim(),
          addrL2: businessAddress2Controller.text.trim(),
          province: provinceValue.provinceName.toString(),
          city: cityByProvienceValue.cityName.toString(),
          postcode: postalCodeController.text.trim(),
          authPersonName: authorisedPersonNameController.text.trim(),
          authPersonContact: authorisedPersonContactController.text.trim(),
          storeCount: noOfStoresController.text.trim().isEmpty
              ? 0
              : int.parse(noOfStoresController.text.trim()),
          fileExtension: '',
          fileName: '',
          industryIds: selectedIndustryIndex,
          brandImage: '');
      EmployerRegistrationModel finalData = EmployerRegistrationModel(
          email: emailController.text.trim(),
          employerName: nameController.text.trim(),
          contactNumber: widget.contactNumber,
          deviceId: deviceId,
          employerContactNumber: empContactNoController.text.trim(),
          business: finalBusinessData);
      BlocProvider.of<RegisterEmployerBloc>(context)
          .add(RegisterEmployerEvent(employerData: finalData));
    }
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
                  if (selectedBusiness != null) {
                    return;
                  }
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
