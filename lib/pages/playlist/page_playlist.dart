import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netease_music/material/flexible_detail_bar.dart';

import '../../model/model.dart';
import '../../model/playlist_detail.dart';
import '../../pages/playlist/music_list.dart';

/// 歌单详情信息 header 高度
const double HEIGHT_HEADER = 280 + 56.0;

var _creator = {
  "defaultAvatar": false,
  "province": 110000,
  "authStatus": 1,
  "followed": false,
  "avatarUrl": "http://p1.music.126.net/QWMV-Ru_6149AKe0mCBXKg==/1420569024374784.jpg",
  "accountStatus": 0,
  "gender": 1,
  "city": 110101,
  "birthday": -2209017600000,
  "userId": 1,
  "userType": 2,
  "nickname": '网易云音乐',
  "signature": "网易云音乐是6亿人都在使用的音乐平台，致力于帮助用户发现音乐惊喜，帮助音乐人实现梦想。\n客服在线时间：9：00 - 24：00，如您在使用过程中遇到任何问题，欢迎私信咨询@云音乐客服 ，我们会尽快回复。\n如果仍然不能解决您的问题，请邮件我们：\n用户：ncm5990@163.com\n音乐人：yyr599@163.com",
  "description": "网易云音乐官方账号",
  "detailDescription": "网易云音乐官方账号",
  "avatarImgId": 1420569024374784,
  "backgroundImgId": 2002210674180202,
  "backgroundUrl": "http://p1.music.126.net/pmHS4fcQtcNEGewNb5HRhg==/2002210674180202.jpg",
  "authority": 3,
  "mutual": false,
  "expertTags": null,
  "experts": null,
  "djStatus": 10,
  "vipType": 11,
  "remarkName": null,
  "avatarImgIdStr": 1420569024374784,
  "backgroundImgIdStr": 2002210674180202,
};

