import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:netease_music/repository/netease.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'comment_item.dart';
import 'package:toast/toast.dart';
import 'package:emoji_picker/emoji_picker.dart';
import '../../pages/album_cover/album_cover.dart';
import '../../pages/share/bottom_share_comment.dart';

///歌曲,歌单,专辑评论页
class CommentPage extends StatefulWidget {
  const CommentPage(this.type, this.id, this.name, this.author, this.imageUrl,
      {Key key})
      : super(key: key);

  //类型 0:歌曲 1:歌单 2:专辑
  final int type;
  //歌曲id/歌单id
  final String id;
  //名称
  final String name;
  //作者
  final String author;
  //封面图片链接
  final String imageUrl;

  @override
  State<StatefulWidget> createState() {
    return _CommentPageState();
  }
}

class _CommentPageState extends State<CommentPage> {
  Map<String, dynamic> map;

  //用于监听列表是否拉到最下面
  ScrollController _scrollController = new ScrollController();
  //是否正在加载中
  bool isPerformingRequest = false;
  //是否已加载完全部
  bool isDone = false;
  //加载页数
  int commentPageNum = 0;
  //评论输入框controller
  final TextEditingController commentController = new TextEditingController();
  //评论输入框焦点
  FocusNode commentInputFocusNode = FocusNode();
  //是否显示表情选择器
  bool showEmojiSelector = false;

  String url = '';

  ///加载数据
  void _getData() {
    Future.delayed(Duration(seconds: 2)).then((v) {
      Dio dio = new Dio();
      var response = dio.get(url,
          queryParameters: {"id": this.widget.id, "limit": 10, "offset": 0});
      response.then((value) {
        setState(() {
          this.map = value.data;
          if (value.data['total'] == 0) {
            this.isDone = true;
          }
        });
      }).catchError((e) {});
    });
  }

