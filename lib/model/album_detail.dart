import 'music.dart';

class AlbumDetail {
  AlbumDetail(
      {this.musics,
      this.name,
      this.coverUrl,
      this.id,
      this.subscribed,
      this.subscribedCount,
      this.commentCount,
      this.trackCount,
      this.shareCount,
      this.description,
      this.artist,
      this.publishTime,
      this.subType,
      this.company});

  // 如果 playlist 未加载完毕则为 null
  final List<Music> musics;
  final String name;
  final String coverUrl;
  final int id;
  final bool subscribed;
  final int subscribedCount;
  final int commentCount;
  final int trackCount;
  final int shareCount;
  final String description;
  final Artist artist;
  final int publishTime;
  final String subType;
  final String company;

  String get heroTag => 'album_hero_$id';

  static AlbumDetail fromJson(Map album) {
    return AlbumDetail(
      id: album['id'],
      subscribed: album["subscribed"],
      subscribedCount: album["subscribedCount"],
      artist: album["artist"],
      name: album["name"],
      coverUrl: album["coverImgUrl"],
      description: album["description"],
      commentCount: album["commentCount"],
      shareCount: album["shareCount"],
      trackCount: album["trackCount"],
      publishTime: album["publishTime"],
      subType: album["subType"],
      company: album["company"],
      musics: mapJsonListToMusicList(
        album['tracks'],
        artistKey: 'ar',
        albumKey: 'al',
      ),
    );
  }

  static AlbumDetail fromMap(Map map) {
    if (map == null) {
      return null;
    }
    return AlbumDetail(
      id: map['id'],
      artist: map[''],
      name: map[''],
      coverUrl: map[''],
      description: map[''],
      commentCount: map[''],
      trackCount: map[''],
      shareCount: map[''],
      publishTime: map[''],
      subType: map[''],
      company: map[''],
      subscribed: map[''],
      subscribedCount: map[''],
      musics: (map['musicList'] as List)
          ?.cast<Map>()
          ?.map((m) => Music.fromMap(m))
          ?.toList(),
    );
  }
}

List<Music> mapJsonListToMusicList(List tracks,
    {String artistKey = "artists", String albumKey = "album"}) {
  if (tracks == null) {
    return null;
  }
  var list = tracks
      .cast<Map>()
      .map((e) => mapJsonToMusic(e, artistKey: "ar", albumKey: "al"));
  return list.toList();
}

Music mapJsonToMusic(Map song,
    {String artistKey = "artists", String albumKey = "album"}) {
  Map album = song[albumKey] as Map;

  List<Artist> artists = (song[artistKey] as List).cast<Map>().map((e) {
    return Artist(
      name: e["name"],
      id: e["id"],
    );
  }).toList();

  return Music(
      id: song["id"],
      title: song["name"],
      mvId: song['mv'] ?? 0,
      url: "http://music.163.com/song/media/outer/url?id=${song["id"]}.mp3",
      album: Album(
          id: album["id"], name: album["name"], coverImageUrl: album["picUrl"]),
      artists: artists);
}
