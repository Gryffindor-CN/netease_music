class Music {
  Music(
      {this.name,
      this.id,
      this.title,
      this.url,
      this.album,
      this.artists,
      this.aritstName,
      this.commentCount,
      this.detail,
      this.aritstId,
      this.albumId,
      this.albumName,
      int mvId})
      : this.mvId = mvId ?? 0;

  final String name;
  final int id;
  final String title;
  final String url;
  final Album album;
  final String albumName;
  final int commentCount;
  final String aritstName;
  final int aritstId;
  final int albumId;
  final List<Artist> artists;
  final Map<String, dynamic> detail;
  // 歌曲 mv id,当其为0时，表示没有 mv
  final int mvId;

  String get subTitle {
    var ar = artists.map((a) => a.name).join('/');
    var al = album.name;
    return '$al - $ar';
  }

  @override
  String toString() {
    return 'Music{id: $id, title: $title, url: $url, album: $album, artists: $artists}';
  }

  static Music fromMap(Map map) {
    if (map == null) {
      return null;
    }
    return Music(
      id: map['id'],
      title: map['title'],
      url: map['url'],
      album: map['album'],
      mvId: map['mvId'] ?? 0,
      artists: (map['artist'] as List).cast<Map>().map(Artist.fromMap).toList(),
    );
  }
}

class Album {
  Album({this.id, this.name, this.coverImageUrl});

  final int id;
  final String name;
  final String coverImageUrl;
}

class Artist {
  Artist({this.id, this.name, this.imageUrl});

  final int id;
  final String name;
  final String imageUrl;

  static Artist fromMap(Map map) {
    return Artist(id: map['id'], name: map['name'], imageUrl: map['imageUrl']);
  }
}
