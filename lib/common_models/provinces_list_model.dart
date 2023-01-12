class Province {
  Province({
    required this.provinceId,
    required this.provinceName,
  });

  int provinceId;
  String provinceName;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        provinceId: json["provinceId"],
        provinceName: json["provinceName"],
      );
}
