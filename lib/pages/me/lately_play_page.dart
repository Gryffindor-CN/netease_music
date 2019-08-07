import 'package:flutter/material.dart';
import 'package:netease_music/components/songlist_list/song_list_list.dart';



class LatelyPlayPage extends StatefulWidget {
  @override
  MeHomePageState createState() => MeHomePageState();
}

class MeHomePageState extends State<LatelyPlayPage> {

  Map data;


  @override
  void initState() {
    super.initState();
    this.data = {
      "songTotal":100,
      "liveTotal":0,
      "videoTotal":5,
      "otherTotal":0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: new Text('最近播放'),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Row(
                  children: <Widget>[
                    Text("歌曲"),
                    Text(
                      this.data['songTotal'] == 0?'':' ${this.data['songTotal']}',
                      style: TextStyle(
                        fontSize: 11
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ),
              Tab(
                child: Row(
                  children: <Widget>[
                    Text("直播"),
                    Text(
                      this.data['liveTotal'] == 0?'':' ${this.data['liveTotal']}',
                      style: TextStyle(
                          fontSize: 11
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ),
              Tab(
                child: Row(
                  children: <Widget>[
                    Text("视频"),
                    Text(
                      this.data['videoTotal'] == 0?'':' ${this.data['videoTotal']}',
                      style: TextStyle(
                          fontSize: 11
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ),
              Tab(
                child: Row(
                  children: <Widget>[
                    Text("其他"),
                    Text(
                      this.data['otherTotal'] == 0?'':' ${this.data['otherTotal']}',
                      style: TextStyle(
                          fontSize: 11
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ),
            ],
          ),
          // title: Text('Tabs Demo'),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.directions_transit),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
            SongListList(),
          ],
        ),
      ),
    );
  }
}
