class SetPasswordModel {
  SetPasswordModel({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory SetPasswordModel.fromJson(Map<String, dynamic> json) =>
      SetPasswordModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
