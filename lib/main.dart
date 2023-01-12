import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tempx_project/common_blocs/login_bloc.dart';
import 'package:tempx_project/modules/candidate_registration_module/bloc/send_activate_email_bloc.dart';
import 'package:tempx_project/modules/candidate_registration_module/bloc/set_password_bloc.dart';
import 'package:tempx_project/common_blocs/get_city_by_province_bloc.dart';
import 'package:tempx_project/common_blocs/get_industry_bloc.dart';
import 'package:tempx_project/common_blocs/get_provinces_bloc.dart';
import 'package:tempx_project/common_blocs/send_otp_bloc.dart';
import 'package:tempx_project/common_blocs/validate_otp_bloc.dart';
import 'package:tempx_project/modules/candidate_registration_module/screens/email_activation_screen.dart';
import 'package:tempx_project/modules/landing_module/screens/login_register_screen.dart';
import 'package:tempx_project/utils/firebase_notification_servce.dart';
import 'package:tempx_project/utils/konstants.dart';
// import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;

// bool _initialURILinkHandled = false;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget firstScreen = const LoginOrRegisterScren();
  // Uri? _initialURI;
  // Uri? _currentURI;
  // Object? _err;

  // StreamSubscription? _streamSubscription;

  // FirebaseNotificationService _firebaseNotificationService =
  //     FirebaseNotificationService.instance;
  // @override
  // void initState() {
  //   _firebaseNotificationService.getToken().then((token) {
  //     _token = token;
  //     print("Firebase Notification Token: " + _token.toString());
  //     // SharedPrefs().savefcmtokenValue(_token);
  //   });
  //   super.initState();
  // }
  StreamSubscription? _sub;
  @override
  void initState() {
    // TODO: implement initState
    // _initURIHandler();
    // _incomingLinkHandler();
    // initUniLinks(context);
    // initUniLinks();
    super.initState();
  }

  //ADD THIS FUNCTION TO HANDLE DEEP LINKS
  // Future<Null> initUniLinks(BuildContext c) async {
  //   try {
  //     final initialLink = await getInitialLink();
  //     print('SIUUU');
  //     print(initialLink);
  //   } on PlatformException {
  //     print('platfrom exception unilink');
  //   }
  //   _sub = linkStream.listen((String? link) {
  //     print("READY TO NAVIGATE");
  //     firstScreen = const EmailActivationScreen(email: 'siddhant@gmail.com');
  //     setState(() {});
  //     // Navigator.push(
  //     //   c,
  //     //   MaterialPageRoute<void>(
  //     //     builder: (BuildContext context) =>
  //     //         const EmailActivationScreen(email: 'siddhant@gmail.com'),
  //     //   ),
  //     // );
  //     print("123123ijksdfhksdhf");
  //     // Parse the link and warn the user, if it is not correct
  //   }, onError: (err) {
  //     print(err.toString());
  //     // Handle exception by warning the user their action did not succeed
  //   });
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SendOtpToMobileBloc>(
            create: ((context) => SendOtpToMobileBloc())),
        BlocProvider<ValidateOtpToMobileBloc>(
            create: ((context) => ValidateOtpToMobileBloc())),
        BlocProvider<SendActivateEmailBloc>(
            create: ((context) => SendActivateEmailBloc())),
        BlocProvider<SetCandidatePasswordBloc>(
            create: ((context) => SetCandidatePasswordBloc())),
        BlocProvider<GetIndustryListBloc>(
          create: ((context) => GetIndustryListBloc()),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: defaultDarkBlueSwatch,
        ),
        home: firstScreen,
      ),
    );
  }

  // Future<void> initUniLinks() async {
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     final initialLink = await getInitialLink();
  //     // Parse the link and warn the user, if it is not correct,
  //     // but keep in mind it could be `null`.
  //   } on PlatformException {
  //     // Handle exception by warning the user their action did not succeed
  //     // return?
  //   }
  // }
}
