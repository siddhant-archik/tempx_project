import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempx_project/modules/candidate_registration_module/models/candidate_registration_model.dart';
import 'package:tempx_project/modules/candidate_registration_module/services/candidate_registration_repo.dart';

class RegisterCandidateEvent {
  final CandidateRegistrationModel candidateData;

  RegisterCandidateEvent({required this.candidateData});
}

abstract class RegisterCandidateState {}

class RegisterCandidateInitialState extends RegisterCandidateState {}

class RegisterCandidateLoadingState extends RegisterCandidateState {}

class RegisterCandidateSuccessState extends RegisterCandidateState {}

class RegisterCandidateErrorState extends RegisterCandidateState {
  final String err;
  RegisterCandidateErrorState({required this.err});
}

class RegisterCandidateBloc
    extends Bloc<RegisterCandidateEvent, RegisterCandidateState> {
  RegisterCandidateBloc() : super((RegisterCandidateInitialState())) {
    on<RegisterCandidateEvent>(((event, emit) async {
      emit(RegisterCandidateLoadingState());
      try {
        CandidateRegitrationRepo candidateRegistationRepo =
            CandidateRegitrationRepo();
        String respMessage = '';

        respMessage = await candidateRegistationRepo
            .registerCandidate(event.candidateData);

        if (respMessage == "Candidate registered successfully") {
          emit(RegisterCandidateSuccessState());
        } else {
          emit(RegisterCandidateErrorState(err: respMessage));
        }
        log("REGISTER EMPLOYER MESSAGE: $respMessage");
      } catch (e) {
        emit(RegisterCandidateErrorState(err: e.toString()));
      }
    }));
  }
}
