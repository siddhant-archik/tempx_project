class LoginModel {
  LoginModel(
      {required this.username, required this.password, required this.userType});

  String username;
  String password;
  String userType;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      username: json["email"],
      password: json["password"],
      userType: json["userType"]);

  Map<String, dynamic> toJson() =>
      {"email": username, "password": password, "userType": userType};
}
