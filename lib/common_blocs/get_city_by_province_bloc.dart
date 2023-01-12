import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempx_project/common_models/city_by_province_list_model.dart';
import 'package:tempx_project/common_services/get_city_by_province_repo.dart';

class GetCityByProvinceListEvent {
  final String provinceId;
  GetCityByProvinceListEvent({required this.provinceId});
}

abstract class GetCityByProvinceListState {}

class GetCityByProvinceListInitialState extends GetCityByProvinceListState {}

class GetCityByProvinceListLoadingState extends GetCityByProvinceListState {}

class GetCityByProvinceListSuccessState extends GetCityByProvinceListState {
  final List<CityByProvince> cityByProvinceList;
  GetCityByProvinceListSuccessState({required this.cityByProvinceList});
}

class GetCityByProvinceListErrorState extends GetCityByProvinceListState {
  final String err;
  GetCityByProvinceListErrorState({required this.err});
}

class GetCityByProvinceListBloc
    extends Bloc<GetCityByProvinceListEvent, GetCityByProvinceListState> {
  GetCityByProvinceListBloc() : super((GetCityByProvinceListInitialState())) {
    on<GetCityByProvinceListEvent>(((event, emit) async {
      emit(GetCityByProvinceListLoadingState());
      try {
        GetCityByProvinceList getCityByProvinceList = GetCityByProvinceList();
        var resp =
            await getCityByProvinceList.getCityByProvinceList(event.provinceId);
        if (resp.runtimeType == List<CityByProvince>) {
          emit(GetCityByProvinceListSuccessState(cityByProvinceList: resp));
        }
      } catch (e) {
        emit(GetCityByProvinceListErrorState(err: e.toString()));
      }
    }));
  }
}