var _musics = [
  Music(id: 1369998604, title: '我们很好', url: 'http://music.163.com/song/media/outer/url?id=1369998604.mp3', album: Album(id: 79630781, name: '我们很好', coverImageUrl: 'http://p1.music.126.net/WD5q9kNrUnO9DyDMouYT_Q==/109951164142211910.jpg'), artists: [Artist(id: 3684,name: '林俊杰', imageUrl: null)], mvId: 10871909),
  Music(id: 1365393542, title: '孤身', url: 'http://music.163.com/song/media/outer/url?id=1365393542.mp3', album: Album(id: 79130968, name: '孤身', coverImageUrl: 'http://p2.music.126.net/yVmtE5RFcJ1fhv-ivuyuRw==/109951164075300143.jpg'), artists: [Artist(id: 1197168,name: '徐秉龙', imageUrl: null)], mvId: 0),
  Music(id: 1371428499, title: 'Rumble', url: 'http://music.163.com/song/media/outer/url?id=1371428499.mp3', album: Album(id: 79759200, name: 'Diaspora', coverImageUrl: 'http://p1.music.126.net/t5AN7zm6wzgTM9ubw2VEeQ==/109951164142609091.jpg'), artists: [Artist(id: 916113,name: 'GoldLink', imageUrl: null), Artist(id: 1083118,name: '王嘉尔', imageUrl: null), Artist(id: 32528718,name: 'Lil Nei', imageUrl: null)], mvId: 0),
  Music(id: 1371362795, title: '离开地球', url: 'http://music.163.com/song/media/outer/url?id=1371362795.mp3', album: Album(id: 79754932, name: '天文学家', coverImageUrl: 'http://p1.music.126.net/cc_7LdhHvgCfiNOFK5QCiw==/109951164141976716.jpg'), artists: [Artist(id: 12264643,name: '泥鳅', imageUrl: null)], mvId: 0),
  Music(id: 1370008924, title: '我和我的吉他生锈了', url: 'http://music.163.com/song/media/outer/url?id=1370008924.mp3', album: Album(id: 79631230, name: '我和我的吉他生锈了', coverImageUrl: 'http://p2.music.126.net/Y6aLO2nYpAHatE2bNVY8PQ==/109951164127400370.jpg'), artists: [Artist(id: 8281,name: '金南玲', imageUrl: null)], mvId: 0),
  Music(id: 1366903169, title: 'Falling', url: 'http://music.163.com/song/media/outer/url?id=1366903169.mp3', album: Album(id: 79310982, name: 'Falling', coverImageUrl: 'http://p2.music.126.net/LslEJ9pYUITGooTEsVQ2-A==/109951164091521728.jpg'), artists: [Artist(id: 1019466,name: 'Rezz', imageUrl: null), Artist(id: 83289, name: 'Underoath', imageUrl: null)], mvId: 10871836),
  Music(id: 1335942780, title: '九万字', url: 'http://music.163.com/song/media/outer/url?id=1335942780.mp3', album: Album(id: 75228515, name: '人间不值得', coverImageUrl: 'http://p2.music.126.net/oVCpfPtfAqNcAbRWMU7ffA==/109951163801547166.jpg'), artists: [Artist(id: 12308369,name: '黄诗扶', imageUrl: null)], mvId: 0),
  Music(id: 1371362792, title: 'Intro_我', url: 'http://music.163.com/song/media/outer/url?id=1371362792.mp3', album: Album(id: 79754932, name: '天文学家', coverImageUrl: 'http://p1.music.126.net/cc_7LdhHvgCfiNOFK5QCiw==/109951164141976716.jpg'), artists: [Artist(id: 12264643,name: '泥鳅', imageUrl: null)], mvId: 0),
  Music(id: 1371366701, title: '天文学家', url: 'http://music.163.com/song/media/outer/url?id=1371366701.mp3', album: Album(id: 79754932, name: '天文学家', coverImageUrl: 'http://p1.music.126.net/cc_7LdhHvgCfiNOFK5QCiw==/109951164141976716.jpg'), artists: [Artist(id: 12264643,name: '泥鳅', imageUrl: null)], mvId: 0),
  Music(id: 1371617260, title: 'Loco Contigo', url: 'http://music.163.com/song/media/outer/url?id=1371617260.mp3', album: Album(id: 79777143, name: 'Loco Contigo', coverImageUrl: 'http://p1.music.126.net/8Edd-KbLGCGGyPk5wkFkDA==/109951164144621540.jpg'), artists: [Artist(id: 296416,name: 'DJ Snake', imageUrl: null), Artist(id: 309127, name: 'J Balvin', imageUrl: null), Artist(id: 45033, name: 'Tyga', imageUrl: null)], mvId: 10871912),
  Music(id: 1371523631, title: 'King of Underground', url: 'http://music.163.com/song/media/outer/url?id=1371523631.mp3', album: Album(id: 79770257, name: '唯有不甘', coverImageUrl: 'http://p1.music.126.net/YyVgJxawEJYXSMNfiaz8sA==/109951164143648095.jpg'), artists: [Artist(id: 31055,name: 'Cee', imageUrl: null), Artist(id: 30003804, name: 'GDLF MUSIC', imageUrl: null)], mvId: 0),
  Music(id: 1359995960, title: '那个短发姑娘', url: 'http://music.163.com/song/media/outer/url?id=1359995960.mp3', album: Album(id: 78538412, name: '那个短发姑娘', coverImageUrl: 'http://p1.music.126.net/gKoRN3NOeW_9XyFD4dobCQ==/109951164011436582.jpg'), artists: [Artist(id: 12258472, name: '杨力', imageUrl: null)], mvId: 0),
  Music(id: 1346104327, title: '多想在平庸的生活拥抱你', url: 'http://music.163.com/song/media/outer/url?id=1346104327.mp3', album: Album(id: 75018416, name: '多想在平庸的生活拥抱你', coverImageUrl: 'http://p1.music.126.net/z-KH6R1-HP1lpCWSnmKy8Q==/109951163911444882.jpg'), artists: [Artist(id: 12429072,name: '隔壁老樊', imageUrl: null)], mvId: 10869713),
  Music(id: 1371516088, title: 'Down Bad', url: 'http://music.163.com/song/media/outer/url?id=1371516088.mp3', album: Album(id: 79770797, name: '1-888-88-DREAM', coverImageUrl: 'http://p1.music.126.net/NBOf4yeeScw6E89p_KNq4w==/109951164143509378.jpg'), artists: [Artist(id: 14212811,name: 'Dreamville', imageUrl: null),Artist(id: 12232106,name: 'J.I.D', imageUrl: null),Artist(id: 854732,name: 'Bas', imageUrl: null),Artist(id: 36910,name: 'J. Cole', imageUrl: null),Artist(id: 980022,name: 'EarthGang', imageUrl: null), Artist(id: 36910,name: 'J. Cole', imageUrl: null), Artist(id: 12523227,name: 'Young Nudy', imageUrl: null)], mvId: 0),
  Music(id: 1357621728, title: 'Insurgence', url: 'http://music.163.com/song/media/outer/url?id=1357621728.mp3', album: Album(id: 78399461, name: 'Insurgence', coverImageUrl: 'http://p1.music.126.net/SOkshfVrQVzLDexVID9d_A==/109951163986661411.jpg'), artists: [Artist(id: 1063121,name: 'Jim Yosef', imageUrl: null), Artist(id: 12006394,name: 'Starlyte', imageUrl: null)], mvId: 0),
  Music(id: 497572729, title: '人生浪费指南', url: 'http://music.163.com/song/media/outer/url?id=497572729.mp3', album: Album(id: 35927488, name: '人生浪费指南', coverImageUrl: 'http://p2.music.126.net/-Sogc4j14F2k72BpXwK13g==/109951162999708371.jpg'), artists: [Artist(id: 12383009,name: '夏日入侵企画', imageUrl: null)], mvId: 0),
  Music(id: 1371050768, title: 'Lost Lately', url: 'http://music.163.com/song/media/outer/url?id=1371050768.mp3', album: Album(id: 79712581, name: 'Lost Lately', coverImageUrl: 'http://p1.music.126.net/6lXhxed9oMxeXLRqfG9wgw==/109951164139283981.jpg'), artists: [Artist(id: 1017035,name: 'San Holo', imageUrl: null)], mvId: 10871839),
  Music(id: 1368028065, title: '夏夜好长', url: 'http://music.163.com/song/media/outer/url?id=1368028065.mp3', album: Album(id: 79388262, name: 'A long summer nights', coverImageUrl: 'http://p1.music.126.net/3oyIB6qmExDEoZfD1TfiQA==/109951164104107088.jpg'), artists: [Artist(id: 1021328,name: '李子阳', imageUrl: null)], mvId: 0),
  Music(id: 1371331794, title: '不是你的猫', url: 'http://music.163.com/song/media/outer/url?id=1371331794.mp3', album: Album(id: 79750541, name: '不是你的猫', coverImageUrl: 'http://p1.music.126.net/F7j4mVqMARzF5GuYmEsFKg==/109951164141594446.jpg'), artists: [Artist(id: 28298725,name: '申雨鹭', imageUrl: null)], mvId: 0),
  Music(id: 1370886954, title: '枪火Show', url: 'http://music.163.com/song/media/outer/url?id=1370886954.mp3', album: Album(id: 79696996, name: '枪火Show', coverImageUrl: 'http://p1.music.126.net/sJhRvpJi6nGBgNVz1hURjw==/109951164141877967.jpg'), artists: [Artist(id: 3066,name: '胡彦斌', imageUrl: null)], mvId: 0),
  Music(id: 1365915805, title: '莫愁', url: 'http://music.163.com/song/media/outer/url?id=1365915805.mp3', album: Album(id: 79193626, name: '莫愁', coverImageUrl: 'http://p2.music.126.net/5oOb5Wk8LzO049pjeP_cOg==/109951164080240940.jpg'), artists: [Artist(id: 1181775,name: '翁大涵', imageUrl: null)], mvId: 10868905),
];

