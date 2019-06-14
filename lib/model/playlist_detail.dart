import 'model.dart';

class PlaylistDetail {
  PlaylistDetail({
    this.musics, 
    this.name, 
    this.coverUrl, 
    this.id, 
    this.trackCount, 
    this.subscribed, 
    this.subscribedCount, 
    this.commentCount, 
    this.shareCount, 
    this.playCount, 
    this.description,
    this.creator
  });

  // 如果 playlist 未加载完毕则为 null
  final List<Music> musics;
  final String name;
  final String coverUrl;
  final int id;
  final int trackCount;
  final bool subscribed;
  final int subscribedCount;
  final int commentCount;
  final int shareCount;
  final int playCount;
  final String description;
  final Map<String, dynamic> creator;
  
  bool get loaded => trackCount == 0 || (musics != null && musics.length == trackCount);

  String get heroTag => 'playlist_hero_$id';
  
  static PlaylistDetail fromJson(Map playlist) {
    return PlaylistDetail(
      id: playlist['id'],
      creator: playlist["creator"],
      name: playlist["name"],
      coverUrl: playlist["coverImgUrl"],
      trackCount: playlist["trackCount"],
      description: playlist["description"],
      subscribed: playlist["subscribed"],
      subscribedCount: playlist["subscribedCount"],
      commentCount: playlist["commentCount"],
      shareCount: playlist["shareCount"],
      playCount: playlist["playCount"],
      musics: mapJsonListToMusicList(
        playlist['tracks'],
        artistKey: 'ar',
        albumKey: 'al',
      ),
    );
  }

  static PlaylistDetail fromMap(Map map) {
    if(map == null) {
      return null;
    }
    return PlaylistDetail(
      id: map['id'],
      creator: map[''],
      name: map[''],
      coverUrl: map[''],
      trackCount: map[''],
      description: map[''],
      subscribed: map[''],
      subscribedCount: map[''],
      commentCount: map[''],
      shareCount: map[''],
      playCount: map[''],
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