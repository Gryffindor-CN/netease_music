class Music {
  Music({this.id, this.title, this.url, this.album, this.artists, int mvId})
      : this.mvId = mvId ?? 0;

  final int id;
  final String title;
  final String url;
  final Album album;
  final List<Artist> artists;
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
  Album({
    this.id, 
    this.name, 
    this.coverImageUrl
  });

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
    return Artist(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl']
    );
  }
}