PlaylistDetail _result = PlaylistDetail(
  name: '云音乐飙升榜',
  coverUrl: 'http://p1.music.126.net/DrRIg6CrgDfVLEph9SNh7w==/18696095720518497.jpg',
  id: 19723756,
  trackCount: 100,
  description: '云音乐中每天热度上升最快的100首单曲，每日更新。',
  subscribed: false,
  subscribedCount: 1988705,
  commentCount: 156149,
  shareCount: 6074,
  playCount: 2029583616,
  creator: _creator,
  musics: _musics,
);

class PlaylistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlayList(playlist: _result);
  }
}

class PlayList extends StatefulWidget {

  const PlayList({
    Key key, 
    this.playlist
  }) : super(key: key);

  final PlaylistDetail playlist;

  List<Music> get musiclist => playlist.musics;

  @override
  State<StatefulWidget> createState() {
    return _PlayListState();
  }
}

class _PlayListState extends State<PlayList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 0,
                  pinned: true,
                  backgroundColor: Colors.blue,
                  expandedHeight: HEIGHT_HEADER,
                  bottom: MusicListHeader(
                    count: widget.musiclist.length
                  ),
                  // flexibleSpace: _PlaylistHeader(playlist: widget.playlist),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => MusicTitle(music: widget.musiclist[index]),
                    childCount: widget.musiclist.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MusicListHeader extends StatelessWidget implements PreferredSizeWidget {

  const MusicListHeader({Key key, this.count, this.tail}) : super(key: key);

  final int count;
  final Widget tail;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16)
      ),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        child: InkWell(
          onTap: () {},
          child: SizedBox.fromSize(
            size: preferredSize,
            child: Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 16)),
                Icon(
                  Icons.play_circle_outline,
                  color: Theme.of(context).iconTheme.color,
                ),
                Padding(padding: EdgeInsets.only(left: 4)),
                Text(
                  "播放全部",
                  style: Theme.of(context).textTheme.body1,
                ),
                Padding(padding: EdgeInsets.only(left: 2)),
                Text(
                  "(共$count首)",
                  style: Theme.of(context).textTheme.caption,
                ),
                Spacer(),
                // tail,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}