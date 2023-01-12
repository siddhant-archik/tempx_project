import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempx_project/common_models/business_industry_list_model.dart';
import 'package:tempx_project/common_services/get_industry_list_repo.dart';

class GetIndustryListEvent {}

abstract class GetIndustryListState {}

class GetIndustryListInitialState extends GetIndustryListState {}

class GetIndustryListLoadingState extends GetIndustryListState {}

class GetIndustryListSuccessState extends GetIndustryListState {
  final List<Industry> industryList;
  GetIndustryListSuccessState({required this.industryList});
}

class GetIndustryListErrorState extends GetIndustryListState {
  final String err;
  GetIndustryListErrorState({required this.err});
}

class GetIndustryListBloc
    extends Bloc<GetIndustryListEvent, GetIndustryListState> {
  GetIndustryListBloc() : super((GetIndustryListInitialState())) {
    on<GetIndustryListEvent>(((event, emit) async {
      emit(GetIndustryListLoadingState());
      try {
        GetIndustryList getIndustryList = GetIndustryList();
        var resp = await getIndustryList.getIndustryList();
        if (resp.runtimeType == List<Industry>) {
          emit(GetIndustryListSuccessState(industryList: resp));
        }
      } catch (e) {
        emit(GetIndustryListErrorState(err: e.toString()));
      }
    }));
  }
}
