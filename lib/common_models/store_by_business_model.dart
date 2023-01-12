class StoreByBusiness {
    StoreByBusiness({
        required this.storeId,
        required this.addrL1,
        required this.addrL2,
        required this.province,
        required this.city,
        required this.postcode,
        required this.businessId,
    });

    int? storeId;
    String? addrL1;
    String? addrL2;
    String? province;
    String? city;
    String? postcode;
    int? businessId;

    factory StoreByBusiness.fromJson(Map<String, dynamic> json) => StoreByBusiness(
        storeId: json["storeId"],
        addrL1: json["addrL1"],
        addrL2: json["addrL2"],
        province: json["province"],
        city: json["city"],
        postcode: json["postcode"],
        businessId: json["businessId"],
    );

    Map<String, dynamic> toJson() => {
        "storeId": storeId,
        "addrL1": addrL1,
        "addrL2": addrL2,
        "province": province,
        "city": city,
        "postcode": postcode,
        "businessId": businessId,
    };
}