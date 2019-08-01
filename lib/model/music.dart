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
  String lyrics;
  List<Artist> artists;
  Album album;
  String title;
  int mvId;
  String url;

  String get subTitle {
    var ar = artists.map((a) => a.name).join('/');
    var al = album.name;
    return '$al - $ar';
  }

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
      this.albumCoverImg,
      this.lyrics,
      this.artists,
      this.album,
      this.title,
      this.mvId,
      this.url});

  @override
  String toString() {
    return 'Music{id: $id, name: $name, aritstName: $aritstName, aritstId: $aritstId, albumName: $albumName, albumId: $albumId, detail: $detail, commentCount: $commentCount, songUrl: $songUrl, albumCoverImg: $albumCoverImg}';
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
      albumCoverImg: map["albumCoverImg"],
      lyrics: map["lyrics"],
      artists: map["artists"],
      album: map["album"],
      title: map["title"],
      mvId: map["mvId"],
      url: map["url"],
    );
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
      "albumCoverImg": albumCoverImg,
      "lyrics": lyrics,
      "artists": artists,
      "album": album,
      "title": title,
      "mvId": mvId,
      "url": url,
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
  String nickName;
  PlayList(
      {this.name,
      this.id,
      this.coverImgUrl,
      this.playCount,
      this.trackCount,
      this.creatorName,
      this.nickName});
}

class Album {
  Album({this.id, this.name, this.coverImageUrl, this.publishTime, this.size});

  final int id;
  final String name;
  final String coverImageUrl;
  final int publishTime;
  final int size;
}

class Artist {
  Artist({
    this.id,
    this.albumSize,
    this.mvSize,
    this.name,
    this.imageUrl,
    this.alias,
    this.briefDesc,
    this.followed,
  });

  final int id;
  final int albumSize;
  final int mvSize;
  final String name;
  final String imageUrl;
  final List<dynamic> alias;
  final String briefDesc;
  final bool followed;

  static Artist fromMap(Map map) {
    return Artist(
        id: map['id'],
        albumSize: map['albumSize'],
        mvSize: map['mvSize'],
        name: map['name'],
        imageUrl: map['imageUrl'],
        alias: map["alias"],
        briefDesc: map["briefDesc"],
        followed: map["followed"]);
  }
}