  ///加载更多评论
  void _retrieveData() {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      this.commentPageNum++;

      if (this.commentPageNum * 10 > this.map['total']) {
        setState(() {
          this.isDone = true;
        });
        return;
      }

      List<dynamic> comments = this.map['comments'];
      Dio dio = new Dio();
      var response = dio.get(url, queryParameters: {
        "id": 347230,
        "limit": 10,
        "offset": this.commentPageNum * 10
      });

      response.then((value) {
        List<dynamic> data = value.data['comments'];
        data.forEach((v) {
          comments.add(v);
        });
        setState(() {
          this.map['comments'] = comments;
          isPerformingRequest = false;
        });
      }).catchError((e) {
        setState(() {
          isPerformingRequest = false;
        });
      });
    }
  }

  ///列表头,显示歌名/歌单名/封面等
  Widget _buildTitleCard() {
    return Card(
      margin: EdgeInsets.all(0),
      shape: Border(),
      elevation: 0,
      child: InkWell(
        child: Container(
          child: ListTile(
            //名称
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                this.widget.type == 1
                    ? Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 20,
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(2.0)),
                            border: new Border.all(
                                width: 0.5, color: Color(0xFFFF6161)),
                          ),
                          child: Text(
                            '歌单',
                            style: TextStyle(
                                fontSize: 8, color: Color(0xFFFF6161)),
                          ),
                        ),
                      )
                    : Text(''),
                Text(this.widget.type == 1 ? " " : ''),
                Expanded(
                  child: Text(
                    this.widget.name,
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
            //作者
            subtitle: Row(
              children: <Widget>[
                InkWell(
                  child: Row(
                    children: <Widget>[
                      Text(
                        this.widget.type == 1 ? 'by ' : '',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        this.widget.author,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff4978C0),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    print('singer');
                  },
                ),
                Expanded(
                  child: Center(),
                ),
              ],
            ),
            //封面图
            leading: Image.network(
              Uri.decodeFull(this.widget.imageUrl),
              width: 50,
              height: 50,
            ),
            trailing: Icon(Icons.chevron_right),
          ),
        ),
        onTap: () {
          print('tap');
        },
      ),
    );
  }

  ///评论输入框
  Widget _buildInput() {
    return Container(
        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: TextField(
                textInputAction: TextInputAction.send,
                keyboardType: TextInputType.multiline,
//                      maxLength: 135,
                maxLines: 3,
                minLines: 1,
                controller: commentController,
                focusNode: commentInputFocusNode,
                onChanged: (value) {
                  if (commentController.text.length > 140) {
                    Toast.show(
                      "你的输入已超出140字，\n请修改后发送。",
                      context,
                      duration: Toast.LENGTH_SHORT,
                      gravity: Toast.CENTER,
                      textColor: Colors.white70,
                      backgroundColor: Color(0xd7000000),
                      backgroundRadius: 8,
                    );
                  }
                },
                decoration: InputDecoration(
                  hintText: '听说爱评论的人粉丝多',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Color(0x96999999),
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(140)],
              ),
            ),
            IconButton(
              icon: Icon(Icons.image),
              onPressed: () {
                print('贴图');
              },
            ),
            this.showEmojiSelector == true
                ? IconButton(
                    icon: Icon(Icons.keyboard),
                    onPressed: () {
                      FocusScope.of(context)
                          .requestFocus(commentInputFocusNode);
                      setState(() {
                        this.showEmojiSelector = false;
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.insert_emoticon),
                    onPressed: () {
                      // 触摸收起键盘
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        this.showEmojiSelector = true;
                      });
                    },
                  ),
          ],
        ));
  }

  ///精彩评论
  Widget _buildHotComment() {
    return this.map['hotComments'].length == 0
        ? Center()
        : StickyHeader(
            header: Container(
              color: Colors.white,
              padding: EdgeInsetsDirectional.fromSTEB(15, 8, 0, 6),
              alignment: Alignment.centerLeft,
              child: Text(
                '精彩评论',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            content: Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _buildHotCommentItems(),
              ),
            ),
          );
  }

  List<Widget> _buildHotCommentItems() {
    List<dynamic> hotComments = this.map['hotComments'];
    if (hotComments != null && hotComments.length > 0) {
      return List.generate(
        hotComments.length,
        (index) => CommentItem(
              hotComments[index]['user']['nickname'],
              hotComments[index]['user']['avatarUrl'],
              hotComments[index]['likedCount'],
              hotComments[index]['time'],
              hotComments[index]['content'],
              isEnd: hotComments.length == index + 1,
            ),
      );
    }

    return [Center()];
  }

  ///评论
  Widget _buildComment() {
    return StickyHeader(
      header: Container(
        color: Colors.white,
        padding: EdgeInsetsDirectional.fromSTEB(15, 8, 0, 6),
        alignment: Alignment.bottomLeft,
        child: Row(
          children: <Widget>[
            Text(
              '最新评论 ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Text(
                this.map['total'].toString(),
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
      content: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _buildCommentItems(),
        ),
      ),
    );
  }

  List<Widget> _buildCommentItems() {
    List<dynamic> hotComments = this.map['comments'];
    if (hotComments != null && hotComments.length > 0) {
      return List.generate(
        hotComments.length,
        (index) => CommentItem(
              hotComments[index]['user']['nickname'],
              hotComments[index]['user']['avatarUrl'],
              hotComments[index]['likedCount'],
              hotComments[index]['time'],
              hotComments[index]['content'],
              isEnd: hotComments.length == this.map['total'],
            ),
      );
    }

    return [Center()];
  }

  ///关闭输入键盘和表情选择器
  void hideKeyBord() {
    if (this.showEmojiSelector) {
      setState(() {
        this.showEmojiSelector = false;
      });
    }
    if (commentInputFocusNode.hasFocus) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(46.0),
        child: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Text(
              this.map == null
                  ? '评论'
                  : '评论(' + this.map['total'].toString() + ')',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.radio_button_unchecked,
              ),
              onPressed: () {
                BottomShareComment.showBottomShareComment(
                  context,
                  int.parse(widget.id),
                  widget.imageUrl,
                  widget.name,
                  widget.author,
                  widget.type,
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.equalizer,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return AlbumCoverPage();
                }));
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTapDown: (v) {
                  hideKeyBord();
                },
                child: ListView.builder(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  itemCount: 5,
                  // ignore: missing_return
                  itemBuilder: (BuildContext context, int index) {
                    //名字/作者/封面
                    if (index == 0) {
                      return _buildTitleCard();
                    }

                    //判断是否还没有加载到数据
                    if (this.map == null) {
                      if (index == 4) {
                        _getData();
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                  width: 24.0,
                                  height: 24.0,
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Theme.of(context).primaryColor),
                                      strokeWidth: 2.0)),
                              Text(''),
                              Text(
                                '正在加载...',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return Center();
                    }

                    //间隔
                    if (index == 1) {
                      return Container(
                        height: 8,
                        color: Color(0x1e999999),
                        child: Center(),
                      );
                    }

                    //精彩评论
                    if (index == 2) {
                      return _buildHotComment();
                    }

                    //更多评论
                    if (index == 3) {
                      return _buildComment();
                    }

                    //加载更多
                    if (index == 4) {
                      return this.isDone
                          ? Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "没有更多了",
                                style: TextStyle(color: Colors.grey),
                              ))
                          : Container(
                              padding: const EdgeInsets.all(16.0),
                              alignment: Alignment.center,
                              child: SizedBox(
                                  width: 24.0,
                                  height: 24.0,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2.0)),
                            );
                    }
                  },
                ),
              ),
            ),
            Divider(
              height: 0,
              color: Colors.grey,
            ),

            //评论输入框
            _buildInput(),
            this.showEmojiSelector == true
                ? EmojiPicker(
                    rows: 3,
                    columns: 8,
                    numRecommended: 10,
                    buttonMode: ButtonMode.CUPERTINO,
                    onEmojiSelected: (emoji, category) {
                      setState(() {
                        this.commentController.text =
                            this.commentController.text + emoji.emoji;
                      });
                    },
                  )
                : Center(),
          ],
        ),
      ),
      resizeToAvoidBottomPadding: !this.showEmojiSelector, //设置输入键盘是否要顶起内容
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      hideKeyBord();
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _retrieveData();
      }
    });
    commentInputFocusNode.addListener(() {
      if (commentInputFocusNode.hasFocus) {
        // TextField has lost focus
        setState(() {
          this.showEmojiSelector = false;
        });
      }
    });

    if (this.widget.type == 0) {
      url = API_HOST + 'comment/music';
    }
    if (this.widget.type == 1) {
      url = API_HOST + 'comment/playlist';
    }
    if (this.widget.type == 2) {
      url = API_HOST + 'comment/album';
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
