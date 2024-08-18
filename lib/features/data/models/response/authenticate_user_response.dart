// To parse this JSON data, do
//
//     final authenticateUserResponse = authenticateUserResponseFromJson(jsonString);

import 'dart:convert';

AuthenticateUserResponse authenticateUserResponseFromJson(String str) => AuthenticateUserResponse.fromJson(json.decode(str));

String authenticateUserResponseToJson(AuthenticateUserResponse data) => json.encode(data.toJson());

class AuthenticateUserResponse {
  int id;
  String name;
  String role;
  String email;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  AuthenticateUserResponse({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AuthenticateUserResponse.fromJson(Map<String, dynamic> json) => AuthenticateUserResponse(
    id: json["id"],
    name: json["name"],
    role: json["role"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "role": role,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
