// To parse this JSON data, do
//
//     final registerRequestModel = registerRequestModelFromJson(jsonString);

import 'dart:convert';

RegisterRequestModel registerRequestModelFromJson(String str) => RegisterRequestModel.fromJson(json.decode(str));

String registerRequestModelToJson(RegisterRequestModel data) => json.encode(data.toJson());

class RegisterRequestModel {
  String name;
  String email;
  String password;
  String role;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) => RegisterRequestModel(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "role": role,
  };
}
