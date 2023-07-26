class Signup_Model {
  bool? success;
  String? message;
  Userinfo? userinfo;
  int? status;

  Signup_Model({this.success, this.message, this.userinfo, this.status});

  Signup_Model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    userinfo = json['userinfo'] != null
        ? new Userinfo.fromJson(json['userinfo'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.userinfo != null) {
      data['userinfo'] = this.userinfo!.toJson();
    }
    data['status'] = this.status;
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
  String? phone;
  String? image;
  String? social;
  String? token;
  String? actToken;
  int? status;
  String? createdAt;

  Userinfo(
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

  Userinfo.fromJson(Map<String, dynamic> json) {
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
