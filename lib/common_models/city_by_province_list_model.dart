// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:tempx_project/common_models/provinces_list_model.dart';

class CityByProvince {
  CityByProvince({
    required this.cityId,
    required this.cityName,
    required this.province,
  });

  int cityId;
  String cityName;
  Province? province;

  factory CityByProvince.fromJson(Map<String, dynamic> json) => CityByProvince(
        cityId: json["cityId"] ?? null,
        cityName: json["cityName"] ?? null,
        province: json["province"] == null
            ? null
            : Province.fromJson(json["province"]),
      );
}
