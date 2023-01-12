import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempx_project/common_models/provinces_list_model.dart';
import 'package:tempx_project/common_services/get_province_list_repo.dart';

class GetProvinceListEvent {}

abstract class GetProvinceListState {}

class GetProvinceListInitialState extends GetProvinceListState {}

class GetProvinceListLoadingState extends GetProvinceListState {}

class GetProvinceListSuccessState extends GetProvinceListState {
  final List<Province> provinceList;
  GetProvinceListSuccessState({required this.provinceList});
}

class GetProvinceListErrorState extends GetProvinceListState {
  final String err;
  GetProvinceListErrorState({required this.err});
}

class GetProvinceListBloc
    extends Bloc<GetProvinceListEvent, GetProvinceListState> {
  GetProvinceListBloc() : super((GetProvinceListInitialState())) {
    on<GetProvinceListEvent>(((event, emit) async {
      emit(GetProvinceListLoadingState());
      try {
        GetProvinceList getProvinceList = GetProvinceList();
        var resp = await getProvinceList.getProvinceList();
        if (resp.runtimeType == List<Province>) {
          emit(GetProvinceListSuccessState(provinceList: resp));
        }
      } catch (e) {
        emit(GetProvinceListErrorState(err: e.toString()));
      }
    }));
  }
}
