import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempx_project/modules/store_manager_registration_module/models/register_manager_model.dart';
import 'package:tempx_project/modules/store_manager_registration_module/services/register_manager_repo.dart';

class RegisterStoreManagerEvent {
  final RegisterStoreManagerModel storeManagerData;

  RegisterStoreManagerEvent({required this.storeManagerData});
}

abstract class RegisterStoreManagerState {}

class RegisterStoreManagerInitialState extends RegisterStoreManagerState {}

class RegisterStoreManagerLoadingState extends RegisterStoreManagerState {}

class RegisterStoreManagerSuccessState extends RegisterStoreManagerState {}

class RegisterStoreManagerErrorState extends RegisterStoreManagerState {
  final String err;
  RegisterStoreManagerErrorState({required this.err});
}

class RegisterStoreManagerBloc
    extends Bloc<RegisterStoreManagerEvent, RegisterStoreManagerState> {
  RegisterStoreManagerBloc() : super((RegisterStoreManagerInitialState())) {
    on<RegisterStoreManagerEvent>(((event, emit) async {
      emit(RegisterStoreManagerLoadingState());
      try {
        RegisterStoreManagerRepo storeManagerRegistationRepo =
            RegisterStoreManagerRepo();
        String respMessage = '';

        respMessage = await storeManagerRegistationRepo
            .registerStoreManager(event.storeManagerData);

        if (respMessage == "StoreManager registered successfully") {
          emit(RegisterStoreManagerSuccessState());
        } else {
          emit(RegisterStoreManagerErrorState(err: respMessage));
        }
        log("REGISTER STOREMANAGER MESSAGE: $respMessage");
      } catch (e) {
        emit(RegisterStoreManagerErrorState(err: e.toString()));
      }
    }));
  }
}
