class SendActivateEmailModel {
  SendActivateEmailModel({
    required this.email,
    required this.deviceId,
  });

  String email;
  String deviceId;

  factory SendActivateEmailModel.fromJson(Map<String, dynamic> json) =>
      SendActivateEmailModel(
        email: json["email"],
        deviceId: json["deviceId"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "deviceId": deviceId,
      };
}
