import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempx_project/common_models/login_model.dart';
import 'package:tempx_project/common_services/login_repo.dart';

class LoginEvent {
  final LoginModel loginData;
  LoginEvent({required this.loginData});
}

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String err;
  LoginErrorState({required this.err});
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super((LoginInitialState())) {
    on<LoginEvent>(((event, emit) async {
      emit(LoginLoadingState());
      try {
        LoginRepo loginRepo = LoginRepo();
        String responceMessage = await loginRepo.loginUser(event.loginData);
        emit(LoginSuccessState());
        // if (responceMessage == "Add candidate password successfully") {
        //   emit(LoginSuccessState());
        //   // 'Successfully Sent Email';
        // } else if (responceMessage.contains("Duplicate")) {
        //   emit(LoginErrorState(err: 'Email Already Registered'));
        //   //  'Email Already Registered';
        // } else {
        //   log("CANDIDATE SEND EMAIL RESP: in else block");
        //   emit(LoginErrorState(err: responceMessage.toString()));
        //   // 'Something went wrong!';
        // }
      } catch (e) {
        emit(LoginErrorState(err: e.toString()));
      }
    }));
  }
}
