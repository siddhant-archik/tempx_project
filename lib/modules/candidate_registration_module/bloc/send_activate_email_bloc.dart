import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempx_project/modules/candidate_registration_module/models/send_activate_email_model.dart';
import 'package:tempx_project/modules/candidate_registration_module/services/send_activate_email_repo.dart';

class SendActivateEmailEvent {
  final String email;
  final String deviceId;
  SendActivateEmailEvent({required this.email, required this.deviceId});
}

abstract class SendActivateEmailState {}

class SendActivateEmailInitialState extends SendActivateEmailState {}

class SendActivateEmailLoadingState extends SendActivateEmailState {}

class SendActivateEmailSuccessState extends SendActivateEmailState {}

class SendActivateEmailErrorState extends SendActivateEmailState {
  final String err;
  SendActivateEmailErrorState({required this.err});
}

class SendActivateEmailBloc
    extends Bloc<SendActivateEmailEvent, SendActivateEmailState> {
  SendActivateEmailBloc() : super((SendActivateEmailInitialState())) {
    on<SendActivateEmailEvent>(((event, emit) async {
      emit(SendActivateEmailLoadingState());
      try {
        final data = SendActivateEmailModel(
            email: event.email, deviceId: event.deviceId);
        SendActivateEmailRepo sendActivateEmailRepo = SendActivateEmailRepo();
        String responceMessage =
            await sendActivateEmailRepo.sendActivateEmail(data);
        if (responceMessage == "Activation email send successfully") {
          emit(SendActivateEmailSuccessState());
          // 'Successfully Sent Email';
        } else if (responceMessage.contains("Duplicate")) {
          emit(SendActivateEmailErrorState(err: 'Email Already Registered'));
          //  'Email Already Registered';
        } else {
          log("CANDIDATE SEND EMAIL RESP: in else block");
          emit(SendActivateEmailErrorState(err: responceMessage.toString()));
          // 'Something went wrong!';
        }
      } catch (e) {
        emit(SendActivateEmailErrorState(err: e.toString()));
      }
    }));
  }
}
