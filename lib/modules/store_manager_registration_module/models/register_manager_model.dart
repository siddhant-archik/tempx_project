class RegisterStoreManagerModel {
  RegisterStoreManagerModel({
    required this.email,
    required this.managerName,
    required this.contactNumber,
    required this.storeId,
    required this.deviceId,
  });

  String? email;
  String? managerName;
  String? contactNumber;
  List<int?>? storeId;
  String? deviceId;

  factory RegisterStoreManagerModel.fromJson(Map<String, dynamic> json) =>
      RegisterStoreManagerModel(
        email: json["email"],
        managerName: json["managerName"],
        contactNumber: json["contactNumber"],
        storeId: json["storeId"] == null
            ? []
            : json["storeId"] == null
                ? []
                : List<int?>.from(json["storeId"]!.map((x) => x)),
        deviceId: json["deviceId"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "managerName": managerName,
        "contactNumber": contactNumber,
        "storeId": storeId == null
            ? []
            : storeId == null
                ? []
                : List<dynamic>.from(storeId!.map((x) => x)),
        "deviceId": deviceId,
      };
}
