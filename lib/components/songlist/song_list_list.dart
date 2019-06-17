import 'package:flutter/material.dart';
import 'package:netease_music/components/songlist/song_list_item.dart';

class SongListList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SongListListState();
  }
}

class _SongListListState extends State<SongListList> {

  final List<Map> map = [
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":1,"name":"硬地围炉夜2017网易云音乐原创盛典","author":"网易云音乐","total":199,"playTotal":1056824,'time':1560756361000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"每天都要做一个情绪稳定的成年人","author":"布尔都是啊","total":50,"playTotal":1056824,'time':1560754905000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"经典粤语合计[无损音乐]黑胶唱片会展中心","author":"布尔都是啊","total":88,"playTotal":1056824,'time':1560754905000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"麦浚龙爱情四部曲","author":"布尔都是啊","total":325,"playTotal":99999,'time':1560754905000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"时间有泪--香港十大作词人写尽世间酸甜苦辣","author":"布尔都是啊","total":199,"playTotal":1056824,'time':1560754905000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"1975-至今经典日剧主题曲/剧中曲","author":"布尔都是啊","total":199,"playTotal":1056824,'time':1560754905000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"400首好听英文歌","author":"布尔都是啊","total":55,"playTotal":105234,'time':1560736861000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"营地发生地方都是都是都是是谁的","author":"布尔都是啊","total":124,"playTotal":1056824,'time':1560618061000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"营地发生地方都是都是都是是谁的","author":"布尔都是啊","total":199,"playTotal":1056824,'time':1560531661000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"营地发生地方都是都是都是是谁的","author":"布尔都是啊","total":58,"playTotal":1056824,'time':1560531661000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"营地发生地方都是都是都是是谁的","author":"布尔都是啊","total":199,"playTotal":1056824,'time':1560531661000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"营地发生地方都是都是都是是谁的","author":"布尔都是啊","total":199,"playTotal":1056824,'time':1560531661000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"营地发生地方都是都是都是是谁的","author":"布尔都是啊","total":88,"playTotal":1056824,'time':1560531661000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"营地发生地方都是都是都是是谁的","author":"布尔都是啊","total":199,"playTotal":1056824,'time':1560531661000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"营地发生地方都是都是都是是谁的","author":"布尔都是啊","total":199,"playTotal":1056824,'time':1560531661000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"营地发生地方都是都是都是是谁的","author":"布尔都是啊","total":332,"playTotal":1056824,'time':1560531661000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"营地发生地方都是都是都是是谁的","author":"布尔都是啊","total":199,"playTotal":1056824,'time':1560531661000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"营地发生地方都是都是都是是谁的","author":"布尔都是啊","total":199,"playTotal":1056824,'time':1560531661000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"营地发生地方都是都是都是是谁的","author":"布尔都是啊","total":199,"playTotal":1056824,'time':1560531661000},
    {"imageUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg","type":0,"name":"营地发生地方都是都是都是是谁的","author":"布尔都是啊","total":199,"playTotal":1056824,'time':1560531661000},
  ];

  bool showTotal = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      child: ListView.builder(
        itemCount: map.length,
        itemBuilder: (context,index){
          return Container(
            padding: EdgeInsetsDirectional.fromSTEB(0,0,0,0),
            child: InkWell(
              child: SongListItem(
                this.map[index],
                showTotal: true,
                showTypeIcon: true,
                showPlayTotal: true,
                showTime: true,
              ),
              onTap: (){
                print('歌单详情页');
              },
            ),
          );
        },
      ),
    );
  }

}