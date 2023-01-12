import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempx_project/modules/employer_registration_module/services/validate_otp_repo.dart';

class ValidateOtpToMobileEvent {
  final String mobileNum;
  final String otp;
  ValidateOtpToMobileEvent({required this.mobileNum, required this.otp});
}

abstract class ValidateOtpToMobileState {}

class ValidateOtpToMobileInitialState extends ValidateOtpToMobileState {}

class ValidateOtpToMobileLoadingState extends ValidateOtpToMobileState {}

class ValidateOtpToMobileSuccessState extends ValidateOtpToMobileState {}

class ValidateOtpToMobileErrorState extends ValidateOtpToMobileState {
  final String err;
  ValidateOtpToMobileErrorState({required this.err});
}

class ValidateOtpToMobileBloc
    extends Bloc<ValidateOtpToMobileEvent, ValidateOtpToMobileState> {
  ValidateOtpToMobileBloc() : super((ValidateOtpToMobileInitialState())) {
    on<ValidateOtpToMobileEvent>(((event, emit) async {
      emit(ValidateOtpToMobileLoadingState());
      try {
        ValidateOtpToMobileRepo validateOtpToMobilelRepo =
            ValidateOtpToMobileRepo();

        String respMessage = await validateOtpToMobilelRepo.validateOtpToMobile(
            event.mobileNum, event.otp);
        if (respMessage.contains("Wrong")) {
          emit(ValidateOtpToMobileErrorState(
              err: "You have entered the Wrong Otp"));
        } else {
          emit(ValidateOtpToMobileSuccessState());
        }
      } catch (e) {
        emit(ValidateOtpToMobileErrorState(err: e.toString()));
      }
    }));
  }
}
