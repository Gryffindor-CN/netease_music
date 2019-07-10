class Music {
  String name;
  int id;
  String aritstName;
  int aritstId;
  String albumName;
  int albumId;
  Map<String, dynamic> detail;
  int commentCount;
  String songUrl;
  String albumCoverImg;
  Music(
      {this.name,
      this.id,
      this.aritstName,
      this.aritstId,
      this.albumName,
      this.albumId,
      this.detail,
      this.commentCount,
      this.songUrl,
      this.albumCoverImg});

  @override
  String toString() {
    return 'Music{id: $id, name: $name, aritstName: $aritstName, aritstId: $aritstId, albumName: $albumName}';
  }

  static Music fromMap(Map map) {
    if (map == null) {
      return null;
    }
    return Music(
        name: map["name"],
        id: map["id"],
        aritstName: map["aritstName"],
        aritstId: map["aritstId"],
        albumName: map["albumName"],
        albumId: map['albumId'] ?? 0,
        detail: map["detail"],
        commentCount: map["commentCount"],
        songUrl: map["songUrl"],
        albumCoverImg: map["albumCoverImg"]);
  }

  Map toMap() {
    return {
      "name": name,
      "id": id,
      "aritstName": aritstName,
      "albumName": albumName,
      "aritstId": aritstId,
      "albumId": albumId,
      'commentCount': commentCount,
      "album": detail,
      "songUrl": songUrl,
      "albumCoverImg": albumCoverImg
    };
  }
}

class PlayList {
  String name;
  int id;
  String coverImgUrl;
  int playCount;
  int trackCount;
  String creatorName;
  PlayList(
      {this.name,
      this.id,
      this.coverImgUrl,
      this.playCount,
      this.trackCount,
      this.creatorName});
}
