class Verify_Model {
  String? message;
  int? isSelected;
  bool? success;
  List<Artistinfo>? artistinfo;
  int? status;

  Verify_Model(
      {this.message,
        this.isSelected,
        this.success,
        this.artistinfo,
        this.status});

  Verify_Model.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isSelected = json['is_selected'];
    success = json['success'];
    if (json['artistinfo'] != null) {
      artistinfo = <Artistinfo>[];
      json['artistinfo'].forEach((v) {
        artistinfo!.add(new Artistinfo.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['is_selected'] = this.isSelected;
    data['success'] = this.success;
    if (this.artistinfo != null) {
      data['artistinfo'] = this.artistinfo!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Artistinfo {
  int? id;
  int? userId;
  int? artistId;
  String? createdAt;

  Artistinfo({this.id, this.userId, this.artistId, this.createdAt});

  Artistinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    artistId = json['artist_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['artist_id'] = this.artistId;
    data['created_at'] = this.createdAt;
    return data;
  }
}
