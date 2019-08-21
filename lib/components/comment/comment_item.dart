import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class CommentItem extends StatelessWidget {
  const CommentItem(
      this.userName, this.userImage, this.likeCount, this.time, this.comment,
      {Key key, this.isEnd = false})
      : super(key: key);

  // 用户名
  final String userName;

  // 头像
  final String userImage;

  // 点赞数
  final int likeCount;

  // 评论时间
  final int time;

  // 评论内容
  final String comment;

  //是否是最后一条
  final bool isEnd;

  @override
  Widget build(BuildContext context) {
    // Leading Icon Size
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Column(
        children: <Widget>[
          //头像,用户名,评论时间,点赞数量
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    // 头像
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 8, 0),
                      child: ClipOval(
                        child: SizedBox(
                          width: 30.0,
                          height: 30.0,
//                          child: Image(
//                            image: NetworkImage(
//                              this.userImage,
//                            ),
//                            fit: BoxFit.cover,
//                          ),
                          child: FadeInImage.memoryNetwork(
                            image: this.userImage,
                            placeholder: kTransparentImage,
                          ),
                        ),
                      ),
                    ),

                    //用户名,评论时间
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          this.userName,
                          style:
                              TextStyle(fontSize: 13, color: Color(0xff666666)),
                        ),
                        Text(
                          formatDate(this.time),
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 点赞数量
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap: () {
                    print('点赞');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: formatLikedCount(),
                  ),
                ),
              ),
            ],
          ),

          //评论内容
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    // Leading
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(53, 5, 15, 0),
                        child: Text(
                          this.comment.trimLeft(),
                          style: TextStyle(
                              fontSize: 13,
                              color: Color(0xff666666),
                              height: 1.1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // trailing
            ],
          ),

          //分隔线
          Padding(
            padding: this.isEnd
                ? EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0)
                : EdgeInsetsDirectional.fromSTEB(53, 0, 0, 0),
            child: Divider(
              height: 22,
            ),
          ),
        ],
      ),
    );
  }

  ///时间格式化
  ///时间戳(13位) --> xxxx年xx月xx日
  String formatDate(int time) {
    var nowTime = DateTime.now();
    var dateTime = DateTime.fromMillisecondsSinceEpoch(time);

    if (nowTime.year == dateTime.year) {
      //是今年的只返回月日
      return dateTime.month.toString() + '月' + dateTime.day.toString() + '日';
    }
    //返回完整年月日
    return dateTime.year.toString() +
        '年' +
        dateTime.month.toString() +
        '月' +
        dateTime.day.toString() +
        '日';
  }

  ///点赞数格式化
  List<Widget> formatLikedCount() {
    bool isBig = false;
    String total = this.likeCount.toString();
    if (this.likeCount > 99999) {
      isBig = true;
      total = (this.likeCount / 10000).toStringAsFixed(1);
    }

    return [
      Text(
        total,
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      Text(
        isBig ? '万 ' : ' ',
        style: TextStyle(fontSize: 11, color: Colors.grey),
      ),
      Icon(
        Icons.thumb_up,
        color: Colors.black45,
        size: 18,
      ),
    ];
  }
}
