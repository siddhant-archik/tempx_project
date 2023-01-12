import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempx_project/common_models/business_industry_list_model.dart';
import 'package:tempx_project/modules/employer_registration_module/services/get_bussiness_list_repo.dart';

class GetBusinessListEvent {}

abstract class GetBusinessListState {}

class GetBusinessListInitialState extends GetBusinessListState {}

class GetBusinessListLoadingState extends GetBusinessListState {}

class GetBusinessListSuccessState extends GetBusinessListState {
  final List<Business> businessList;
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
        GetBusinessList getBusinessList = GetBusinessList();
        var resp = await getBusinessList.getBusinessList();
        if (resp.runtimeType == List<Business>) {
          emit(GetBusinessListSuccessState(businessList: resp));
        }
      } catch (e) {
        emit(GetBusinessListErrorState(err: e.toString()));
      }
    }));
  }
}
