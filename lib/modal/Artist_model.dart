class Artist_model {
  String? message;
  int? status;
  bool? success;
  List<Artist>? artist;

  Artist_model({this.message, this.status, this.success, this.artist});

  Artist_model.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    success = json['success'];
    if (json['artist'] != null) {
      artist = <Artist>[];
      json['artist'].forEach((v) {
        artist!.add(new Artist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.artist != null) {
      data['artist'] = this.artist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Artist {
  int? id;
  String? artistName;
  String? image;
  String? createdAt;

  Artist({this.id, this.artistName, this.image, this.createdAt});

  Artist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    artistName = json['artist_name'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['artist_name'] = this.artistName;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}