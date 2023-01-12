import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempx_project/common_models/store_by_business_model.dart';
import 'package:tempx_project/common_services/get_store_by_business_repo.dart';

class GetStoreByBusinessListEvent {
  final String businessId;
  GetStoreByBusinessListEvent({required this.businessId});
}

abstract class GetStoreByBusinessListState {}

class GetStoreByBusinessListInitialState extends GetStoreByBusinessListState {}

class GetStoreByBusinessListLoadingState extends GetStoreByBusinessListState {}

class GetStoreByBusinessListSuccessState extends GetStoreByBusinessListState {
  final List<StoreByBusiness> storeByBusinessList;
  GetStoreByBusinessListSuccessState({required this.storeByBusinessList});
}

class GetStoreByBusinessListErrorState extends GetStoreByBusinessListState {
  final String err;
  GetStoreByBusinessListErrorState({required this.err});
}

class GetStoreByBusinessListBloc
    extends Bloc<GetStoreByBusinessListEvent, GetStoreByBusinessListState> {
  GetStoreByBusinessListBloc() : super((GetStoreByBusinessListInitialState())) {
    on<GetStoreByBusinessListEvent>(((event, emit) async {
      emit(GetStoreByBusinessListLoadingState());
      try {
        GetStoreByBusinessRepo getStoreByBusinessList =
            GetStoreByBusinessRepo();
        var resp = await getStoreByBusinessList
            .getStoreByProvinceList(event.businessId);
        if (resp.runtimeType == List<StoreByBusiness>) {
          emit(GetStoreByBusinessListSuccessState(storeByBusinessList: resp));
        }
      } catch (e) {
        emit(GetStoreByBusinessListErrorState(err: e.toString()));
      }
    }));
  }
}
