import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempx_project/modules/employer_registration_module/models/employer_registration_model.dart';
import 'package:tempx_project/modules/employer_registration_module/services/employer_registration_repo.dart';

class RegisterEmployerEvent {
  final EmployerRegistrationModel? employerData;
  final EmployerRegistrationBySelectingBusinessModel?
      employerDataBySelectingBusiness;
  RegisterEmployerEvent(
      {this.employerData, this.employerDataBySelectingBusiness});
}

abstract class RegisterEmployerState {}

class RegisterEmployerInitialState extends RegisterEmployerState {}

class RegisterEmployerLoadingState extends RegisterEmployerState {}

class RegisterEmployerSuccessState extends RegisterEmployerState {}

class RegisterEmployerErrorState extends RegisterEmployerState {
  final String err;
  RegisterEmployerErrorState({required this.err});
}

class RegisterEmployerBloc
    extends Bloc<RegisterEmployerEvent, RegisterEmployerState> {
  RegisterEmployerBloc() : super((RegisterEmployerInitialState())) {
    on<RegisterEmployerEvent>(((event, emit) async {
      emit(RegisterEmployerLoadingState());
      try {
        EmployerRegistationRepo employerRegistationRepo =
            EmployerRegistationRepo();
        String respMessage = '';
        if (event.employerData != null) {
          respMessage = await employerRegistationRepo
              .registerEmployer(event.employerData!);
        } else {
          respMessage =
              await employerRegistationRepo.registerEmployerBySelectingBusiness(
                  event.employerDataBySelectingBusiness!);
        }
        if (respMessage == "Employer registered successfully") {
          emit(RegisterEmployerSuccessState());
        } else {
          emit(RegisterEmployerErrorState(err: respMessage));
        }
        log("REGISTER EMPLOYER MESSAGE: $respMessage");
      } catch (e) {
        emit(RegisterEmployerErrorState(err: e.toString()));
      }
    }));
  }
}
