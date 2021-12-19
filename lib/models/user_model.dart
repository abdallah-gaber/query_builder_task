import 'dart:convert';

class UserModel{
  int? userId;
  String? firstName;
  String? lastName;
  String? fullName;
  int? age;
  String? gender;

  UserModel({this.userId, this.firstName, this.lastName, this.fullName, this.age, this.gender});

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  factory UserModel.fromJson(Map<String, dynamic> json) {
    UserModel um = UserModel(
      userId: json["user_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      fullName: json["full_name"],
      age: json["age"],
      gender: json["gender"],
    );
    return um;
  }
}