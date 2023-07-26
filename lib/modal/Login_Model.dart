class LoginModel {
  bool? success;
  String? message;
  int? status;
  String? token;
  Userinfo? userinfo;

  LoginModel(
      {this.success, this.message, this.status, this.token, this.userinfo});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    status = json['status'];
    token = json['token'];
    userinfo = json['userinfo'] != null
        ? new Userinfo.fromJson(json['userinfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.userinfo != null) {
      data['userinfo'] = this.userinfo!.toJson();
    }
    return data;
  }
}

class Userinfo {
  int? id;
  String? email;
  String? password;
  String? firstname;
  String? lastname;
  String? countryCode;
  String? image;
  String? phone;
  String? social;
  String? token;
  String? actToken;
  int? status;
  int? login_status;
  String? createdAt;

  Userinfo(
      {this.id,
        this.email,
        this.password,
        this.firstname,
        this.lastname,
        this.countryCode,
        this.image,
        this.phone,
        this.social,
        this.token,
        this.actToken,
        this.status,
        this.login_status,
        this.createdAt});

  Userinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    countryCode = json['country_code'];
    image = json['image'];
    phone = json['phone'];
    social = json['social'];
    token = json['token'];
    actToken = json['act_token'];
    status = json['status'];
    login_status = json['login_status'];
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
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['social'] = this.social;
    data['token'] = this.token;
    data['act_token'] = this.actToken;
    data['status'] = this.status;
    data['login_status'] = this.login_status;
    data['created_at'] = this.createdAt;
    return data;
  }
}