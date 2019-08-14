import 'package:flutter/material.dart';
import 'package:netease_music/model/music.dart';
import 'package:netease_music/pages/artist/artist_page.dart';
import 'package:netease_music/repository/netease.dart';
import 'package:fluwx/fluwx.dart' as fluwx;


class CollectArtistPage extends StatefulWidget {
  @override
  CollectArtistPageState createState() => CollectArtistPageState();
}

class CollectArtistPageState extends State<CollectArtistPage>{

  bool _isLoading = true;
  List<Artist> artists = [];
  int artistCount = 1;
  @override
  void initState() {
    super.initState();
    _getArtists();
  }

  Future<void> _getArtists() async {
    var _len = artists.length;
    var result =
    await NeteaseRepository.getArtistSublist();
    if (this.mounted) {
      setState(() {
        artistCount = result['count'];
        result['data'].asMap().forEach((int index, artist) {
          artists.add(Artist(
              id: artist['id'],
              name: artist['name'],
              alias: artist['alias'],
              imageUrl: artist['img1v1Url']));
        });
        if (artists.length == _len + result['data'].length) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  _isLoading == true
        ? Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
        ))
        : artists.length == 0
        ? Container(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Text(
            '暂无歌手记录',
            style: TextStyle(
                color: Theme.of(context).textTheme.subtitle.color),
          ),
        ))
        : SingleChildScrollView(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: _buildContent(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context) {
    List<Widget> _widgetlist = [];
    artists
      ..asMap().forEach((int index, item) {
        _widgetlist.add(InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return ArtistPage(item.id);
            }));
          },
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(backgroundImage: NetworkImage(item.imageUrl)),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            item.name,
                            style: TextStyle(),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          item.alias.length > 0
                              ? Text('（${item.alias[0]}）')
                              : Text('')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "专辑: ${item.alias.length}",
                            style: TextStyle(fontSize: 13,color: Color(0xff666666)),
                          ),
                          Text(
                            "  MV: ${item.alias.length}",
                            style: TextStyle(fontSize: 13,color: Color(0xff666666)),
                          ),

                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
      });

    return _widgetlist;
  }

}
