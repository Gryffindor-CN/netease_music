import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

const API_HOST = 'http://192.168.206.131:3000/';

class NeteaseRepository {
  static Future<dynamic> doLogin() async {
    try {
      var url =
          '${API_HOST}login/cellphone?phone=15088132591&password=jinshan711318220';
      Response response = await Dio().get(url);
      if (response.statusCode == 200) {
        var result = json.decode(response.toString())['account'];
        return result;
      }
    } catch (e) {
      print(e);
    }
  }

  // 刷新登录
  static Future<bool> refreshLogin() async {
    try {
      var url = '${API_HOST}login/refresh';
      Response response = await Dio().get(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List> getBanner() async {
    try {
      var url = '${API_HOST}banner';
      Response response = await Dio().get(url);
      if (response.statusCode == 200) {
        var result = json.decode(response.toString())['banners'];
        return result;
      } else {
        print("Request failed with status: ${response.statusCode}.");
      }
    } catch (e) {}
  }

  // 获取每日推荐歌单（需要登录）
  static Future<List> getRecommendResource() async {
    try {
      // var url =
      //     '${API_HOST}recommend/resource?timestamp=${DateTime.now().millisecondsSinceEpoch}';
      // Response response = await Dio().get(url);
      // if (response.statusCode == 200) {
      //   var result = json.decode(response.toString())['recommend'];
      //   return result;
      // } else {
      //   print("Request failed with status: ${response.statusCode}.");
      // }
      return [
        {
          "id": 2829733864,
          "type": 1,
          "name": "[睡眠伴侣] 送 你 一 颗 失 眠 特 效 药 ",
          "copywriter": "猜你喜欢",
          "picUrl":
              "https://p2.music.126.net/VIL3XL8rOsBsE_zjJz35vw==/109951164170679137.jpg",
          "playcount": 2110141,
          "createTime": 1559731708993,
          "creator": {
            "avatarImgId": 1420569024374784,
            "backgroundImgId": 2002210674180202,
            "detailDescription": "网易云音乐官方账号",
            "defaultAvatar": false,
            "expertTags": null,
            "djStatus": 10,
            "followed": false,
            "avatarImgIdStr": "1420569024374784",
            "remarkName": null,
            "mutual": false,
            "accountStatus": 0,
            "userId": 1,
            "vipType": 11,
            "province": 110000,
            "gender": 1,
            "avatarUrl":
                "https://p1.music.126.net/QWMV-Ru_6149AKe0mCBXKg==/1420569024374784.jpg",
            "authStatus": 1,
            "userType": 2,
            "nickname": "网易云音乐",
            "birthday": -2209017600000,
            "city": 110101,
            "backgroundImgIdStr": "2002210674180202",
            "backgroundUrl":
                "http://p1.music.126.net/pmHS4fcQtcNEGewNb5HRhg==/2002210674180202.jpg",
            "description": "网易云音乐官方账号",
            "signature":
                "网易云音乐是6亿人都在使用的音乐平台，致力于帮助用户发现音乐惊喜，帮助音乐人实现梦想。客服@云音乐客服 在线时间：9：00 - 24：00，如您在使用过程中遇到任何问题，欢迎私信咨询，我们会尽快回复。如果仍然不能解决您的问题，与活动相关的疑问请私信@云音乐客服",
            "authority": 3
          },
          "trackCount": 0,
          "userId": 1,
          "alg": "official_playlist_sceneRank"
        },
        {
          "id": 2426284427,
          "type": 1,
          "name": "粤语live | 不一样的感受",
          "copywriter": "根据你喜欢的单曲《约定(Live)》推荐",
          "picUrl":
              "https://p2.music.126.net/Csbpi5fVm62GUQL0jZdlUg==/109951163675632397.jpg",
          "playcount": 1602015,
          "createTime": 1537302229312,
          "creator": {
            "avatarImgId": 109951163865446140,
            "backgroundImgId": 109951163728373120,
            "detailDescription": "",
            "defaultAvatar": false,
            "expertTags": null,
            "djStatus": 0,
            "followed": false,
            "avatarImgIdStr": "109951163865446146",
            "remarkName": null,
            "mutual": false,
            "accountStatus": 0,
            "userId": 90738718,
            "vipType": 0,
            "province": 440000,
            "gender": 1,
            "avatarUrl":
                "https://p1.music.126.net/ycEdaWUM6yieXNWeQX58ng==/109951163865446146.jpg",
            "authStatus": 0,
            "userType": 0,
            "nickname": "云村废柴",
            "birthday": 974304000000,
            "city": 440500,
            "backgroundImgIdStr": "109951163728373116",
            "backgroundUrl":
                "http://p1.music.126.net/n_ioOuKhtKTvQ5C3c2faAQ==/109951163728373116.jpg",
            "description": "",
            "signature": "莫挨老子",
            "authority": 0
          },
          "trackCount": 234,
          "userId": 90738718,
          "alg": "itembased"
        },
        {
          "id": 773961621,
          "type": 1,
          "name": "华语 | 此生一定要去演唱会哭一次",
          "copywriter": "根据你喜欢的单曲《约定(Live)》推荐",
          "picUrl":
              "https://p2.music.126.net/cRs-VlNB2yPAikLMZrePNg==/109951163220857751.jpg",
          "playcount": 14493279,
          "createTime": 1498207860950,
          "creator": {
            "avatarImgId": 109951163730894260,
            "backgroundImgId": 109951163746253230,
            "detailDescription": "",
            "defaultAvatar": false,
            "expertTags": ["华语", "流行", "欧美"],
            "djStatus": 0,
            "followed": false,
            "avatarImgIdStr": "109951163730894261",
            "remarkName": null,
            "mutual": false,
            "accountStatus": 0,
            "userId": 44530116,
            "vipType": 11,
            "province": 1000000,
            "gender": 2,
            "avatarUrl":
                "https://p1.music.126.net/8Av2BvwfwvFqp0gPdQX2OA==/109951163730894261.jpg",
            "authStatus": 0,
            "userType": 200,
            "nickname": "名侦探-柯北",
            "birthday": 800985600000,
            "city": 1003000,
            "backgroundImgIdStr": "109951163746253239",
            "backgroundUrl":
                "http://p1.music.126.net/9hdQDtKsRMM1uCXIKO16Jw==/109951163746253239.jpg",
            "description": "",
            "signature": "微博：九亿吨少女心",
            "authority": 0
          },
          "trackCount": 141,
          "userId": 44530116,
          "alg": "itembased"
        },
        {
          "id": 715331683,
          "type": 1,
          "name": "电音环绕，游戏必备！",
          "copywriter": "根据你收藏的歌单《【纯音乐】伤心自己听着哭吧》推荐",
          "picUrl":
              "https://p2.music.126.net/i_h0jHGOd9E2iNG1Jm07VQ==/18974272160640848.jpg",
          "playcount": 31889846,
          "createTime": 1493708319185,
          "creator": {
            "avatarImgId": 18785156162275670,
            "backgroundImgId": 109951163053421520,
            "detailDescription": "",
            "defaultAvatar": false,
            "expertTags": null,
            "djStatus": 10,
            "followed": false,
            "avatarImgIdStr": "18785156162275671",
            "remarkName": null,
            "mutual": false,
            "accountStatus": 0,
            "userId": 54683451,
            "vipType": 11,
            "province": 1000000,
            "gender": 2,
            "avatarUrl":
                "https://p1.music.126.net/iifny2jjsoR612rk0eg0Vg==/18785156162275671.jpg",
            "authStatus": 0,
            "userType": 201,
            "nickname": "动漫唯美风",
            "birthday": 870624000000,
            "city": 1004400,
            "backgroundImgIdStr": "109951163053421521",
            "backgroundUrl":
                "http://p1.music.126.net/m9cthO-lgBsY-dAxJ79g7w==/109951163053421521.jpg",
            "description": "",
            "signature":
                "美国留学生，同名B站qq空间动漫唯美风，承接视频制作及推广服务，商业合作请私信，合作邮箱：dmwmf@qq.com 定期更新动漫音乐，欢迎关注！",
            "authority": 0
          },
          "trackCount": 31,
          "userId": 54683451,
          "alg": "itembased2"
        },
        {
          "id": 2006137660,
          "type": 1,
          "name": "找不到的爱情别找了，该来的总会来的",
          "copywriter": "根据你喜欢的单曲《我们》推荐",
          "picUrl":
              "https://p2.music.126.net/Nao53YLhWJqHvsjIo-OQsA==/109951163470519749.jpg",
          "playcount": 8750768,
          "createTime": 1512657840645,
          "creator": {
            "avatarImgId": 109951164004239600,
            "backgroundImgId": 109951164262870990,
            "detailDescription": "",
            "defaultAvatar": false,
            "expertTags": ["华语", "流行", "欧美"],
            "djStatus": 10,
            "followed": false,
            "avatarImgIdStr": "109951164004239601",
            "remarkName": null,
            "mutual": false,
            "accountStatus": 0,
            "userId": 368175037,
            "vipType": 0,
            "province": 120000,
            "gender": 1,
            "avatarUrl":
                "https://p1.music.126.net/BmPjMvqVk7EWc7SKHVS0fA==/109951164004239601.jpg",
            "authStatus": 0,
            "userType": 200,
            "nickname": "DJ顾念晨",
            "birthday": 828115200000,
            "city": 120101,
            "backgroundImgIdStr": "109951164262870989",
            "backgroundUrl":
                "http://p1.music.126.net/QZ44X5dU-R72l8-2gfXB6g==/109951164262870989.jpg",
            "description": "",
            "signature":
                "电台DJ！不是夜店DJ！\r私信有时间都会回复！别忘了关注我的电台嗷！\r联系我：Comeonzhiyuxi\n组队唠嗑：299182947\n文章推送：DJ顾念晨",
            "authority": 0
          },
          "trackCount": 41,
          "userId": 368175037,
          "alg": "itembased"
        },
        {
          "id": 133619338,
          "type": 1,
          "name": "叱咤樂壇 的流行-粵耳旋律",
          "copywriter": "根据你喜欢的单曲《野孩子》推荐",
          "picUrl":
              "https://p2.music.126.net/EyBv17NZqj8TdKOnalSSJg==/528865134534758.jpg",
          "playcount": 30064316,
          "createTime": 1448902052554,
          "creator": {
            "avatarImgId": 1421668538519848,
            "backgroundImgId": 109951163023716400,
            "detailDescription": "",
            "defaultAvatar": false,
            "expertTags": ["流行"],
            "djStatus": 0,
            "followed": false,
            "avatarImgIdStr": "1421668538519848",
            "remarkName": null,
            "mutual": false,
            "accountStatus": 0,
            "userId": 59836871,
            "vipType": 11,
            "province": 810000,
            "gender": 1,
            "avatarUrl":
                "https://p1.music.126.net/K9MgQDxz3l4Z81EqNkbUdQ==/1421668538519848.jpg",
            "authStatus": 0,
            "userType": 200,
            "nickname": "哥哥姓劉",
            "birthday": 470637497926,
            "city": 810100,
            "backgroundImgIdStr": "109951163023716400",
            "backgroundUrl":
                "http://p1.music.126.net/kaQy7kwWxykR_tjiqzq0yQ==/109951163023716400.jpg",
            "description": "",
            "signature": "用音符\"代替動作~ 用歌詞\"代替說話~ 讓音樂 \"觸動靈魂...",
            "authority": 0
          },
          "trackCount": 101,
          "userId": 59836871,
          "alg": "itembased"
        },
        {
          "id": 1990048628,
          "type": 1,
          "name": "粤语：这些年，你过得怎么样",
          "copywriter": "根据你喜欢的单曲《最冷一天》推荐",
          "picUrl":
              "https://p2.music.126.net/q4Xmzds7ZojMTtDPWCXU6A==/18669707442322855.jpg",
          "playcount": 3753516,
          "createTime": 1511589277451,
          "creator": {
            "avatarImgId": 109951164053623800,
            "backgroundImgId": 109951164053626320,
            "detailDescription": "",
            "defaultAvatar": false,
            "expertTags": ["华语", "流行"],
            "djStatus": 10,
            "followed": false,
            "avatarImgIdStr": "109951164053623813",
            "remarkName": null,
            "mutual": false,
            "accountStatus": 0,
            "userId": 326263822,
            "vipType": 0,
            "province": 1000000,
            "gender": 1,
            "avatarUrl":
                "https://p1.music.126.net/Ubt5ZyTS_ot_tamFwJkhbg==/109951164053623813.jpg",
            "authStatus": 0,
            "userType": 200,
            "nickname": "我-_就是我",
            "birthday": 902589206627,
            "city": 1004400,
            "backgroundImgIdStr": "109951164053626316",
            "backgroundUrl":
                "http://p1.music.126.net/Kk8cGq27CkqW6ohzy2HZDQ==/109951164053626316.jpg",
            "description": "",
            "signature": "爱听音乐的狗大叔。",
            "authority": 0
          },
          "trackCount": 53,
          "userId": 326263822,
          "alg": "itembased"
        }
      ];
    } catch (e) {
      print(e);
    }
  }

  // 获取每日推荐歌曲（需要登录）
  static Future<List> getRecommedSongs() async {
    try {
      // var url = '${API_HOST}recommend/songs';
      // Response response = await Dio().get(url);
      // if (response.statusCode == 200) {
      //   var result = json.decode(response.toString())['recommend'];
      //   return result;
      // } else {
      //   print("Request failed with status: ${response.statusCode}.");
      // }
      return [
        {
          "name": "你瞒我瞒",
          "id": 25718007,
          "position": 8,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7001,
          "disc": "1",
          "no": 8,
          "artists": [
            {
              "name": "陈柏宇",
              "id": 2127,
              "picId": 0,
              "img1v1Id": 0,
              "briefDesc": "",
              "picUrl":
                  "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
              "img1v1Url":
                  "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
              "albumSize": 0,
              "alias": [],
              "trans": "",
              "musicSize": 0,
              "topicPerson": 0
            }
          ],
          "album": {
            "name": "Can’t Be Half",
            "id": 2292012,
            "type": "专辑",
            "size": 11,
            "picId": 2225411534621328,
            "blurPicUrl":
                "http://p2.music.126.net/LGSZ3rGT8Ux1pYxcwxnR-g==/2225411534621328.jpg",
            "companyId": 0,
            "pic": 2225411534621328,
            "picUrl":
                "http://p2.music.126.net/LGSZ3rGT8Ux1pYxcwxnR-g==/2225411534621328.jpg",
            "publishTime": 1261065600007,
            "description": "",
            "tags": "",
            "company": "索尼音乐",
            "briefDesc": "",
            "artist": {
              "name": "",
              "id": 0,
              "picId": 0,
              "img1v1Id": 0,
              "briefDesc": "",
              "picUrl":
                  "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
              "img1v1Url":
                  "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
              "albumSize": 0,
              "alias": [],
              "trans": "",
              "musicSize": 0,
              "topicPerson": 0
            },
            "songs": [],
            "alias": [],
            "status": 1,
            "copyrightId": 5003,
            "commentThreadId": "R_AL_3_2292012",
            "artists": [
              {
                "name": "陈柏宇",
                "id": 2127,
                "picId": 0,
                "img1v1Id": 0,
                "briefDesc": "",
                "picUrl":
                    "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
                "img1v1Url":
                    "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
                "albumSize": 0,
                "alias": [],
                "trans": "",
                "musicSize": 0,
                "topicPerson": 0
              }
            ],
            "subType": "录音室版",
            "transName": null,
            "mark": 0
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 239000,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_25718007",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 1,
          "transName": null,
          "sign": null,
          "mark": 0,
          "rtype": 0,
          "rurl": null,
          "mvid": 36565,
          "bMusic": {
            "name": null,
            "id": 99210593,
            "size": 3826041,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 239000,
            "volumeDelta": -14600
          },
          "mp3Url": null,
          "hMusic": {
            "name": null,
            "id": 99210591,
            "size": 9565039,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 239000,
            "volumeDelta": -19200
          },
          "mMusic": {
            "name": null,
            "id": 99210592,
            "size": 5739040,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 239000,
            "volumeDelta": -16600
          },
          "lMusic": {
            "name": null,
            "id": 99210593,
            "size": 3826041,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 239000,
            "volumeDelta": -14600
          },
          "reason": "根据你可能喜欢的单曲 单车(Live)",
          "privilege": {
            "id": 25718007,
            "fee": 8,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 0,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 999000,
            "fl": 128000,
            "toast": false,
            "flag": 260,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "孤身",
          "id": 1365393542,
          "position": 0,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 0,
          "disc": "01",
          "no": 0,
          "artists": [
            {
              "name": "徐秉龙",
              "id": 1197168,
              "picId": 0,
              "img1v1Id": 0,
              "briefDesc": "",
              "picUrl":
                  "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
              "img1v1Url":
                  "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
              "albumSize": 0,
              "alias": [],
              "trans": "",
              "musicSize": 0,
              "topicPerson": 0
            }
          ],
          "album": {
            "name": "孤身",
            "id": 79130968,
            "type": "专辑",
            "size": 2,
            "picId": 109951164075300140,
            "blurPicUrl":
                "http://p1.music.126.net/yVmtE5RFcJ1fhv-ivuyuRw==/109951164075300143.jpg",
            "companyId": 0,
            "pic": 109951164075300140,
            "picUrl":
                "http://p1.music.126.net/yVmtE5RFcJ1fhv-ivuyuRw==/109951164075300143.jpg",
            "publishTime": 1557936000000,
            "description": "",
            "tags": "",
            "company": "",
            "briefDesc": "",
            "artist": {
              "name": "",
              "id": 0,
              "picId": 0,
              "img1v1Id": 0,
              "briefDesc": "",
              "picUrl":
                  "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
              "img1v1Url":
                  "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
              "albumSize": 0,
              "alias": [],
              "trans": "",
              "musicSize": 0,
              "topicPerson": 0
            },
            "songs": [],
            "alias": [],
            "status": 0,
            "copyrightId": -1,
            "commentThreadId": "R_AL_3_79130968",
            "artists": [
              {
                "name": "徐秉龙",
                "id": 1197168,
                "picId": 0,
                "img1v1Id": 0,
                "briefDesc": "",
                "picUrl":
                    "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
                "img1v1Url":
                    "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
                "albumSize": 0,
                "alias": [],
                "trans": "",
                "musicSize": 0,
                "topicPerson": 0
              }
            ],
            "subType": "录音室版",
            "transName": null,
            "mark": 0,
            "picId_str": "109951164075300143"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 211541,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_1365393542",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 0,
          "transName": null,
          "sign": null,
          "mark": 0,
          "bMusic": {
            "name": null,
            "id": 3767426185,
            "size": 3385773,
            "extension": "mp3",
            "sr": 48000,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 211541,
            "volumeDelta": -45401
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "mvid": 0,
          "hMusic": {
            "name": null,
            "id": 3767426183,
            "size": 8464365,
            "extension": "mp3",
            "sr": 48000,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 211541,
            "volumeDelta": -49744
          },
          "mMusic": {
            "name": null,
            "id": 3767426184,
            "size": 5078637,
            "extension": "mp3",
            "sr": 48000,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 211541,
            "volumeDelta": -47122
          },
          "lMusic": {
            "name": null,
            "id": 3767426185,
            "size": 3385773,
            "extension": "mp3",
            "sr": 48000,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 211541,
            "volumeDelta": -45401
          },
          "reason": "根据你可能喜欢的单曲 Always Online",
          "privilege": {
            "id": 1365393542,
            "fee": 8,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 0,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 999000,
            "fl": 128000,
            "toast": false,
            "flag": 64,
            "preSell": false
          },
          "alg": "endRecentSubRC"
        }
      ];
    } catch (e) {
      print(e);
    }
  }

  static Future<List> getSearchHot() async {
    try {
      var url = '${API_HOST}search/hot';
      Response response = await Dio().get(url);
      var hots = json.decode(response.toString())['result']['hots'];
      return hots;
    } catch (e) {
      print(e);
    }
  }

  static Future<List> getSearchSuggest(String keywords) async {
    var url = '${API_HOST}search/suggest?keywords=$keywords&type=mobile';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.toString())['result']['allMatch'];
      return result;
    } catch (e) {
      print(e);
    }
  }

  // 获取单曲
  static doSearchSingAlbum(String keyword) async {
    var url = '${API_HOST}search?keywords=$keyword&limit=5';
    try {
      Response response = await Dio().get(url);
      var songRes = json.decode(response.toString())['result']['songs'];
      return songRes;
    } catch (e) {
      print(e);
    }
  }

  // 获取歌单
  static doSearchPlaylist(String keyword) async {
    var url = '${API_HOST}search?keywords=$keyword&type=1000&limit=5';
    try {
      Response response = await Dio().get(url);
      var plays = json.decode(response.toString())['result']['playlists'];
      return plays;
    } catch (e) {
      print(e);
    }
  }

  // 获取单曲详情
  static getSongDetail(int id) async {
    var url = '${API_HOST}song/detail?ids=$id';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.toString());
      return result;
    } catch (e) {
      print(e);
    }
  }

  // 获取歌曲论数量
  static getSongComment(int id) async {
    var url = '${API_HOST}comment/music?id=$id';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.toString());
      return result;
    } catch (e) {
      print(e);
    }
  }

  // 获取歌曲播放url
  static getSongUrl(int id) async {
    var url =
        '${API_HOST}song/url?id=$id&timestamp=${DateTime.now().millisecondsSinceEpoch}';
    try {
      Response response = await Dio().get(url);
      var data = json.decode(response.toString())['data'][0];

      return data['url'];
    } catch (e) {
      print(e);
    }
  }

  // 获取所有歌曲
  static getSongs(String keyword, {int offset = 0}) async {
    var url = '${API_HOST}search?keywords=$keyword&offset=$offset';
    try {
      Response response = await Dio().get(url);
      var songRes = json.decode(response.toString())['result']['songs'];
      return songRes;
    } catch (e) {}
  }

  // 获取所有歌手
  static getArtists(String keyword, {int offset = 0}) async {
    var url = '${API_HOST}search?keywords=$keyword&type=100&offset=$offset';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.toString())['result'];

      return result;
    } catch (e) {}
  }

  // 获取所有视频
  static getVideos(String keyword, {int offset = 0}) async {
    var url =
        '${API_HOST}search?keywords=$keyword&limit=10&type=1014&offset=$offset';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.toString())['result'];

      return result;
    } catch (e) {}
  }

  // 获取所有歌单
  static getSearchPlaylist(String keyword) async {
    var url = '${API_HOST}search?keywords=$keyword&type=1000';
    try {
      Response response = await Dio().get(url);
      var plays = json.decode(response.toString())['result']['playlists'];
      return plays;
    } catch (e) {
      print(e);
    }
  }

  // 获取所有专辑
  static getSearchAlbum(String keyword) async {
    var url = '${API_HOST}search?keywords=$keyword&type=10';
    try {
      Response response = await Dio().get(url);
      var plays = json.decode(response.toString())['result']['albums'];

      return plays;
    } catch (e) {
      print(e);
    }
  }

  // 获取排行榜详情
  static getTopList(int idx) async {
    var url = '${API_HOST}top/list?idx=$idx';
    try {
      Response response = await Dio().get(url);

      var playlist = json.decode(response.toString())['playlist'];
      return playlist;
    } catch (e) {}
  }

  // 获取歌单详情
  static getPlaylistDetail(int id) async {
    var url = '${API_HOST}playlist/detail?id=$id';
    try {
      Response response = await Dio().get(url);

      var playlist = json.decode(response.toString())['playlist'];

      return playlist;
    } catch (e) {}
  }

  // 获取专辑详情
  static getAlbumDetail(int id) async {
    var url = '${API_HOST}album/detail/dynamic?id=$id';
    try {
      Response response = await Dio().get(url);

      var result = json.decode(response.toString());

      return result;
    } catch (e) {}
  }

  // 收藏/取消歌单
  static playlistSubscribe(bool t, int id) async {
    var url = '${API_HOST}playlist/subscribe?t=${t == true ? 1 : 2}&id=$id';
    try {
      Response response = await Dio().get(url);
      var code = json.decode(response.toString())['code'];
      return code;
    } catch (e) {
      print(e);
    }
  }

  // 获取歌手信息
  static getAritst(int id) async {
    var url = '${API_HOST}artists?id=$id';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.toString());

      return result;
    } catch (e) {}
  }

  // 收藏/取消歌手
  static subcribeAritst(bool t, int id) async {
    var url = '${API_HOST}artists/sub?id=$id&t=${t == true ? 1 : 2}';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.toString())['code'];

      return result;
    } catch (e) {}
  }

  // 歌手��辑
  static getAritstAlbums(int id, {int limit = 20, int offset = 0}) async {
    var url = '${API_HOST}artist/album?id=$id&limit=$limit&offset=$offset';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.toString())['hotAlbums'];

      return result;
    } catch (e) {}
  }

  // 歌手视频
  static getAritstVideo(String query, {int limit = 10, int offset = 0}) async {
    var url =
        '${API_HOST}search?keywords=$query&limit=$limit&offset=$offset&type=1014';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.toString())['result'];

      return result;
    } catch (e) {}
  }

  // 获取用户歌单
  static getUserPlaylist(int userId) async {
    var url = '${API_HOST}user/playlist?uid=1788319348';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.toString())['playlist'];
      return result;
    } catch (e) {}
  }
}
