class Home_Model {
  String? message;
  int? status;
  bool? success;
  List<Genre>? genre;
  List<Albums>? albums;
  List<Yourmood>? yourmood;
  List<Artist>? artist;

  Home_Model(
      {this.message,
        this.status,
        this.success,
        this.genre,
        this.albums,
        this.yourmood,
        this.artist});

  Home_Model.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    success = json['success'];
    if (json['genre'] != null) {
      genre = <Genre>[];
      json['genre'].forEach((v) {
        genre!.add(new Genre.fromJson(v));
      });
    }
    if (json['albums'] != null) {
      albums = <Albums>[];
      json['albums'].forEach((v) {
        albums!.add(new Albums.fromJson(v));
      });
    }
    if (json['yourmood'] != null) {
      yourmood = <Yourmood>[];
      json['yourmood'].forEach((v) {
        yourmood!.add(new Yourmood.fromJson(v));
      });
    }
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
    if (this.genre != null) {
      data['genre'] = this.genre!.map((v) => v.toJson()).toList();
    }
    if (this.albums != null) {
      data['albums'] = this.albums!.map((v) => v.toJson()).toList();
    }
    if (this.yourmood != null) {
      data['yourmood'] = this.yourmood!.map((v) => v.toJson()).toList();
    }
    if (this.artist != null) {
      data['artist'] = this.artist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Genre {
  int? id;
  String? genreType;
  String? image;
  String? createdAt;

  Genre({this.id, this.genreType, this.image, this.createdAt});

  Genre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    genreType = json['genre_type'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['genre_type'] = this.genreType;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Albums {
  int? id;
  String? albumType;
  String? image;
  String? createdAt;

  Albums({this.id, this.albumType, this.image, this.createdAt});

  Albums.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    albumType = json['album_type'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['album_type'] = this.albumType;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Yourmood {
  int? id;
  String? moodType;
  String? image;
  String? createdAt;

  Yourmood({this.id, this.moodType, this.image, this.createdAt});

  Yourmood.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moodType = json['mood_type'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mood_type'] = this.moodType;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
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