import 'package:tempx_project/common_models/business_industry_list_model.dart';

class BusinessListModel {
    BusinessListModel({
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

    int? businessId;
    String? craNumber;
    String? legalBusinessName;
    String? opBusinessName;
    String? addrL1;
    String? addrL2;
    String? province;
    String? city;
    String? postcode;
    String? authPersonName;
    String? authPersonContact;
    List<int?>? industryIds;
    List<Industry?>? industries;
    int? storeCount;
    dynamic brandImage;
    dynamic fileExtension;
    dynamic fileName;

    factory BusinessListModel.fromJson(Map<String, dynamic> json) => BusinessListModel(
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
        industryIds: json["industryIds"] == null ? [] : json["industryIds"] == null ? [] : List<int?>.from(json["industryIds"]!.map((x) => x)),
        industries: json["industries"] == null ? [] : json["industries"] == null ? [] : List<Industry?>.from(json["industries"]!.map((x) => Industry.fromJson(x))),
        storeCount: json["storeCount"],
        brandImage: json["brandImage"],
        fileExtension: json["fileExtension"],
        fileName: json["fileName"],
    );

    Map<String, dynamic> toJson() => {
        "businessId": businessId,
        "craNumber": craNumber,
        "legalBusinessName": legalBusinessName,
        "opBusinessName": opBusinessName,
        "addrL1": addrL1,
        "addrL2": addrL2,
        "province": province,
        "city": city,
        "postcode": postcode,
        "authPersonName": authPersonName,
        "authPersonContact": authPersonContact,
        "industryIds": industryIds == null ? [] : industryIds == null ? [] : List<dynamic>.from(industryIds!.map((x) => x)),
        "industries": industries == null ? [] : industries == null ? [] : List<dynamic>.from(industries!.map((x) => x!.toJson())),
        "storeCount": storeCount,
        "brandImage": brandImage,
        "fileExtension": fileExtension,
        "fileName": fileName,
    };
}