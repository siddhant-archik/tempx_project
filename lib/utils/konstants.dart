import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color defaultDarkBlue = Color(0xff001357);
const Color lightDefaultDarkBlue = Color(0xff001354);
const Color defaultLightBlue = Color(0xffD3F4FD);
const Color defaultButtonBlue = Color(0xff364373);
const Color textFieldHintTextLightBlue = Color(0xff2A4298);
const Color secondaryButtonBlue = Color(0xffCDECF6);
const Color resendLightBlue = Color(0xffB5E4FF);
const Color textFieldBorderColor = Color(0xff586BAF);
const Color roleSelectionRectBorderColor = Color(0xff5C6997);
const Color lightBlueFillColor = Color(0xffF4FBFF);
const Color textFieldFillColor = Color(0xffFDFEFF);
const Color defaultRed = Color(0xffDA0707);
const Color secondaryBorderColor = Color(0xff6982DB);

const MaterialColor defaultDarkBlueSwatch = MaterialColor(
  0xff001357, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
  <int, Color>{
    50: Color(0xffce5641), //10%
    100: Color(0xffb74c3a), //20%
    200: Color(0xffa04332), //30%
    300: Color(0xff89392b), //40%
    400: Color(0xff733024), //50%
    500: Color(0xff5c261d), //60%
    600: Color(0xff451c16), //70%
    700: Color(0xff2e130e), //80%
    800: Color(0xff170907), //90%
    900: Color(0xff000000), //100%
  },
);

TextStyle montserrat600 = GoogleFonts.montserrat(
    color: lightDefaultDarkBlue, fontWeight: FontWeight.w600, fontSize: 36);

TextStyle montserrat500 = GoogleFonts.montserrat(
    color: lightDefaultDarkBlue, fontWeight: FontWeight.w500, fontSize: 24);

TextStyle montserrat300 = GoogleFonts.montserrat(
    color: textFieldHintTextLightBlue,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.italic,
    fontSize: 20);

TextStyle montserrat300Normal = GoogleFonts.montserrat(
    color: textFieldHintTextLightBlue,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.normal,
    fontSize: 20);

TextStyle montserrat400 = GoogleFonts.montserrat(
    color: defaultDarkBlue, fontWeight: FontWeight.w400, fontSize: 18);

InputDecoration defaultTextFieldDecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: textFieldBorderColor),
    borderRadius: BorderRadius.circular(30.0),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30.0),
  ),
  fillColor: lightBlueFillColor,
  filled: true,
  hintStyle: montserrat300,
);

List<String> industryList = [
  'Food',
  'Hospitality',
  'Gas Station',
  'Health care',
  'Trucking'
];

RegExp emailRegx = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

RegExp passwordRegx =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

const baseUrl = "http://18.221.83.40:9090";
const candidateSendActivateEmailUrl = "/registerCandidate/sendCanActivateEmail";
const candidateSetPasswordUrl = "/registerCandidate/setCandidatePassword";
const sendOtpToMobileUrl = "/otp/sendToMobile";
const validateOtpSentToMobile = "/otp/validateToMobile";
const getBusinessListUrl = "/master/fetchBusinesses";
const getIndustryListUrl = "/master/fetchIndustries";
const getProvinceListUrl = "/master/fetchProvinces";
const getCityByProvinceListUrl = "/master/fetchCitiesByProvince";
const registerEmployerUrl = "/registerEmployer";
const candidateRegistrationUrl = "/registerCandidate";
const getBusinessUrl = "/master/fetchBusinesses";
const getStoresByBusinessId = "/store/fetchBusinessStore";
const registerStoreManagerUrl = "/storeManager/register";
const loginUrl = "/login";
const sendOtpToWhatsapp = "/otp/sendToWhatsapp";

// headers: {
//                                       "Content-Type":
//                                           "application/x-www-form-urlencoded",
//                                     },