class Fevourite_Artist {
  String? message;
  int? status;
  bool? success;
  List<Favartist>? favartist;

  Fevourite_Artist({this.message, this.status, this.success, this.favartist});

  Fevourite_Artist.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    success = json['success'];
    if (json['favartist'] != null) {
      favartist = <Favartist>[];
      json['favartist'].forEach((v) {
        favartist!.add(new Favartist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.favartist != null) {
      data['favartist'] = this.favartist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Favartist {
  int? id;
  int? userId;
  int? artistId;
  String? createdAt;

  Favartist({this.id, this.userId, this.artistId, this.createdAt});

  Favartist.fromJson(Map<String, dynamic> json) {
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