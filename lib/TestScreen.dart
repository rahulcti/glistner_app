// class Artist_Song_Model {
//   String? message;
//   int? status;
//   bool? success;
//   List<Data>? data;
//
//   Artist_Song_Model({this.message, this.status, this.success, this.data});
//
//   Artist_Song_Model.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     status = json['status'];
//     success = json['success'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     data['status'] = this.status;
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? track;
//   String? artist;
//   String? releaseYear;
//   String? label;
//   String? genre;
//   String? trackNo;
//   String? coverImage;
//   int? yourMoodId;
//   int? albumId;
//   String? zoneType;
//   String? createdAt;
//   String? artistName;
//   String? genreType;
//   String? albumType;
//   int? noStems;
//   int? noMixes;
//   int? stemMix;
//   String? layoutName;
//   String? drums;
//   String? bass;
//   String? guitar;
//   String? vocals;
//   String? master1;
//   String? master2;
//   bool? songplay ;
//   String? lyrics;
//
//   Data(
//       {this.id,
//         this.track,
//         this.artist,
//         this.releaseYear,
//         this.label,
//         this.genre,
//         this.trackNo,
//         this.coverImage,
//         this.yourMoodId,
//         this.albumId,
//         this.zoneType,
//         this.createdAt,
//         this.artistName,
//         this.genreType,
//         this.albumType,
//         this.noStems,
//         this.noMixes,
//         this.stemMix,
//         this.layoutName,
//         this.drums,
//         this.bass,
//         this.guitar,
//         this.vocals,
//         this.master1,
//         this.master2,
//         this.songplay,
//         this.lyrics,
//
//       });
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     track = json['track'];
//     artist = json['artist'];
//     releaseYear = json['release_year'];
//     label = json['label'];
//     genre = json['genre'];
//     trackNo = json['track_no'];
//     coverImage = json['cover_image'];
//     yourMoodId = json['your_mood_id'];
//     albumId = json['album_id'];
//     zoneType = json['zone_type'];
//     createdAt = json['created_at'];
//     artistName = json['artist_name'];
//     genreType = json['genre_type'];
//     albumType = json['album_type'];
//     noStems = json['no_stems'];
//     noMixes = json['no_mixes'];
//     stemMix = json['stem_mix'];
//     layoutName = json['layout_name'];
//     drums = json['drums'];
//     bass = json['bass'];
//     guitar = json['guitar'];
//     vocals = json['vocals'];
//     master1 = json['master1'];
//     master2 = json['master2'];
//     lyrics = json['lyrics'];
//     songplay = true;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['track'] = this.track;
//     data['artist'] = this.artist;
//     data['release_year'] = this.releaseYear;
//     data['label'] = this.label;
//     data['genre'] = this.genre;
//     data['track_no'] = this.trackNo;
//     data['cover_image'] = this.coverImage;
//     data['your_mood_id'] = this.yourMoodId;
//     data['album_id'] = this.albumId;
//     data['zone_type'] = this.zoneType;
//     data['created_at'] = this.createdAt;
//     data['artist_name'] = this.artistName;
//     data['genre_type'] = this.genreType;
//     data['album_type'] = this.albumType;
//     data['no_stems'] = this.noStems;
//     data['no_mixes'] = this.noMixes;
//     data['stem_mix'] = this.stemMix;
//     data['layout_name'] = this.layoutName;
//     data['drums'] = this.drums;
//     data['bass'] = this.bass;
//     data['guitar'] = this.guitar;
//     data['vocals'] = this.vocals;
//     data['master1'] = this.master1;
//     data['master2'] = this.master2;
//     data['lyrics'] = this.lyrics;
//     return data;
//   }
// }