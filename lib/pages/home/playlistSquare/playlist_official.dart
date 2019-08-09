import 'package:flutter/material.dart';
import '../../../model/music.dart';
import '../../../components/musicplayer/inherited_demo.dart';
import '../../../utils/utils.dart';
import '../../../repository/netease.dart';
import '../../playlist/playlist.dart';

class PlaylistOfficial extends StatefulWidget {
  PlaylistOfficial({this.pageContext});
  final BuildContext pageContext;
  _PlaylistOfficialState createState() => _PlaylistOfficialState();
}

class _PlaylistOfficialState extends State<PlaylistOfficial>
    with TickerProviderStateMixin {
  List<PlayList> playlist = []; // 歌单
  List<Widget> _viewWidget = [];
  bool _isLoading = true;

  void _getTopPlaylist() async {
    setState(() {
      _isLoading = true;
    });
    var _playlist = await NeteaseRepository.getTopPlaylist();
    _playlist.forEach((item) {
      setState(() {
        playlist.add(PlayList(
          name: item['name'],
          id: item['id'],
          coverImgUrl: item['coverImgUrl'],
          playCount: item['playCount'],
          trackCount: item['trackCount'],
          creatorName: item['creator']['nickname'],
        ));
      });
      if (playlist.length == _playlist.length) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getTopPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading == true
        ? Container(
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            ),
          )
        : GridView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 180,
              childAspectRatio: 0.7,
              crossAxisSpacing: 1,
              mainAxisSpacing: 0,
            ),
            children: List.generate(playlist.length, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return Playlists(playlist[index].id, 'playlist');
                  }));
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 110.0,
                            height: 110.0,
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                child: Image.network(
                                  playlist[index].coverImgUrl,
                                )),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Container(
                            width: 110.0,
                            child: Text(
                              playlist[index].name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 2.0,
                      right: 20.0,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.play_arrow,
                                color: Theme.of(context).primaryIconTheme.color,
                                size: 12),
                            SizedBox(
                              width: 1.0,
                            ),
                            Text(getFormattedNumber(playlist[index].playCount),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 11))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
          );
  }
}
