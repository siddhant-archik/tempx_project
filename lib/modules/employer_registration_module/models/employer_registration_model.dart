import 'package:tempx_project/common_models/business_industry_list_model.dart';

class EmployerRegistrationModel {
  EmployerRegistrationModel({
    required this.email,
    required this.employerName,
    required this.contactNumber,
    required this.deviceId,
    required this.employerContactNumber,
    required this.business,
  });

  String email;
  String employerName;
  String contactNumber;
  String deviceId;
  String employerContactNumber;
  BusinessInEmpReg business;

  // factory EmployerRegistrationModel.fromJson(Map<String, dynamic> json) => EmployerRegistrationModel(
  //     email: json["email"] == null ? null : json["email"],
  //     employerName: json["employerName"] == null ? null : json["employerName"],
  //     contactNumber: json["contactNumber"] == null ? null : json["contactNumber"],
  //     deviceId: json["deviceId"] == null ? null : json["deviceId"],
  //     employerContactNumber: json["employerContactNumber"] == null ? null : json["employerContactNumber"],
  //     business: json["business"] == null ? null : BusinessInEmpReg.fromJson(json["business"]),
  // );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "employerName": employerName == null ? null : employerName,
        "contactNumber": contactNumber == null ? null : contactNumber,
        "deviceId": deviceId == null ? null : deviceId,
        "employerContactNumber":
            employerContactNumber == null ? null : employerContactNumber,
        "business": business == null ? null : business.toJson(),
      };
}

class EmployerRegistrationBySelectingBusinessModel {
  EmployerRegistrationBySelectingBusinessModel({
    required this.email,
    required this.employerName,
    required this.contactNumber,
    required this.deviceId,
    required this.employerContactNumber,
    required this.business,
  });

  String email;
  String employerName;
  String contactNumber;
  String deviceId;
  String employerContactNumber;
  Business business;

  // factory EmployerRegistrationModel.fromJson(Map<String, dynamic> json) => EmployerRegistrationModel(
  //     email: json["email"] == null ? null : json["email"],
  //     employerName: json["employerName"] == null ? null : json["employerName"],
  //     contactNumber: json["contactNumber"] == null ? null : json["contactNumber"],
  //     deviceId: json["deviceId"] == null ? null : json["deviceId"],
  //     employerContactNumber: json["employerContactNumber"] == null ? null : json["employerContactNumber"],
  //     business: json["business"] == null ? null : BusinessInEmpReg.fromJson(json["business"]),
  // );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "employerName": employerName == null ? null : employerName,
        "contactNumber": contactNumber == null ? null : contactNumber,
        "deviceId": deviceId == null ? null : deviceId,
        "employerContactNumber":
            employerContactNumber == null ? null : employerContactNumber,
        "business": business == null ? null : business.toJson(),
      };
}

class BusinessInEmpReg {
  BusinessInEmpReg({
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
    required this.storeCount,
    required this.fileExtension,
    required this.fileName,
    required this.industryIds,
    required this.brandImage,
  });

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
  int storeCount;
  String fileExtension;
  String fileName;
  List<int>? industryIds;
  String brandImage;

  // factory BusinessInEmpReg.fromJson(Map<String, dynamic> json) =>
  //     BusinessInEmpReg(
  //       craNumber: json["craNumber"] == null ? null : json["craNumber"],
  //       legalBusinessName: json["legalBusinessName"] == null
  //           ? null
  //           : json["legalBusinessName"],
  //       opBusinessName:
  //           json["opBusinessName"] == null ? null : json["opBusinessName"],
  //       addrL1: json["addrL1"] == null ? null : json["addrL1"],
  //       addrL2: json["addrL2"] == null ? null : json["addrL2"],
  //       province: json["province"] == null ? null : json["province"],
  //       city: json["city"] == null ? null : json["city"],
  //       postcode: json["postcode"] == null ? null : json["postcode"],
  //       authPersonName:
  //           json["authPersonName"] == null ? null : json["authPersonName"],
  //       authPersonContact: json["authPersonContact"] == null
  //           ? null
  //           : json["authPersonContact"],
  //       storeCount: json["storeCount"] == null ? null : json["storeCount"],
  //       fileExtension:
  //           json["fileExtension"] == null ? null : json["fileExtension"],
  //       fileName: json["fileName"] == null ? null : json["fileName"],
  //       industryIds: json["industryIds"] == null
  //           ? null
  //           : List<int>.from(json["industryIds"].map((x) => x)),
  //       brandImage: json["brandImage"] == null ? null : json["brandImage"],
  //     );

  Map<String, dynamic> toJson() => {
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
