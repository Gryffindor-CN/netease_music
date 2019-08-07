import 'package:flutter/material.dart';

/// 歌单列表item
/// [map] 必填 item详情
/// [map['imageUrl'] String] 封面图片链接
/// [map['type'] int] item类型,0:歌单,1:专辑
/// [map['name'] String] 标题
/// [map['author'] String] 作者
/// [map['total'] int] 歌曲数量
/// [map['playTotal'] int] 播放总量
/// [map['time'] int] 13位时间戳
/// [showTotal] 可选 是否显示歌单内歌曲数量
/// [showTypeIcon] 可选 是否显示类型icon,歌单/专辑
/// [showPlayTotal]  可选 是否显示播放总量
/// [showTime]  可选 是否显示时间
///
class SongListItem extends StatelessWidget {

  const SongListItem(
      this.map,
      {
        Key key,
        this.showTotal = false,
        this.showTypeIcon = false,
        this.showPlayTotal = false,
        this.showTime = false,
      }
        ) : super(key: key);

  final Map map;
  final bool showTotal;
  final bool showTypeIcon;
  final bool showPlayTotal;
  final bool showTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(14,5,10,5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: new ClipRRect(
              borderRadius: new BorderRadius.circular(4.5),
              child: Image.network(map['imageUrl'],width: 48,height: 48,),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsetsDirectional.fromSTEB(12,0,0,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        this.showTypeIcon ? Container(
                          alignment: Alignment.center,
                          width: 20, height: 12,
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.all(new Radius.circular(2.0)),
                            border: new Border.all(width: 0.5, color: Color(0xFFFF6161)),
                          ),
                          child: Text(
                            map['type'] == 0 ? '歌单':'专辑',
                            style: TextStyle(fontSize: 8, color: Color(0xFFFF6161)),
                          ),
                        ) : Center(),
                        Expanded(
                          child: Container(
                            padding: EdgeInsetsDirectional.fromSTEB(2,0,0,0),
                            child: Text(
                              map['name'],
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            this.showTotal == true? map['total'].toString() + '首，' : '',
                            style: TextStyle(color: Color(0xff666666),fontSize: 12),
                          ),
                        ),
                        Container(
                          child: Text(
                            map['type'] == 0 ? 'by '+ map['author'] : map['author'],
                            style: TextStyle(color: Color(0xff666666),fontSize: 12),
                          ),
                        ),
                        Container(
                          child: Text(
                            this.showPlayTotal == true? '，播放 '+ formatPlayTotal() : '',
                            style: TextStyle(color: Color(0xff666666),fontSize: 12),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              this.showTime ? ' '+formatDate() : '',
                              style: TextStyle(color: Color(0xff666666),fontSize: 12),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///时间格式化
  ///距离现在小于10分钟 --> 刚刚
  ///距离现在小于1小时 --> xx分钟前
  ///距离现在小于1天 --> xx:xx
  ///距离现在大于1天,小于两天 --> 昨天 xx:xx
  ///距离现在大于2天 --> xx月xx日
  String formatDate(){
    var nowTime = DateTime.now();
    var dateTime = DateTime.fromMillisecondsSinceEpoch(this.map['time']);

    if(nowTime.year == dateTime.year){
      if(nowTime.month == dateTime.month){
        if(nowTime.day == dateTime.day){
          if(nowTime.hour == dateTime.hour){
            int min = nowTime.minute - dateTime.minute;
            if(min < 10){
              return '刚刚';
            }
            return min.toString() + '分钟前';
          }
          return (dateTime.hour < 10 ? '0':'') + dateTime.hour.toString() + ':' + (dateTime.minute < 10 ? '0':'') + dateTime.minute.toString();
        }
        if(nowTime.day - dateTime.day == 1){
          return '昨天 ' + (dateTime.hour < 10 ? '0':'') + dateTime.hour.toString() + ':' + (dateTime.minute < 10 ? '0':'') + dateTime.minute.toString();
        }
      }
    }
    //返回完整月日
    return dateTime.month.toString() + '月' + dateTime.day.toString() + '日';
  }

  ///点赞数格式化
  ///10万以下 --> xxxx次
  ///10万及以上 --> xxxx万次
  String formatPlayTotal(){

    bool isBig = false;
    String total = this.map['playTotal'].toString();
    if(this.map['playTotal'] > 99999){
      isBig = true;
      total = (this.map['playTotal']/10000).toStringAsFixed(1);
    }

    return isBig?'$total万次':'$total次';
  }
}
