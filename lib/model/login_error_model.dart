// To parse this JSON data, do
//
//     final loginErrorModel = loginErrorModelFromJson(jsonString);

import 'dart:convert';

LoginErrorModel loginErrorModelFromJson(String str) => LoginErrorModel.fromJson(json.decode(str));

String loginErrorModelToJson(LoginErrorModel data) => json.encode(data.toJson());

class LoginErrorModel {
  LoginErrorModel({
    this.error,
    this.errorDescription,
  });

  String  ?error;
  String  ?errorDescription;

  factory LoginErrorModel.fromJson(Map<String, dynamic> json) => LoginErrorModel(
    error: json["error"] == null ? null : json["error"],
    errorDescription: json["error_description"] == null ? null : json["error_description"],
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? null : error,
    "error_description": errorDescription == null ? null : errorDescription,
  };
}
