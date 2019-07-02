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
  Music(
      {this.name,
      this.id,
      this.aritstName,
      this.aritstId,
      this.albumName,
      this.albumId,
      this.detail,
      this.commentCount,
      this.songUrl});
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
