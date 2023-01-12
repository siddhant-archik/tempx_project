import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempx_project/common_models/business_list_model.dart';
import 'package:tempx_project/common_services/get_business_list_repo.dart';

class GetBusinessListEvent {}

abstract class GetBusinessListState {}

class GetBusinessListInitialState extends GetBusinessListState {}

class GetBusinessListLoadingState extends GetBusinessListState {}

class GetBusinessListSuccessState extends GetBusinessListState {
  final List<BusinessListModel> businessList;
  GetBusinessListSuccessState({required this.businessList});
}

class GetBusinessListErrorState extends GetBusinessListState {
  final String err;
  GetBusinessListErrorState({required this.err});
}

class GetBusinessListBloc
    extends Bloc<GetBusinessListEvent, GetBusinessListState> {
  GetBusinessListBloc() : super((GetBusinessListInitialState())) {
    on<GetBusinessListEvent>(((event, emit) async {
      emit(GetBusinessListLoadingState());
      try {
        GetBusinessListRepo getProvinceList = GetBusinessListRepo();
        var resp = await getProvinceList.getBusinessList();
        if (resp.runtimeType == List<BusinessListModel>) {
          emit(GetBusinessListSuccessState(businessList: resp));
        }
      } catch (e) {
        emit(GetBusinessListErrorState(err: e.toString()));
      }
    }));
  }
}
