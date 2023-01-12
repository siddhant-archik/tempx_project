class Business {
  Business({
    required this.businessId,
    required this.craNumber,
    required this.legalBusinessName,
    required this.opBusinessName,
    required this.addrL1,
    required this.addrL2,
    required this.province,
    required this.city,
    required this.postcode,
    required this.authPersonName,
    required this.authPersonContact,
    required this.industryIds,
    required this.industries,
    required this.storeCount,
    required this.brandImage,
    required this.fileExtension,
    required this.fileName,
  });

  int businessId;
  String craNumber;
  String legalBusinessName;
  String opBusinessName;
  String addrL1;
  String addrL2;
  String province;
  String city;
  String postcode;
  String authPersonName;
  String authPersonContact;
  List<int>? industryIds;
  List<Industry>? industries;
  int storeCount;
  dynamic brandImage;
  dynamic fileExtension;
  dynamic fileName;

  factory Business.fromJson(Map<String, dynamic> json) => Business(
        businessId: json["businessId"],
        craNumber: json["craNumber"],
        legalBusinessName: json["legalBusinessName"],
        opBusinessName: json["opBusinessName"],
        addrL1: json["addrL1"],
        addrL2: json["addrL2"],
        province: json["province"],
        city: json["city"],
        postcode: json["postcode"],
        authPersonName: json["authPersonName"],
        authPersonContact: json["authPersonContact"],
        industryIds: json["industryIds"] == null
            ? null
            : List<int>.from(json["industryIds"].map((x) => x)),
        industries: json["industries"] == null
            ? null
            : List<Industry>.from(
                json["industries"].map((x) => Industry.fromJson(x))),
        storeCount: json["storeCount"],
        brandImage: json["brandImage"],
        fileExtension: json["fileExtension"],
        fileName: json["fileName"],
      );

  Map<String, dynamic> toJson() => {
        "businessId": businessId == null ? null : businessId,
        "craNumber": craNumber == null ? null : craNumber,
        "legalBusinessName":
            legalBusinessName == null ? null : legalBusinessName,
        "opBusinessName": opBusinessName == null ? null : opBusinessName,
        "addrL1": addrL1 == null ? null : addrL1,
        "addrL2": addrL2 == null ? null : addrL2,
        "province": province == null ? null : province,
        "city": city == null ? null : city,
        "postcode": postcode == null ? null : postcode,
        "authPersonName": authPersonName == null ? null : authPersonName,
        "authPersonContact":
            authPersonContact == null ? null : authPersonContact,
        "storeCount": storeCount == null ? null : storeCount,
        "fileExtension": fileExtension == null ? null : fileExtension,
        "fileName": fileName == null ? null : fileName,
        "industryIds": industryIds == null
            ? null
            : List<dynamic>.from(industryIds!.map((x) => x)),
        "brandImage": brandImage == null ? null : brandImage,
      };
}

class Industry {
  Industry({
    required this.industryId,
    required this.industryName,
  });

  int industryId;
  String industryName;

  factory Industry.fromJson(Map<String, dynamic> json) => Industry(
        industryId: json["industryId"],
        industryName: json["industryName"],
      );

  Map<String, dynamic> toJson() => {
        "industryId": industryId,
        "industryName": industryName,
      };
}

// enum Province { ON, ONTARIO }

// final provinceValues =
//     EnumValues({"ON": Province.ON, "ontario": Province.ONTARIO});

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
