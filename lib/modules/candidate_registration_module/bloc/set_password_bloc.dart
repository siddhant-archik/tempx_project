import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempx_project/modules/candidate_registration_module/models/send_activate_email_model.dart';
import 'package:tempx_project/modules/candidate_registration_module/models/set_password_model.dart';
import 'package:tempx_project/modules/candidate_registration_module/services/send_activate_email_repo.dart';
import 'package:tempx_project/modules/candidate_registration_module/services/set_password_repo.dart';

class SetCandidatePasswordEvent {
  final String email;
  final String password;
  SetCandidatePasswordEvent({required this.email, required this.password});
}

abstract class SetCandidatePasswordState {}

class SetCandidatePasswordInitialState extends SetCandidatePasswordState {}

class SetCandidatePasswordLoadingState extends SetCandidatePasswordState {}

class SetCandidatePasswordSuccessState extends SetCandidatePasswordState {}

class SetCandidatePasswordErrorState extends SetCandidatePasswordState {
  final String err;
  SetCandidatePasswordErrorState({required this.err});
}

class SetCandidatePasswordBloc
    extends Bloc<SetCandidatePasswordEvent, SetCandidatePasswordState> {
  SetCandidatePasswordBloc() : super((SetCandidatePasswordInitialState())) {
    on<SetCandidatePasswordEvent>(((event, emit) async {
      emit(SetCandidatePasswordLoadingState());
      try {
        final data =
            SetPasswordModel(email: event.email, password: event.password);
        SetPasswordRepo setPasswordRepo = SetPasswordRepo();
        String responceMessage =
            await setPasswordRepo.setCandidatePassword(data);
        if (responceMessage == "Add candidate password successfully") {
          emit(SetCandidatePasswordSuccessState());
          // 'Successfully Sent Email';
        } else if (responceMessage.contains("Duplicate")) {
          emit(SetCandidatePasswordErrorState(err: 'Email Already Registered'));
          //  'Email Already Registered';
        } else {
          log("CANDIDATE SEND EMAIL RESP: in else block");
          emit(SetCandidatePasswordErrorState(err: responceMessage.toString()));
          // 'Something went wrong!';
        }
      } catch (e) {
        emit(SetCandidatePasswordErrorState(err: e.toString()));
      }
    }));
  }
}
