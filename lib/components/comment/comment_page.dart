import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'comment_item.dart';

class MusicCommentPage extends StatefulWidget{

  const MusicCommentPage(this.musicId, {Key key}) : super(key: key);

  final String musicId;

  @override
  State<StatefulWidget> createState() {
    return _MusicCommentState();
  }
}

class _MusicCommentState extends State<MusicCommentPage> {

  final Map<String,dynamic> map = {"isMusician":false,"userId":-1,"topComments":[],"moreHot":true,"hotComments":[{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p3.music.126.net/8LJqgg8xbv70s5GY4Rfoiw==/109951163925919271.jpg","experts":null,"vipRights":null,"userId":32632061,"vipType":0,"nickname":"三清两清一清","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":4746394,"content":"绝对影响世界的乐队，词曲都是和平，奋斗，鼓励。可惜啊","time":1412694773980,"likedCount":137690,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":null,"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/TT0r25kNGR8MUxIjp70Ntw==/7888995929432671.jpg","experts":null,"vipRights":{"associator":{"vipCode":100,"rights":true},"musicPackage":null,"redVipAnnualCount":-1},"userId":9080498,"vipType":11,"nickname":"冰凍七音","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":5031795,"content":"有些人死了，他还活着","time":1413809782401,"likedCount":95348,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":null,"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/FGLON3i5wqBLVu0oevHCAg==/1426066582562832.jpg","experts":null,"vipRights":null,"userId":1075400,"vipType":0,"nickname":"总有一天你会成为你想成为的人","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":10827931,"content":"有一条路，叫做《灰色轨迹》；有一种奉献，叫做《光辉岁月》； 有一种感恩，叫做《真的爱你》；有一种不眠，叫做《冷雨夜》。 有一种思念，叫做《遥望》。有一种迷惘，叫做《谁伴我闯荡》。 有一种无奈，叫做《情人》。有一种境界，叫做《海阔天空》。——————————————永远的黄家驹！","time":1423994913970,"likedCount":70106,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":null,"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/BgAGePLEvVu_4KX2GhUfHQ==/7939573466068382.jpg","experts":null,"vipRights":null,"userId":32229287,"vipType":0,"nickname":"独坐凭栏","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":11209016,"content":"“钢铁锅，含着泪喊修瓢锅。。。”","time":1424581669223,"likedCount":59975,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":null,"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/gkRVKH3V3evItwJpU2CHeg==/18736777650743188.jpg","experts":null,"vipRights":{"associator":null,"musicPackage":{"vipCode":220,"rights":true},"redVipAnnualCount":-1},"userId":77436695,"vipType":10,"nickname":"梦c混混","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":71840747,"content":"其实喜欢驹哥的歌的人也不少，反正我是ktv必唱的，手机上的歌换了有换，他的歌没换过，这两天上网易看到他的歌最高的才1.2 万不到的评论，想哭想笑，我没追过星，但你不一样，你的歌伴我走过16 年 别人都说周杰伦是我们90年的回忆，你何尝不是呢，我欠你歌碟，门票钱，一个评论我不想欠","time":1455805697445,"likedCount":52584,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":null,"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p3.music.126.net/T_843uOmv5ftVaU9x3GYfQ==/1364493980497369.jpg","experts":null,"vipRights":null,"userId":61779685,"vipType":0,"nickname":"LongLongLonger","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":52795118,"content":"还有半个月整就考研，身心疲惫的我在自习室真的是难受死了，云音乐给我推荐了这首歌，听了以后就感觉鼻尖酸酸的，内心怦怦的，不知何时，一路走来，披星戴月，争分夺秒，希望最终的结果不负众望，一个男生怎么可以这样矫情…… 2015-12-10 20:10 一个朦胧夜中的奋斗者","time":1449749417218,"likedCount":32543,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":null,"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/KvzBdqUMWae2PiDUhgF2GA==/2887317536126221.jpg","experts":null,"vipRights":{"associator":null,"musicPackage":{"vipCode":220,"rights":true},"redVipAnnualCount":-1},"userId":44548148,"vipType":10,"nickname":"愚蠢的吴阵雨","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":6468317,"content":"每次别人问，你讲粤语的啊，那你会唱海阔天空吗！每次去唱歌，总有人点好了在那里坑我…","time":1417252793181,"likedCount":23887,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":null,"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p3.music.126.net/u42oU10gXkrszFs3ul-uvw==/1390882210062390.jpg","experts":null,"vipRights":null,"userId":133097793,"vipType":0,"nickname":"ysj8888","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":73390342,"content":" 梦碎东京富士山，泪撒香港将军澳。纵横世间千万曲，世间再无黄家驹。\n ——向家驹致敬","time":1456187909849,"likedCount":19287,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":null,"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/3D6Mjk8KERp9zVPyMGyayw==/3295236358962547.jpg","experts":null,"vipRights":null,"userId":137176194,"vipType":0,"nickname":"李戏子","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":128674868,"content":"上广州快一个月了，还是来回奔波面试，要么试用期长，不过没有工资；要么工资太低，或者电话销售。但跟家里人说自己找到工作了。期间感冒一直不好，还发烧，经常吃面或者不吃。很冷很累很想家。昨晚面试坐车走路回来的时候自己唱着海阔天空，竟然把自己唱哭了。再苦，也得咬牙坚持。希望下午的面试通过","time":1457758362543,"likedCount":16975,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":null,"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p3.music.126.net/or1Qwv0eyN7I11AHu7Z0Dw==/109951162904966351.jpg","experts":null,"vipRights":null,"userId":45787795,"vipType":0,"nickname":"小时光夏洛克","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":21638191,"content":"1996年，我们镇上有家快要倒闭的影像店，门口有很多箱子，箱子里有很多个卡带，一块钱一个。当时随便拿了几盒。里面有一盒就是beyond。一直听到2007快要高考。那时候开始流行mp3。那个卡带就再也找不到了。每次回想起来，都能看到自己七岁坐在树下听歌入神模糊的样子。可是那个卡带再也找不到了。","time":1433979508419,"likedCount":11669,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":null,"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p3.music.126.net/cAYpttm2zcKqe4Ssrf4uvg==/3253454913599213.jpg","experts":null,"vipRights":null,"userId":122637418,"vipType":0,"nickname":"你可知相见不如怀念","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":72650302,"content":"《环球时报》曾发文感慨：在中国，家驹之后，再无摇滚。时过境迁，博爱众生的大时代，逐渐走入小情小爱的小时代，满眼皆是爱恨痴嗔与风花雪月。像黄家驹一样，谱写出一首首满载大爱的歌曲，已经寥寥无几。","time":1456017096213,"likedCount":11145,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":null,"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p3.music.126.net/SjGCEBa_f_uT1pF8uMoxWA==/2897213140978080.jpg","experts":null,"vipRights":null,"userId":69710996,"vipType":0,"nickname":"刺猬的优雅灬","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":25603632,"content":"一直很出名，以前尝试去听，觉得没什么感觉。现在却特别喜欢，原来有些东西，只有到了特定的人生阶段，有了足够的人生阅历，才能体会到其中意味。","time":1436401438576,"likedCount":9296,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":null,"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/xwRZ89aj0q85zuqctFuRPA==/3262251000002985.jpg","experts":null,"vipRights":{"associator":null,"musicPackage":{"vipCode":220,"rights":true},"redVipAnnualCount":-1},"userId":58529229,"vipType":10,"nickname":"玩家EVA","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":122821842,"content":"小时候不知道歌名也不会用电脑，连续三天下午守在CCTV音乐台等这首歌再次岀现","time":1456214262710,"likedCount":6680,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":null,"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p3.music.126.net/ADyroy6lqIhaSm2A6jJOSw==/109951163901702409.jpg","experts":null,"vipRights":null,"userId":63442978,"vipType":0,"nickname":"狗蛋少年","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":51594066,"content":"大鹏说你们好久没在一起唱歌了。还说那年是你们的解散演唱会，我刚去北京，没有钱买演唱会的票但我还是买了[流泪]","time":1449327106693,"likedCount":5896,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":null,"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p3.music.126.net/00Ld6SyqzJgTmhwrEyd1gQ==/109951163517027070.jpg","experts":null,"vipRights":{"associator":{"vipCode":100,"rights":true},"musicPackage":null,"redVipAnnualCount":-1},"userId":111267699,"vipType":11,"nickname":"终于明白_","userType":0},"beReplied":[],"pendantData":{"id":7013,"imageUrl":"http://p1.music.126.net/vRSf2jsI13wJ1W1h2jnSWQ==/109951163313137933.jpg"},"showFloorComment":null,"status":0,"commentId":169002090,"content":"人这一辈子有两件事不能嘲笑：一是出身，二是梦想。","time":1465910180298,"likedCount":2103,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":null,"repliedMark":false,"liked":false}],"code":200,"comments":[{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/d0hrqC2nx-dHu0ZkHY5yvQ==/2946691167766523.jpg","experts":null,"vipRights":{"associator":{"vipCode":100,"rights":true},"musicPackage":null,"redVipAnnualCount":-1},"userId":283639158,"vipType":11,"nickname":"黑夜之寂-","userType":0},"beReplied":[{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p3.music.126.net/auESh5bqPHjDUOaARcCpkA==/3402988489940611.jpg","experts":null,"vipRights":null,"userId":365708156,"vipType":0,"nickname":"蝶恋夏花","userType":0},"beRepliedCommentId":1497061331,"content":"广西人也有很多不会说粤语，虽然我的粤语说得不好，但是可以唱出来了，我觉得很幸福。","status":0,"expressionUrl":null}],"pendantData":null,"showFloorComment":null,"status":0,"commentId":1517112259,"content":"哈哈，我这儿（广西梧州）土白话和粤语很像[大笑]","time":1560073113700,"likedCount":3,"expressionUrl":null,"commentLocationType":0,"parentCommentId":6468317,"decoration":{},"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/H3Jr1lwIuoxblvY7Ee8yiw==/109951163833865815.jpg","experts":null,"vipRights":null,"userId":1618336920,"vipType":0,"nickname":"Pieces_y","userType":0},"beReplied":[{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/HFUWmns6UzQceS4tBCAvMQ==/109951164106680310.jpg","experts":null,"vipRights":null,"userId":1361386337,"vipType":0,"nickname":"詩詩是時使事","userType":0},"beRepliedCommentId":1516988321,"content":null,"status":-10,"expressionUrl":null}],"pendantData":null,"showFloorComment":null,"status":0,"commentId":1517126749,"content":"怎么了","time":1560072045469,"likedCount":5,"expressionUrl":null,"commentLocationType":0,"parentCommentId":1516988321,"decoration":{},"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/sjPRG45q_oOFAOE1UQqwrg==/109951163727051274.jpg","experts":null,"vipRights":null,"userId":93492339,"vipType":0,"nickname":"阿里云支付","userType":0},"beReplied":[{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p3.music.126.net/bc_h0GvtRXPYTO-koDe-yQ==/109951164136126336.jpg","experts":null,"vipRights":null,"userId":223162,"vipType":10,"nickname":"小瓜皮1122","userType":0},"beRepliedCommentId":1517046313,"content":null,"status":-5,"expressionUrl":null}],"pendantData":null,"showFloorComment":null,"status":0,"commentId":1517135565,"content":"把你頭像給我交了","time":1560071946600,"likedCount":1,"expressionUrl":null,"commentLocationType":0,"parentCommentId":1517035815,"decoration":{},"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/VnZiScyynLG7atLIZ2YPkw==/18686200114669622.jpg","experts":null,"vipRights":null,"userId":293381989,"vipType":0,"nickname":"智_愚","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":1517090906,"content":"[呆]大家好呀","time":1560070420536,"likedCount":61,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":{},"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p3.music.126.net/xlAFlqnJ-KAFa0kSma8x_A==/109951163990341960.jpg","experts":null,"vipRights":null,"userId":448579154,"vipType":0,"nickname":"是可爱多本人了","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":1517027466,"content":"爱","time":1560068468302,"likedCount":31,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":{},"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/DfO9Ofc1K3ZcIRYMvWuJtw==/18544363114259833.jpg","experts":null,"vipRights":null,"userId":7519395,"vipType":0,"nickname":"我就随便听听","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":1517033807,"content":"不错","time":1560066528281,"likedCount":19,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":{},"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/pa2ImGti-5CS2BcTG8dBPw==/19028148230295733.jpg","experts":null,"vipRights":null,"userId":68625035,"vipType":0,"nickname":"N族人","userType":0},"beReplied":[{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/Pd1doLZw5gzfI-sFb_1uow==/109951163944161149.jpg","experts":null,"vipRights":null,"userId":444558826,"vipType":0,"nickname":"你要经常开心","userType":0},"beRepliedCommentId":1516951201,"content":"yes","status":0,"expressionUrl":null}],"pendantData":null,"showFloorComment":null,"status":0,"commentId":1517019589,"content":"可以兄弟","time":1560064729770,"likedCount":1,"expressionUrl":null,"commentLocationType":0,"parentCommentId":1477000405,"decoration":{},"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/ma8NC_MpYqC-dK_L81FWXQ==/109951163250233892.jpg","experts":null,"vipRights":null,"userId":1603861495,"vipType":0,"nickname":"music_libra","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":1516958472,"content":"今天再听这首歌，感触良多！","time":1560064336359,"likedCount":168,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":{},"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/eaF898loDOXrLTbOugAlrw==/109951164128745851.jpg","experts":null,"vipRights":null,"userId":1844662127,"vipType":0,"nickname":"网黄1号","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":1516988865,"content":"家驹是信仰☀","time":1560064119868,"likedCount":26,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":{},"repliedMark":false,"liked":false},{"user":{"locationInfo":null,"liveInfo":null,"expertTags":null,"remarkName":null,"authStatus":0,"avatarUrl":"https://p4.music.126.net/XduhUsR7wee8RN_fbJp4gQ==/109951163905377306.jpg","experts":null,"vipRights":null,"userId":384873266,"vipType":0,"nickname":"queque404","userType":0},"beReplied":[],"pendantData":null,"showFloorComment":null,"status":0,"commentId":1516967249,"content":"say no to","time":1560063994523,"likedCount":70,"expressionUrl":null,"commentLocationType":0,"parentCommentId":0,"decoration":{},"repliedMark":false,"liked":false}],"total":77652,"more":true};
  final Map<String,dynamic> music = {"name":"海阔天空","singer":"Beyond","image":"https://p2.music.126.net/QHw-RuMwfQkmgtiyRpGs0Q==/102254581395219.jpg"};
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(42.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: Icon(Icons.arrow_back_ios,color: Colors.black,),
            title: Center(
              child: Text(
                '评论('+ this.map['total'].toString() +')',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.radio_button_unchecked,color: Colors.black,),
                onPressed: (){
                  print('分享');
                },
              ),
              IconButton(
                icon: Icon(Icons.insert_chart,color: Colors.black,),
                onPressed: (){
                  print('正在播放');
                },
              ),
            ],
          ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Card(
              margin:EdgeInsets.all(0),
              shape: Border(),
              child: InkWell(
                child: ListTile(
                  title: Text(
                    this.music['name'],
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      InkWell(
                        child: Text(
                          this.music['singer'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff4978C0),
                          ),
                        ),
                        onTap: (){
                          print('singer');
                        },
                      ),
                      Expanded(
                        child: Center(),
                      ),
                    ],
                  ),
                  leading: Image.network(
                    this.music['image'],
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
                onTap: (){
                  print('tap');
                },
              ),
            ),

            StickyHeader(
              header: Container(
                color: Colors.white,
                padding: EdgeInsetsDirectional.fromSTEB(15,5,0,5),
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
                  children: getHotComments(),
                ),
              ),
            ),

            StickyHeader(
              header: Container(
                color: Colors.white,
                padding: EdgeInsetsDirectional.fromSTEB(15,5,0,5),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Text(
                      '最新评论 ',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      this.map['total'].toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ),
              content: Center(
                child: Center(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: getComments(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getHotComments(){
    List<Map> hotComments = this.map['hotComments'];
    if(hotComments != null && hotComments.length > 0){

      return List.generate(hotComments.length, (index) =>
            CommentItem(
              hotComments[index]['user']['nickname'],
              hotComments[index]['user']['avatarUrl'],
              hotComments[index]['likedCount'],
              hotComments[index]['time'],
              hotComments[index]['content'],
              isEnd: hotComments.length == index+1,
            ),
      );
    }

    return [Center()];
  }

  List<Widget> getComments(){
    List<Map> comments = this.map['comments'];
    if(comments != null && comments.length > 0){



      return List.generate(comments.length, (index){
        if(index+1 == comments.length){
          if(comments.length == 20){
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text("没有更多了", style: TextStyle(color: Colors.grey),)
            );
          }
          _retrieveData();
        }
        return CommentItem(
          comments[index]['user']['nickname'],
          comments[index]['user']['avatarUrl'],
          comments[index]['likedCount'],
          comments[index]['time'],
          comments[index]['content'],
          isEnd: comments.length == index+1,
        );
      });
    }

    return [Center()];
  }

  void _retrieveData() {
    List<Map<String, Object>> comments = this.map['comments'];

    Future.delayed(Duration(seconds: 2)).then((e) {

      comments.addAll([
        {
          "user": {
            "locationInfo": null,
            "liveInfo": null,
            "userId": 93492339,
            "vipRights": null,
            "nickname": "阿里云支付",
            "userType": 0,
            "expertTags": null,
            "remarkName": null,
            "vipType": 0,
            "authStatus": 0,
            "avatarUrl": "https://p4.music.126.net/sjPRG45q_oOFAOE1UQqwrg==/109951163727051274.jpg",
            "experts": null
          },
          "beReplied": [
            {
              "user": {
                "locationInfo": null,
                "liveInfo": null,
                "userId": 223162,
                "vipRights": null,
                "nickname": "小瓜皮1122",
                "userType": 0,
                "expertTags": null,
                "remarkName": null,
                "vipType": 10,
                "authStatus": 0,
                "avatarUrl": "https://p4.music.126.net/bc_h0GvtRXPYTO-koDe-yQ==/109951164136126336.jpg",
                "experts": null
              },
              "beRepliedCommentId": 1517046313,
              "content": null,
              "status": -5,
              "expressionUrl": null
            }
          ],
          "pendantData": null,
          "showFloorComment": null,
          "status": 0,
          "commentId": 1517135565,
          "content": "把你頭像給我交了",
          "time": 1560071946600,
          "likedCount": 1,
          "expressionUrl": null,
          "commentLocationType": 0,
          "parentCommentId": 1517035815,
          "decoration": {},
          "repliedMark": false,
          "liked": false
        },
        {
          "user": {
            "locationInfo": null,
            "liveInfo": null,
            "userId": 293381989,
            "vipRights": null,
            "nickname": "智_愚",
            "userType": 0,
            "expertTags": null,
            "remarkName": null,
            "vipType": 0,
            "authStatus": 0,
            "avatarUrl": "https://p3.music.126.net/VnZiScyynLG7atLIZ2YPkw==/18686200114669622.jpg",
            "experts": null
          },
          "beReplied": [],
          "pendantData": null,
          "showFloorComment": null,
          "status": 0,
          "commentId": 1517090906,
          "content": "[呆]大家好呀",
          "time": 1560070420536,
          "likedCount": 62,
          "expressionUrl": null,
          "commentLocationType": 0,
          "parentCommentId": 0,
          "decoration": {},
          "repliedMark": false,
          "liked": false
        },
        {
          "user": {
            "locationInfo": null,
            "liveInfo": null,
            "userId": 448579154,
            "vipRights": null,
            "nickname": "是可爱多本人了",
            "userType": 0,
            "expertTags": null,
            "remarkName": null,
            "vipType": 0,
            "authStatus": 0,
            "avatarUrl": "https://p4.music.126.net/xlAFlqnJ-KAFa0kSma8x_A==/109951163990341960.jpg",
            "experts": null
          },
          "beReplied": [],
          "pendantData": null,
          "showFloorComment": null,
          "status": 0,
          "commentId": 1517027466,
          "content": "爱",
          "time": 1560068468302,
          "likedCount": 31,
          "expressionUrl": null,
          "commentLocationType": 0,
          "parentCommentId": 0,
          "decoration": {},
          "repliedMark": false,
          "liked": false
        },
        {
          "user": {
            "locationInfo": null,
            "liveInfo": null,
            "userId": 7519395,
            "vipRights": null,
            "nickname": "我就随便听听",
            "userType": 0,
            "expertTags": null,
            "remarkName": null,
            "vipType": 0,
            "authStatus": 0,
            "avatarUrl": "https://p3.music.126.net/DfO9Ofc1K3ZcIRYMvWuJtw==/18544363114259833.jpg",
            "experts": null
          },
          "beReplied": [],
          "pendantData": null,
          "showFloorComment": null,
          "status": 0,
          "commentId": 1517033807,
          "content": "不错",
          "time": 1560066528281,
          "likedCount": 19,
          "expressionUrl": null,
          "commentLocationType": 0,
          "parentCommentId": 0,
          "decoration": {},
          "repliedMark": false,
          "liked": false
        },
        {
          "user": {
            "locationInfo": null,
            "liveInfo": null,
            "userId": 68625035,
            "vipRights": null,
            "nickname": "N族人",
            "userType": 0,
            "expertTags": null,
            "remarkName": null,
            "vipType": 0,
            "authStatus": 0,
            "avatarUrl": "https://p4.music.126.net/pa2ImGti-5CS2BcTG8dBPw==/19028148230295733.jpg",
            "experts": null
          },
          "beReplied": [
            {
              "user": {
                "locationInfo": null,
                "liveInfo": null,
                "userId": 444558826,
                "vipRights": null,
                "nickname": "你要经常开心",
                "userType": 0,
                "expertTags": null,
                "remarkName": null,
                "vipType": 0,
                "authStatus": 0,
                "avatarUrl": "https://p3.music.126.net/Pd1doLZw5gzfI-sFb_1uow==/109951163944161149.jpg",
                "experts": null
              },
              "beRepliedCommentId": 1516951201,
              "content": "yes",
              "status": 0,
              "expressionUrl": null
            }
          ],
          "pendantData": null,
          "showFloorComment": null,
          "status": 0,
          "commentId": 1517019589,
          "content": "可以兄弟",
          "time": 1560064729770,
          "likedCount": 1,
          "expressionUrl": null,
          "commentLocationType": 0,
          "parentCommentId": 1477000405,
          "decoration": {},
          "repliedMark": false,
          "liked": false
        },
        {
          "user": {
            "locationInfo": null,
            "liveInfo": null,
            "userId": 1603861495,
            "vipRights": null,
            "nickname": "music_libra",
            "userType": 0,
            "expertTags": null,
            "remarkName": null,
            "vipType": 0,
            "authStatus": 0,
            "avatarUrl": "https://p4.music.126.net/ma8NC_MpYqC-dK_L81FWXQ==/109951163250233892.jpg",
            "experts": null
          },
          "beReplied": [],
          "pendantData": null,
          "showFloorComment": null,
          "status": 0,
          "commentId": 1516958472,
          "content": "今天再听这首歌，感触良多！",
          "time": 1560064336359,
          "likedCount": 170,
          "expressionUrl": null,
          "commentLocationType": 0,
          "parentCommentId": 0,
          "decoration": {},
          "repliedMark": false,
          "liked": false
        },
        {
          "user": {
            "locationInfo": null,
            "liveInfo": null,
            "userId": 1844662127,
            "vipRights": null,
            "nickname": "网黄1号",
            "userType": 0,
            "expertTags": null,
            "remarkName": null,
            "vipType": 0,
            "authStatus": 0,
            "avatarUrl": "https://p3.music.126.net/eaF898loDOXrLTbOugAlrw==/109951164128745851.jpg",
            "experts": null
          },
          "beReplied": [],
          "pendantData": null,
          "showFloorComment": null,
          "status": 0,
          "commentId": 1516988865,
          "content": "家驹是信仰☀",
          "time": 1560064119868,
          "likedCount": 26,
          "expressionUrl": null,
          "commentLocationType": 0,
          "parentCommentId": 0,
          "decoration": {},
          "repliedMark": false,
          "liked": false
        },
        {
          "user": {
            "locationInfo": null,
            "liveInfo": null,
            "userId": 384873266,
            "vipRights": null,
            "nickname": "queque404",
            "userType": 0,
            "expertTags": null,
            "remarkName": null,
            "vipType": 0,
            "authStatus": 0,
            "avatarUrl": "https://p3.music.126.net/XduhUsR7wee8RN_fbJp4gQ==/109951163905377306.jpg",
            "experts": null
          },
          "beReplied": [],
          "pendantData": null,
          "showFloorComment": null,
          "status": 0,
          "commentId": 1516967249,
          "content": "say no to",
          "time": 1560063994523,
          "likedCount": 71,
          "expressionUrl": null,
          "commentLocationType": 0,
          "parentCommentId": 0,
          "decoration": {},
          "repliedMark": false,
          "liked": false
        },
        {
          "user": {
            "locationInfo": null,
            "liveInfo": null,
            "userId": 1336489299,
            "vipRights": null,
            "nickname": "木树飞花",
            "userType": 0,
            "expertTags": null,
            "remarkName": null,
            "vipType": 0,
            "authStatus": 0,
            "avatarUrl": "https://p3.music.126.net/sOkvJKvAojxnB3m5X0rV6g==/109951163177057728.jpg",
            "experts": null
          },
          "beReplied": [],
          "pendantData": null,
          "showFloorComment": null,
          "status": 0,
          "commentId": 1516958316,
          "content": "(ง •̀_•́)ง",
          "time": 1560063762800,
          "likedCount": 19,
          "expressionUrl": null,
          "commentLocationType": 0,
          "parentCommentId": 0,
          "decoration": {},
          "repliedMark": false,
          "liked": false
        },
        {
          "user": {
            "locationInfo": null,
            "liveInfo": null,
            "userId": 1336489299,
            "vipRights": null,
            "nickname": "木树飞花",
            "userType": 0,
            "expertTags": null,
            "remarkName": null,
            "vipType": 0,
            "authStatus": 0,
            "avatarUrl": "https://p4.music.126.net/sOkvJKvAojxnB3m5X0rV6g==/109951163177057728.jpg",
            "experts": null
          },
          "beReplied": [
            {
              "user": {
                "locationInfo": null,
                "liveInfo": null,
                "userId": 57220980,
                "vipRights": null,
                "nickname": "黄秌",
                "userType": 0,
                "expertTags": null,
                "remarkName": null,
                "vipType": 0,
                "authStatus": 0,
                "avatarUrl": "https://p4.music.126.net/vwjUpL8kX25M2jTWAQnG4w==/18691697674124718.jpg",
                "experts": null
              },
              "beRepliedCommentId": 1516954860,
              "content": null,
              "status": -10,
              "expressionUrl": null
            }
          ],
          "pendantData": null,
          "showFloorComment": null,
          "status": 0,
          "commentId": 1516971072,
          "content": "我也",
          "time": 1560063697705,
          "likedCount": 1,
          "expressionUrl": null,
          "commentLocationType": 0,
          "parentCommentId": 1516954860,
          "decoration": {},
          "repliedMark": false,
          "liked": false
        }
      ]);
      setState(() {
        this.map['comments'] = comments;
      });
    });
  }
}