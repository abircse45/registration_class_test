// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.clientId,
    this.userName,
    this.customerId,
    this.customerNo,
    this.shippingAddressId,
    this.customerStatus,
    this.photoPath,
    this.message,
    this.issued,
    this.expires,
  });

  String ? accessToken;
  String ? tokenType;
  int ?expiresIn;
  String ?clientId;
  String ? userName;
  String ?customerId;
  String ?customerNo;
  String ?shippingAddressId;
  String ?customerStatus;
  String? photoPath;
  String ?message;
  String ?issued;
  String ?expires;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    accessToken: json["access_token"] == null ? null : json["access_token"],
    tokenType: json["token_type"] == null ? null : json["token_type"],
    expiresIn: json["expires_in"] == null ? null : json["expires_in"],
    clientId: json["client_id"] == null ? null : json["client_id"],
    userName: json["user_name"] == null ? null : json["user_name"],
    customerId: json["CustomerId"] == null ? null : json["CustomerId"],
    customerNo: json["CustomerNo"] == null ? null : json["CustomerNo"],
    shippingAddressId: json["ShippingAddress_Id"] == null ? null : json["ShippingAddress_Id"],
    customerStatus: json["CustomerStatus"] == null ? null : json["CustomerStatus"],
    photoPath: json["PhotoPath"] == null ? null : json["PhotoPath"],
    message: json["Message"] == null ? null : json["Message"],
    issued: json[".issued"] == null ? null : json[".issued"],
    expires: json[".expires"] == null ? null : json[".expires"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken == null ? null : accessToken,
    "token_type": tokenType == null ? null : tokenType,
    "expires_in": expiresIn == null ? null : expiresIn,
    "client_id": clientId == null ? null : clientId,
    "user_name": userName == null ? null : userName,
    "CustomerId": customerId == null ? null : customerId,
    "CustomerNo": customerNo == null ? null : customerNo,
    "ShippingAddress_Id": shippingAddressId == null ? null : shippingAddressId,
    "CustomerStatus": customerStatus == null ? null : customerStatus,
    "PhotoPath": photoPath == null ? null : photoPath,
    "Message": message == null ? null : message,
    ".issued": issued == null ? null : issued,
    ".expires": expires == null ? null : expires,
  };
}
