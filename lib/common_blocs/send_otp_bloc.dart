import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempx_project/modules/employer_registration_module/services/send_otp_repo.dart';

class SendOtpToMobileEvent {
  final String mobileNum;
  SendOtpToMobileEvent({required this.mobileNum});
}

abstract class SendOtpToMobileState {}

class SendOtpToMobileInitialState extends SendOtpToMobileState {}

class SendOtpToMobileLoadingState extends SendOtpToMobileState {}

class SendOtpToMobileSuccessState extends SendOtpToMobileState {}

class SendOtpToMobileErrorState extends SendOtpToMobileState {
  final String err;
  SendOtpToMobileErrorState({required this.err});
}

class SendOtpToMobileBloc
    extends Bloc<SendOtpToMobileEvent, SendOtpToMobileState> {
  SendOtpToMobileBloc() : super((SendOtpToMobileInitialState())) {
    on<SendOtpToMobileEvent>(((event, emit) async {
      emit(SendOtpToMobileLoadingState());
      try {
        SendOtpToMobileRepo sendOtpToMobilelRepo = SendOtpToMobileRepo();

        String resp =
            await sendOtpToMobilelRepo.sendOtpToMobile(event.mobileNum);
        if (resp == "Otp sent successfully") {
          emit(SendOtpToMobileSuccessState());
        }
      } catch (e) {
        emit(SendOtpToMobileErrorState(err: e.toString()));
      }
    }));
  }
}
