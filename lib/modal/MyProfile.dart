class MyProfile_Model {
  String? message;
  int? status;
  bool? success;
  Data? data;

  MyProfile_Model({this.message, this.status, this.success, this.data});

  MyProfile_Model.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? email;
  String? password;
  String? firstname;
  String? lastname;
  String? countryCode;
  String? phone;
  String? image;
  String? social;
  String? token;
  String? actToken;
  int? status;
  String? createdAt;

  Data(
      {this.id,
        this.email,
        this.password,
        this.firstname,
        this.lastname,
        this.countryCode,
        this.phone,
        this.image,
        this.social,
        this.token,
        this.actToken,
        this.status,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    countryCode = json['country_code'];
    phone = json['phone'];
    image = json['image'];
    social = json['social'];
    token = json['token'];
    actToken = json['act_token'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['social'] = this.social;
    data['token'] = this.token;
    data['act_token'] = this.actToken;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}