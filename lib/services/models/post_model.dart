import 'dart:io';

///Result is in map
class PostModel {
  int? code;
  String? message;
  Result? result;

  PostModel({this.code, this.message, this.result});

  PostModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  int? id;
  String? name;
  String? mobile;
  String? designation;
  String? email;
  String? profile_image;

  Result(
      {this.id,
      this.name,
      this.mobile,
      this.designation,
      this.email,
      this.profile_image});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    designation = json['designation'];
    email = json['email'];
    profile_image = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['profile_image'] = this.profile_image;
    return data;
  }
}
