import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

const API_HOST = 'http://192.168.206.133:3000/';

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
      //     '${API_HOST}recommend/resource';
      // Response response = await Dio().get(url);
      // if (response.statusCode == 200) {
      //   print(json.decode(response.toString())['recommend']);
      //   var result = json.decode(response.toString())['recommend'];
      //   return result;
      // } else {
      //   print("Request failed with status: ${response.statusCode}.");
      // }
      return [
        {
          "id": 2829807251,
          "type": 1,
          "name": "[我们出发吧] 让轻快旋律赶走起床气",
          "copywriter": "猜你喜欢",
          "picUrl":
              "https://p1.music.126.net/_mn6wZ4l8MNjra2_PI_xAA==/109951164252798682.jpg",
          "playcount": 780508,
          "createTime": 1559731890703,
          "creator": {
            "accountStatus": 0,
            "userId": 1,
            "vipType": 11,
            "province": 110000,
            "avatarUrl":
                "https://p1.music.126.net/QWMV-Ru_6149AKe0mCBXKg==/1420569024374784.jpg",
            "authStatus": 1,
            "userType": 2,
            "nickname": "网易云音乐",
            "gender": 1,
            "avatarImgIdStr": "1420569024374784",
            "description": "网易云音乐官方账号",
            "mutual": false,
            "backgroundImgIdStr": "2002210674180202",
            "birthday": -2209017600000,
            "city": 110101,
            "avatarImgId": 1420569024374784,
            "backgroundImgId": 2002210674180202,
            "detailDescription": "网易云音乐官方账号",
            "defaultAvatar": false,
            "expertTags": null,
            "djStatus": 10,
            "followed": false,
            "backgroundUrl":
                "http://p1.music.126.net/pmHS4fcQtcNEGewNb5HRhg==/2002210674180202.jpg",
            "remarkName": null,
            "signature":
                "网易云音乐是6亿人都在使用的音乐平台，致力于帮助用户发现音乐惊喜，帮助音乐人实现梦想。客服@云音乐客服 在线时间：9：00 - 24：00，如您在使用过程中遇到任何问题，欢迎私信咨询，我们会尽快回复。如果仍然不能解决您的问题，与活动相关的疑问请私信@云音乐客服",
            "authority": 3
          },
          "trackCount": 0,
          "userId": 1,
          "alg": "official_playlist_sceneRank"
        },
        {
          "id": 817020646,
          "type": 1,
          "name": "林俊杰【翻唱 单曲】合集",
          "copywriter": "根据你喜欢的艺人《林俊杰》推荐",
          "picUrl":
              "https://p1.music.126.net/eKzHIhf_t9JaEc4_8l9SLg==/18519074348616602.jpg",
          "playcount": 457147,
          "createTime": 1500471619415,
          "creator": {
            "accountStatus": 0,
            "userId": 293464128,
            "vipType": 0,
            "province": 110000,
            "avatarUrl":
                "https://p1.music.126.net/wPDBs3vW6yw9CxiOtK-qJw==/109951163519716263.jpg",
            "authStatus": 0,
            "userType": 0,
            "nickname": "小半大梦_",
            "gender": 2,
            "avatarImgIdStr": "109951163519716263",
            "description": "",
            "mutual": false,
            "backgroundImgIdStr": "109951163519713852",
            "birthday": 845196845983,
            "city": 110101,
            "avatarImgId": 109951163519716260,
            "backgroundImgId": 109951163519713860,
            "detailDescription": "",
            "defaultAvatar": false,
            "expertTags": null,
            "djStatus": 0,
            "followed": false,
            "backgroundUrl":
                "http://p1.music.126.net/TKD0_-D-dU0jt6YyzKmmIA==/109951163519713852.jpg",
            "remarkName": null,
            "signature": "# Success is The best Advantage",
            "authority": 0
          },
          "trackCount": 120,
          "userId": 293464128,
          "alg": "artistbased"
        },
        {
          "id": 131427673,
          "type": 1,
          "name": "林俊杰音乐全集",
          "copywriter": "根据你喜欢的艺人《林俊杰》推荐",
          "picUrl":
              "https://p1.music.126.net/kzv_c_BqM0vypbushDCsiw==/1421668546285801.jpg",
          "playcount": 3419510,
          "createTime": 1448436218432,
          "creator": {
            "accountStatus": 0,
            "userId": 95205291,
            "vipType": 0,
            "province": 320000,
            "avatarUrl":
                "https://p1.music.126.net/ekgInL8uLgUKXZYLTV4UOA==/109951162993337670.jpg",
            "authStatus": 0,
            "userType": 200,
            "nickname": "般蛋",
            "gender": 1,
            "avatarImgIdStr": "109951162993337670",
            "description": "",
            "mutual": false,
            "backgroundImgIdStr": "109951162846121403",
            "birthday": 784556335356,
            "city": 320100,
            "avatarImgId": 109951162993337660,
            "backgroundImgId": 109951162846121400,
            "detailDescription": "",
            "defaultAvatar": false,
            "expertTags": ["轻音乐"],
            "djStatus": 0,
            "followed": false,
            "backgroundUrl":
                "http://p1.music.126.net/YhsYqUgCG2lrZXrPHXWXug==/109951162846121403.jpg",
            "remarkName": null,
            "signature": "知行合一，止于至善。",
            "authority": 0
          },
          "trackCount": 242,
          "userId": 95205291,
          "alg": "artistbased"
        },
        {
          "id": 2031482474,
          "type": 1,
          "name": "『纯音乐』洗涤心灵的旋律",
          "copywriter": "根据你收藏的歌单《【纯音乐】伤心自己听着哭吧》推荐",
          "picUrl":
              "https://p1.music.126.net/3wKuxd8SFWFR3hbYFajF7w==/19034745300678805.jpg",
          "playcount": 922348,
          "createTime": 1514368341306,
          "creator": {
            "accountStatus": 0,
            "userId": 50255421,
            "vipType": 0,
            "province": 220000,
            "avatarUrl":
                "https://p1.music.126.net/sW2-Cq7hcQTp5wucuZjYJw==/109951163338523059.jpg",
            "authStatus": 0,
            "userType": 200,
            "nickname": "HUMAN00",
            "gender": 0,
            "avatarImgIdStr": "109951163338523059",
            "description": "",
            "mutual": false,
            "backgroundImgIdStr": "109951163601232926",
            "birthday": 976887166000,
            "city": 220200,
            "avatarImgId": 109951163338523060,
            "backgroundImgId": 109951163601232930,
            "detailDescription": "",
            "defaultAvatar": false,
            "expertTags": ["电子", "轻音乐", "欧美"],
            "djStatus": 10,
            "followed": false,
            "backgroundUrl":
                "http://p1.music.126.net/PUXTHVCPlIsoML6U0J8HNg==/109951163601232926.jpg",
            "remarkName": null,
            "signature": "标签：【听歌日常】【旋律控|电音控】【二次元】【骑士团】【喜欢星空】【很用心做歌单】【很荣幸被你喜欢】",
            "authority": 0
          },
          "trackCount": 87,
          "userId": 50255421,
          "alg": "itembased2"
        },
        {
          "id": 2308335502,
          "type": 1,
          "name": "30句陈奕迅让人感动的经典歌词",
          "copywriter": "根据你喜欢的艺人《陈奕迅》推荐",
          "picUrl":
              "https://p1.music.126.net/zSEIOagVXGpk-Lah6iRxMg==/109951163399630424.jpg",
          "playcount": 290294,
          "createTime": 1531154597571,
          "creator": {
            "accountStatus": 0,
            "userId": 321488475,
            "vipType": 11,
            "province": 320000,
            "avatarUrl":
                "https://p1.music.126.net/zGJ7wadxSIlSB5lhqzIteQ==/109951164189359377.jpg",
            "authStatus": 0,
            "userType": 200,
            "nickname": "柠檬木有枝",
            "gender": 1,
            "avatarImgIdStr": "109951164189359377",
            "description": "",
            "mutual": false,
            "backgroundImgIdStr": "109951164223749242",
            "birthday": 863712000000,
            "city": 320200,
            "avatarImgId": 109951164189359380,
            "backgroundImgId": 109951164223749250,
            "detailDescription": "",
            "defaultAvatar": false,
            "expertTags": ["华语", "流行"],
            "djStatus": 0,
            "followed": false,
            "backgroundUrl":
                "http://p1.music.126.net/5ZdzRSj-ppiZkpwaQMrlFA==/109951164223749242.jpg",
            "remarkName": null,
            "signature":
                "公众号：明鹊安枝（az05010516）\r可我又不能阻止你奔向比我更好的人吧\r（部分图片源自网络 侵联删）\r",
            "authority": 0
          },
          "trackCount": 30,
          "userId": 321488475,
          "alg": "artistbased"
        },
        {
          "id": 961246075,
          "type": 1,
          "name": "终于听懂每首情歌，却再也没有可以联系的人",
          "copywriter": "根据你喜欢的单曲《我们》推荐",
          "picUrl":
              "https://p1.music.126.net/qO5IXdtPmWIMTNbmXgxK8Q==/109951163058256684.jpg",
          "playcount": 27993100,
          "createTime": 1508207343113,
          "creator": {
            "accountStatus": 0,
            "userId": 368175037,
            "vipType": 0,
            "province": 120000,
            "avatarUrl":
                "https://p1.music.126.net/BmPjMvqVk7EWc7SKHVS0fA==/109951164004239601.jpg",
            "authStatus": 0,
            "userType": 200,
            "nickname": "DJ顾念晨",
            "gender": 1,
            "avatarImgIdStr": "109951164004239601",
            "description": "",
            "mutual": false,
            "backgroundImgIdStr": "109951164262870989",
            "birthday": 828115200000,
            "city": 120101,
            "avatarImgId": 109951164004239600,
            "backgroundImgId": 109951164262870990,
            "detailDescription": "",
            "defaultAvatar": false,
            "expertTags": ["华语", "流行", "欧美"],
            "djStatus": 10,
            "followed": false,
            "backgroundUrl":
                "http://p1.music.126.net/QZ44X5dU-R72l8-2gfXB6g==/109951164262870989.jpg",
            "remarkName": null,
            "signature":
                "电台DJ！不是夜店DJ！\r私信有时间都会回复！别忘了关注我的电台嗷！\r联系我：Comeonzhiyuxi\n组队唠嗑：299182947\n文章推送：DJ顾念晨",
            "authority": 0
          },
          "trackCount": 40,
          "userId": 368175037,
          "alg": "itembased"
        },
        {
          "id": 2727510486,
          "type": 1,
          "name": "独享音乐|耳机线是现代年轻人的输氧管",
          "copywriter": "根据你喜欢的单曲《淘汰》推荐",
          "picUrl":
              "https://p1.music.126.net/jXdGPYY4NpJS32dCqunozg==/109951163955385312.jpg",
          "playcount": 9318759,
          "createTime": 1553665772580,
          "creator": {
            "accountStatus": 0,
            "userId": 389547363,
            "vipType": 11,
            "province": 640000,
            "avatarUrl":
                "https://p1.music.126.net/0rYIgF7k7AgL6JzRa0HXXg==/109951164139576290.jpg",
            "authStatus": 0,
            "userType": 200,
            "nickname": "宁遇夏",
            "gender": 1,
            "avatarImgIdStr": "109951164139576290",
            "description": "",
            "mutual": false,
            "backgroundImgIdStr": "109951164151940061",
            "birthday": 730122657151,
            "city": 640100,
            "avatarImgId": 109951164139576290,
            "backgroundImgId": 109951164151940060,
            "detailDescription": "",
            "defaultAvatar": false,
            "expertTags": ["华语", "流行"],
            "djStatus": 10,
            "followed": false,
            "backgroundUrl":
                "http://p1.music.126.net/ZMfQvVbc8NmPUP3ImFwhIg==/109951164151940061.jpg",
            "remarkName": null,
            "signature": "承蒙厚爱 不负相遇",
            "authority": 0
          },
          "trackCount": 111,
          "userId": 389547363,
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
          "name": "飞女正传",
          "id": 316509,
          "position": 31,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7003,
          "disc": "1",
          "no": 31,
          "artists": [
            {
              "name": "杨千嬅",
              "id": 10204,
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
            "name": "千嬅盛放",
            "id": 31350,
            "type": "专辑",
            "size": 51,
            "picId": 109951163447787660,
            "blurPicUrl":
                "http://p2.music.126.net/cANzxO2ixBKq_DJhSPOQ9Q==/109951163447787666.jpg",
            "companyId": 0,
            "pic": 109951163447787660,
            "picUrl":
                "http://p2.music.126.net/cANzxO2ixBKq_DJhSPOQ9Q==/109951163447787666.jpg",
            "publishTime": 1259856000000,
            "description": "",
            "tags": "",
            "company": "正东唱片",
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
            "commentThreadId": "R_AL_3_31350",
            "artists": [
              {
                "name": "杨千嬅",
                "id": 10204,
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
            "mark": 0,
            "picId_str": "109951163447787666"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 250514,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "",
          "crbt": "456ec1e6ea336c62be116b56f79153eb",
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_316509",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 1,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 0,
          "hMusic": {
            "name": "飞女正传",
            "id": 10411842,
            "size": 10041902,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 250514,
            "volumeDelta": -3.32
          },
          "mMusic": {
            "name": "飞女正传",
            "id": 10411843,
            "size": 5036319,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 160000,
            "playTime": 250514,
            "volumeDelta": -2.9
          },
          "lMusic": {
            "name": "飞女正传",
            "id": 10411844,
            "size": 3033668,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 96000,
            "playTime": 250514,
            "volumeDelta": -2.92
          },
          "bMusic": {
            "name": "飞女正传",
            "id": 10411844,
            "size": 3033668,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 96000,
            "playTime": 250514,
            "volumeDelta": -2.92
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 承诺(香港版)",
          "privilege": {
            "id": 316509,
            "fee": 8,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 0,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 320000,
            "fl": 128000,
            "toast": false,
            "flag": 4,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "相爱很难(电影\"男人四十\"歌曲)",
          "id": 36861904,
          "position": 82,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7003,
          "disc": "05",
          "no": 16,
          "artists": [
            {
              "name": "梅艳芳",
              "id": 8918,
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
            {
              "name": "张学友",
              "id": 6460,
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
            "name": "Celebration 45th Anniversary 环球志101",
            "id": 3388880,
            "type": "专辑",
            "size": 93,
            "picId": 18285977881644564,
            "blurPicUrl":
                "http://p2.music.126.net/1xasMY2KvyFozt7Tvs0RCQ==/18285977881644564.jpg",
            "companyId": 0,
            "pic": 18285977881644564,
            "picUrl":
                "http://p2.music.126.net/1xasMY2KvyFozt7Tvs0RCQ==/18285977881644564.jpg",
            "publishTime": 1447776000007,
            "description": "",
            "tags": "",
            "company": "环球唱片",
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
            "status": 3,
            "copyrightId": 7003,
            "commentThreadId": "R_AL_3_3388880",
            "artists": [
              {
                "name": "群星",
                "id": 122455,
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
            "mark": 0,
            "picId_str": "18285977881644564"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 224992,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": null,
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_36861904",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 0,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 0,
          "hMusic": {
            "name": null,
            "id": 113081108,
            "size": 9001839,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 224992,
            "volumeDelta": -15000
          },
          "mMusic": {
            "name": null,
            "id": 113081109,
            "size": 5401120,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 224992,
            "volumeDelta": -12300
          },
          "lMusic": {
            "name": null,
            "id": 113081110,
            "size": 3600761,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 224992,
            "volumeDelta": -10700
          },
          "bMusic": {
            "name": null,
            "id": 113081110,
            "size": 3600761,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 224992,
            "volumeDelta": -10700
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 承诺(香港版)",
          "privilege": {
            "id": 36861904,
            "fee": 8,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 0,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 320000,
            "fl": 128000,
            "toast": false,
            "flag": 4,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "余味",
          "id": 1371094770,
          "position": 0,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 0,
          "disc": "01",
          "no": 1,
          "artists": [
            {
              "name": "林俊呈",
              "id": 30107224,
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
            "name": "余味",
            "id": 79704619,
            "type": "EP/Single",
            "size": 2,
            "picId": 109951164139612300,
            "blurPicUrl":
                "http://p2.music.126.net/evwv-kvCELn5yAMkT1PW3A==/109951164139612303.jpg",
            "companyId": 0,
            "pic": 109951164139612300,
            "picUrl":
                "http://p2.music.126.net/evwv-kvCELn5yAMkT1PW3A==/109951164139612303.jpg",
            "publishTime": 1560960000000,
            "description": "",
            "tags": "",
            "company": null,
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
            "status": 0,
            "copyrightId": 0,
            "commentThreadId": "R_AL_3_79704619",
            "artists": [
              {
                "name": "林俊呈",
                "id": 30107224,
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
            "mark": 0,
            "picId_str": "109951164139612303"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 221470,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_1371094770",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 0,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 0,
          "hMusic": {
            "name": null,
            "id": 3821363380,
            "size": 8861823,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 221470,
            "volumeDelta": -53617
          },
          "mMusic": {
            "name": null,
            "id": 3821363381,
            "size": 5317111,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 221470,
            "volumeDelta": -51032
          },
          "lMusic": {
            "name": null,
            "id": 3821363382,
            "size": 3544755,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 221470,
            "volumeDelta": -49317
          },
          "bMusic": {
            "name": null,
            "id": 3821363382,
            "size": 3544755,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 221470,
            "volumeDelta": -49317
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你喜欢的歌曲",
          "privilege": {
            "id": 1371094770,
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
          "alg": "HG3IT_1371094770"
        },
        {
          "name": "奇洛李维斯回信",
          "id": 307024,
          "position": 18,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7002,
          "disc": "1",
          "no": 19,
          "artists": [
            {
              "name": "薛凯琪",
              "id": 9944,
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
            "name": "\"F\" Best",
            "id": 30487,
            "type": "专辑",
            "size": 19,
            "picId": 53876069778085,
            "blurPicUrl":
                "http://p2.music.126.net/ubB6_3KMsJbqaKKpx4sebw==/53876069778085.jpg",
            "companyId": 0,
            "pic": 53876069778085,
            "picUrl":
                "http://p2.music.126.net/ubB6_3KMsJbqaKKpx4sebw==/53876069778085.jpg",
            "publishTime": 1180627200000,
            "description": "",
            "tags": "",
            "company": "华纳唱片",
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
            "status": 3,
            "copyrightId": 7002,
            "commentThreadId": "R_AL_3_30487",
            "artists": [
              {
                "name": "薛凯琪",
                "id": 9944,
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
          "duration": 243000,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_307024",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 1,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 0,
          "hMusic": {
            "name": "奇洛李维斯回信",
            "id": 20209073,
            "size": 9756446,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 243000,
            "volumeDelta": 0.0707991
          },
          "mMusic": {
            "name": "奇洛李维斯回信",
            "id": 20209074,
            "size": 4892969,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 160000,
            "playTime": 243000,
            "volumeDelta": 0.0369245
          },
          "lMusic": {
            "name": "奇洛李维斯回信",
            "id": 20209075,
            "size": 2947160,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 96000,
            "playTime": 243000,
            "volumeDelta": -0.000265076
          },
          "bMusic": {
            "name": "奇洛李维斯回信",
            "id": 20209075,
            "size": 2947160,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 96000,
            "playTime": 243000,
            "volumeDelta": -0.000265076
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 阿牛",
          "privilege": {
            "id": 307024,
            "fee": 8,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 0,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 320000,
            "fl": 128000,
            "toast": false,
            "flag": 256,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "爱的故事上集(Live)",
          "id": 188522,
          "position": 15,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7003,
          "disc": "2",
          "no": 6,
          "artists": [
            {
              "name": "张敬轩",
              "id": 6462,
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
            {
              "name": "孙耀威",
              "id": 4947,
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
            "name": "轩动心弦演唱会",
            "id": 19081,
            "type": "专辑",
            "size": 23,
            "picId": 669602581327766,
            "blurPicUrl":
                "http://p2.music.126.net/Qu_twnEbrZUAu7cwVcMbug==/669602581327766.jpg",
            "companyId": 0,
            "pic": 669602581327766,
            "picUrl":
                "http://p2.music.126.net/Qu_twnEbrZUAu7cwVcMbug==/669602581327766.jpg",
            "publishTime": 1274716800000,
            "description": "",
            "tags": "",
            "company": "环球唱片",
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
            "status": 3,
            "copyrightId": 7003,
            "commentThreadId": "R_AL_3_19081",
            "artists": [
              {
                "name": "张敬轩",
                "id": 6462,
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
            "subType": "现场版",
            "transName": null,
            "mark": 0
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 238000,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_188522",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 1,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 5308229,
          "hMusic": {
            "name": null,
            "id": 63795082,
            "size": 9530625,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 238000,
            "volumeDelta": -2
          },
          "mMusic": {
            "name": null,
            "id": 93598950,
            "size": 5718419,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 238000,
            "volumeDelta": -2
          },
          "lMusic": {
            "name": null,
            "id": 63795083,
            "size": 3812316,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 238000,
            "volumeDelta": -2
          },
          "bMusic": {
            "name": null,
            "id": 63795083,
            "size": 3812316,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 238000,
            "volumeDelta": -2
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 等(Live)",
          "privilege": {
            "id": 188522,
            "fee": 8,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 0,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 320000,
            "fl": 128000,
            "toast": false,
            "flag": 4,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "烂泥",
          "id": 5231283,
          "position": 13,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7002,
          "disc": "01",
          "no": 14,
          "artists": [
            {
              "name": "许志安",
              "id": 5787,
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
            "name": "大男人情歌",
            "id": 510645,
            "type": "专辑",
            "size": 42,
            "picId": 6658642417871083,
            "blurPicUrl":
                "http://p2.music.126.net/fUUsGYXs0-VehFtiS_0qFw==/6658642417871083.jpg",
            "companyId": 0,
            "pic": 6658642417871083,
            "picUrl":
                "http://p2.music.126.net/fUUsGYXs0-VehFtiS_0qFw==/6658642417871083.jpg",
            "publishTime": 1331136000000,
            "description": "",
            "tags": "",
            "company": "华纳音乐",
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
            "status": 3,
            "copyrightId": 7002,
            "commentThreadId": "R_AL_3_510645",
            "artists": [
              {
                "name": "群星",
                "id": 122455,
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
          "duration": 196000,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_5231283",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 2,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 0,
          "hMusic": {
            "name": null,
            "id": 74157812,
            "size": 7875439,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 196000,
            "volumeDelta": -15500
          },
          "mMusic": {
            "name": null,
            "id": 92577042,
            "size": 4725280,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 196000,
            "volumeDelta": -13000
          },
          "lMusic": {
            "name": null,
            "id": 74157813,
            "size": 3150201,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 196000,
            "volumeDelta": -11500
          },
          "bMusic": {
            "name": null,
            "id": 74157813,
            "size": 3150201,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 196000,
            "volumeDelta": -11500
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 最冷一天",
          "privilege": {
            "id": 5231283,
            "fee": 8,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 0,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 320000,
            "fl": 128000,
            "toast": false,
            "flag": 260,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "小城大事 (live)",
          "id": 187937,
          "position": 12,
          "alias": [],
          "status": 0,
          "fee": 0,
          "copyrightId": 5003,
          "disc": "1",
          "no": 12,
          "artists": [
            {
              "name": "张学友",
              "id": 6460,
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
            "name": "活出生命Live演唱会",
            "id": 19037,
            "type": "",
            "size": 25,
            "picId": 112150186034075,
            "blurPicUrl":
                "http://p2.music.126.net/ouTRvQM_RwU5uBtuWrXO7A==/112150186034075.jpg",
            "companyId": 0,
            "pic": 112150186034075,
            "picUrl":
                "http://p2.music.126.net/ouTRvQM_RwU5uBtuWrXO7A==/112150186034075.jpg",
            "publishTime": 1101830400000,
            "description": "",
            "tags": "",
            "company": "上华国际",
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
            "commentThreadId": "R_AL_3_19037",
            "artists": [
              {
                "name": "张学友",
                "id": 6460,
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
            "subType": "现场版",
            "transName": null,
            "mark": 0
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 230000,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "600902000005652181",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_187937",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 1,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 375525,
          "hMusic": {
            "name": null,
            "id": 63780404,
            "size": 9240147,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 230000,
            "volumeDelta": -22800
          },
          "mMusic": {
            "name": null,
            "id": 93726575,
            "size": 5544134,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 230000,
            "volumeDelta": -20200
          },
          "lMusic": {
            "name": null,
            "id": 63780405,
            "size": 3696128,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 230000,
            "volumeDelta": -18400
          },
          "bMusic": {
            "name": null,
            "id": 63780405,
            "size": 3696128,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 230000,
            "volumeDelta": -18400
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 约定(Live)",
          "privilege": {
            "id": 187937,
            "fee": 0,
            "payed": 0,
            "st": 0,
            "pl": 320000,
            "dl": 320000,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 320000,
            "fl": 999000,
            "toast": false,
            "flag": 128,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "光辉岁月",
          "id": 346576,
          "position": 6,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7003,
          "disc": "1",
          "no": 6,
          "artists": [
            {
              "name": "Beyond",
              "id": 11127,
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
            "name": "光辉岁月十五年",
            "id": 34147,
            "type": "专辑",
            "size": 13,
            "picId": 29686813951246,
            "blurPicUrl":
                "http://p2.music.126.net/JOJvZc_7SqQjKf8TktQ_bw==/29686813951246.jpg",
            "companyId": 0,
            "pic": 29686813951246,
            "picUrl":
                "http://p2.music.126.net/JOJvZc_7SqQjKf8TktQ_bw==/29686813951246.jpg",
            "publishTime": 930758400000,
            "description": "",
            "tags": "",
            "company": "华纳唱片",
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
            "commentThreadId": "R_AL_3_34147",
            "artists": [
              {
                "name": "Beyond",
                "id": 11127,
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
          "duration": 298000,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "600902000005267437",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_346576",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 1,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 28005,
          "hMusic": {
            "name": null,
            "id": 64641994,
            "size": 11957907,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 298000,
            "volumeDelta": -32900
          },
          "mMusic": {
            "name": null,
            "id": 93554847,
            "size": 7174782,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 298000,
            "volumeDelta": -30300
          },
          "lMusic": {
            "name": null,
            "id": 64641995,
            "size": 4783219,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 298000,
            "volumeDelta": -28599
          },
          "bMusic": {
            "name": null,
            "id": 64641995,
            "size": 4783219,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 298000,
            "volumeDelta": -28599
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 富士山下",
          "privilege": {
            "id": 346576,
            "fee": 8,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 0,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 320000,
            "fl": 128000,
            "toast": false,
            "flag": 4,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "一事无成",
          "id": 191560,
          "position": 1,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7002,
          "disc": "1",
          "no": 1,
          "artists": [
            {
              "name": "周柏豪",
              "id": 6479,
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
            {
              "name": "郑融",
              "id": 10580,
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
            "name": "Continue",
            "id": 19350,
            "type": "EP/Single",
            "size": 6,
            "picId": 18740076185809216,
            "blurPicUrl":
                "http://p2.music.126.net/LoBUS2EsreYr2s7cwMI_Yg==/18740076185809215.jpg",
            "companyId": 0,
            "pic": 18740076185809216,
            "picUrl":
                "http://p2.music.126.net/LoBUS2EsreYr2s7cwMI_Yg==/18740076185809215.jpg",
            "publishTime": 1219248000000,
            "description": "",
            "tags": "",
            "company": "华纳唱片",
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
            "copyrightId": 7002,
            "commentThreadId": "R_AL_3_19350",
            "artists": [
              {
                "name": "周柏豪",
                "id": 6479,
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
            "mark": 0,
            "picId_str": "18740076185809215"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 190000,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_191560",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 1,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 0,
          "hMusic": {
            "name": null,
            "id": 63816792,
            "size": 7640380,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 190000,
            "volumeDelta": -5000
          },
          "mMusic": {
            "name": null,
            "id": 93747411,
            "size": 4584262,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 190000,
            "volumeDelta": -2600
          },
          "lMusic": {
            "name": null,
            "id": 63816793,
            "size": 3056203,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 190000,
            "volumeDelta": -800
          },
          "bMusic": {
            "name": null,
            "id": 63816793,
            "size": 3056203,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 190000,
            "volumeDelta": -800
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 阿牛",
          "privilege": {
            "id": 191560,
            "fee": 8,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 0,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 320000,
            "fl": 128000,
            "toast": false,
            "flag": 256,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "消愁",
          "id": 569200213,
          "position": 10,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 755014,
          "disc": "2",
          "no": 4,
          "artists": [
            {
              "name": "毛不易",
              "id": 12138269,
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
            "name": "平凡的一天",
            "id": 39483040,
            "type": "专辑",
            "size": 26,
            "picId": 109951163350929740,
            "blurPicUrl":
                "http://p2.music.126.net/vmCcDvD1H04e9gm97xsCqg==/109951163350929740.jpg",
            "companyId": 0,
            "pic": 109951163350929740,
            "picUrl":
                "http://p2.music.126.net/vmCcDvD1H04e9gm97xsCqg==/109951163350929740.jpg",
            "publishTime": 1530547200007,
            "description": "",
            "tags": "",
            "company": "哇唧唧哇×智慧大狗",
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
            "status": 0,
            "copyrightId": 755014,
            "commentThreadId": "R_AL_3_39483040",
            "artists": [
              {
                "name": "毛不易",
                "id": 12138269,
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
            "mark": 0,
            "picId_str": "109951163350929740"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 261346,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": null,
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_569200213",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 2,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 5958062,
          "hMusic": {
            "name": null,
            "id": 1491137328,
            "size": 10456338,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 261346,
            "volumeDelta": -2
          },
          "mMusic": {
            "name": null,
            "id": 1491137329,
            "size": 6273820,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 261346,
            "volumeDelta": 0
          },
          "lMusic": {
            "name": null,
            "id": 1491137330,
            "size": 4182561,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 261346,
            "volumeDelta": -2
          },
          "bMusic": {
            "name": null,
            "id": 1491137330,
            "size": 4182561,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 261346,
            "volumeDelta": -2
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 阴天快乐",
          "privilege": {
            "id": 569200213,
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
            "flag": 68,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "一生中最爱",
          "id": 153784,
          "position": 1,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7003,
          "disc": "1",
          "no": 1,
          "artists": [
            {
              "name": "谭咏麟",
              "id": 5205,
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
            "name": "一生中最爱",
            "id": 15455,
            "type": "专辑",
            "size": 10,
            "picId": 41781441856503,
            "blurPicUrl":
                "http://p2.music.126.net/EDe8WuEF_RbxugBQJcofXQ==/41781441856503.jpg",
            "companyId": 0,
            "pic": 41781441856503,
            "picUrl":
                "http://p2.music.126.net/EDe8WuEF_RbxugBQJcofXQ==/41781441856503.jpg",
            "publishTime": 765129600000,
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
            "commentThreadId": "R_AL_3_15455",
            "artists": [
              {
                "name": "谭咏麟",
                "id": 5205,
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
          "duration": 264751,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_153784",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 1,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 0,
          "hMusic": {
            "name": "一生中最爱",
            "id": 10056068,
            "size": 10616702,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 264751,
            "volumeDelta": 0.638129
          },
          "mMusic": {
            "name": "一生中最爱",
            "id": 10056069,
            "size": 5326385,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 160000,
            "playTime": 264751,
            "volumeDelta": 0.343074
          },
          "lMusic": {
            "name": "一生中最爱",
            "id": 10056070,
            "size": 3209840,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 96000,
            "playTime": 264751,
            "volumeDelta": -0.000265076
          },
          "bMusic": {
            "name": "一生中最爱",
            "id": 10056070,
            "size": 3209840,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 96000,
            "playTime": 264751,
            "volumeDelta": -0.000265076
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 约定(Live)",
          "privilege": {
            "id": 153784,
            "fee": 8,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 0,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 320000,
            "fl": 128000,
            "toast": false,
            "flag": 4,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "你就不要想起我",
          "id": 28018075,
          "position": 7,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 677020,
          "disc": "1",
          "no": 7,
          "artists": [
            {
              "name": "田馥甄",
              "id": 9548,
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
            "name": "渺小",
            "id": 2704008,
            "type": "专辑",
            "size": 10,
            "picId": 109951163571315500,
            "blurPicUrl":
                "http://p2.music.126.net/aPnwHIJECLpQCoSV-qm_qA==/109951163571315498.jpg",
            "companyId": 0,
            "pic": 109951163571315500,
            "picUrl":
                "http://p2.music.126.net/aPnwHIJECLpQCoSV-qm_qA==/109951163571315498.jpg",
            "publishTime": 1384358400007,
            "description": "",
            "tags": "",
            "company": "华研唱片",
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
            "status": -1,
            "copyrightId": 0,
            "commentThreadId": "R_AL_3_2704008",
            "artists": [
              {
                "name": "田馥甄",
                "id": 9548,
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
            "mark": 0,
            "picId_str": "109951163571315498"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 280524,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_28018075",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 2,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 418026,
          "hMusic": {
            "name": null,
            "id": 1426734064,
            "size": 11223293,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 280524,
            "volumeDelta": -16300
          },
          "mMusic": {
            "name": null,
            "id": 1426734065,
            "size": 6733993,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 280524,
            "volumeDelta": -13700
          },
          "lMusic": {
            "name": null,
            "id": 1426734066,
            "size": 4489343,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 280524,
            "volumeDelta": -12100
          },
          "bMusic": {
            "name": null,
            "id": 1426734066,
            "size": 4489343,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 280524,
            "volumeDelta": -12100
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 阴天快乐",
          "privilege": {
            "id": 28018075,
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
            "flag": 68,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "习惯失恋 (Live In Hong Kong / 2015)",
          "id": 40140636,
          "position": 20,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7003,
          "disc": "1",
          "no": 20,
          "artists": [
            {
              "name": "容祖儿",
              "id": 9269,
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
            "name": "Joey Yung X Hacken Lee Concert 2015",
            "id": 3433455,
            "type": "",
            "size": 55,
            "picId": 109951163463758530,
            "blurPicUrl":
                "http://p2.music.126.net/wGhf8z-_BYki8uPBHmWgZA==/109951163463758536.jpg",
            "companyId": 0,
            "pic": 109951163463758530,
            "picUrl":
                "http://p2.music.126.net/wGhf8z-_BYki8uPBHmWgZA==/109951163463758536.jpg",
            "publishTime": 1450886400007,
            "description": "",
            "tags": "",
            "company": "环球唱片",
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
            "status": 3,
            "copyrightId": 7003,
            "commentThreadId": "R_AL_3_3433455",
            "artists": [
              {
                "name": "容祖儿",
                "id": 9269,
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
            "subType": "现场版",
            "transName": null,
            "mark": 0,
            "picId_str": "109951163463758536"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 240195,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": null,
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_40140636",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 1,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 0,
          "hMusic": {
            "name": null,
            "id": 118916050,
            "size": 9609969,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 240195,
            "volumeDelta": -2
          },
          "mMusic": {
            "name": null,
            "id": 118916051,
            "size": 5765999,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 240195,
            "volumeDelta": -2
          },
          "lMusic": {
            "name": null,
            "id": 118916052,
            "size": 3844013,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 240195,
            "volumeDelta": -2
          },
          "bMusic": {
            "name": null,
            "id": 118916052,
            "size": 3844013,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 240195,
            "volumeDelta": -2
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 等(Live)",
          "privilege": {
            "id": 40140636,
            "fee": 8,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 0,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 320000,
            "fl": 128000,
            "toast": false,
            "flag": 4,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "花火(Live)",
          "id": 210991,
          "position": 3,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7003,
          "disc": "1",
          "no": 3,
          "artists": [
            {
              "name": "陈慧娴",
              "id": 7225,
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
            "name": "活出生命 II 演唱会",
            "id": 21410,
            "type": "",
            "size": 27,
            "picId": 109951163066642560,
            "blurPicUrl":
                "http://p2.music.126.net/tLaXmJ_somBvqSvkqXuq4A==/109951163066642561.jpg",
            "companyId": 0,
            "pic": 109951163066642560,
            "picUrl":
                "http://p2.music.126.net/tLaXmJ_somBvqSvkqXuq4A==/109951163066642561.jpg",
            "publishTime": 1208275200000,
            "description": "",
            "tags": "",
            "company": "环球唱片",
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
            "status": 3,
            "copyrightId": 7003,
            "commentThreadId": "R_AL_3_21410",
            "artists": [
              {
                "name": "陈慧娴",
                "id": 7225,
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
            "subType": "现场版",
            "transName": null,
            "mark": 0,
            "picId_str": "109951163066642561"
          },
          "starred": false,
          "popularity": 95,
          "score": 95,
          "starredNum": 0,
          "duration": 186773,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_210991",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 1,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 0,
          "hMusic": {
            "name": null,
            "id": 100007389,
            "size": 7473153,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 186773,
            "volumeDelta": 4011
          },
          "mMusic": {
            "name": null,
            "id": 100007390,
            "size": 4483909,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 186773,
            "volumeDelta": 6364
          },
          "lMusic": {
            "name": null,
            "id": 100007391,
            "size": 2989287,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 186773,
            "volumeDelta": 9743
          },
          "bMusic": {
            "name": null,
            "id": 100007391,
            "size": 2989287,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 186773,
            "volumeDelta": 9743
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 等(Live)",
          "privilege": {
            "id": 210991,
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
            "flag": 4,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "她说",
          "id": 108242,
          "position": 1,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 14026,
          "disc": "1",
          "no": 1,
          "artists": [
            {
              "name": "林俊杰",
              "id": 3684,
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
            "name": "她说 概念自选辑",
            "id": 10755,
            "type": "专辑",
            "size": 14,
            "picId": 109951163071284930,
            "blurPicUrl":
                "http://p2.music.126.net/peLODpaxX1Hl4RWYKR-34Q==/109951163071284933.jpg",
            "companyId": 0,
            "pic": 109951163071284930,
            "picUrl":
                "http://p2.music.126.net/peLODpaxX1Hl4RWYKR-34Q==/109951163071284933.jpg",
            "publishTime": 1291737600000,
            "description": "",
            "tags": "",
            "company": "海蝶音乐",
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
            "copyrightId": 14026,
            "commentThreadId": "R_AL_3_10755",
            "artists": [
              {
                "name": "林俊杰",
                "id": 3684,
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
            "mark": 0,
            "picId_str": "109951163071284933"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 320000,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "600902000008745942",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_108242",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 1,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 28219,
          "hMusic": {
            "name": null,
            "id": 99153430,
            "size": 12824075,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 320000,
            "volumeDelta": -32500
          },
          "mMusic": {
            "name": null,
            "id": 99153431,
            "size": 7694462,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 320000,
            "volumeDelta": -29800
          },
          "lMusic": {
            "name": null,
            "id": 99153432,
            "size": 5129656,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 320000,
            "volumeDelta": -28100
          },
          "bMusic": {
            "name": null,
            "id": 99153432,
            "size": 5129656,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 320000,
            "volumeDelta": -28100
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 阴天快乐",
          "privilege": {
            "id": 108242,
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
            "flag": 0,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "年度之歌",
          "id": 308169,
          "position": 5,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7003,
          "disc": "1",
          "no": 5,
          "artists": [
            {
              "name": "谢安琪",
              "id": 9952,
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
            "name": "Yelling",
            "id": 30597,
            "type": "专辑",
            "size": 10,
            "picId": 109951164146248530,
            "blurPicUrl":
                "http://p2.music.126.net/SkSda5laDTH73h_a9ZYEig==/109951164146248533.jpg",
            "companyId": 0,
            "pic": 109951164146248530,
            "picUrl":
                "http://p2.music.126.net/SkSda5laDTH73h_a9ZYEig==/109951164146248533.jpg",
            "publishTime": 1237392000000,
            "description": "",
            "tags": "",
            "company": "正东唱片",
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
            "status": 3,
            "copyrightId": 7003,
            "commentThreadId": "R_AL_3_30597",
            "artists": [
              {
                "name": "谢安琪",
                "id": 9952,
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
            "mark": 0,
            "picId_str": "109951164146248533"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 240000,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "600902000006802093",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_308169",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 1,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 325145,
          "hMusic": {
            "name": null,
            "id": 64671932,
            "size": 9628819,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 240000,
            "volumeDelta": 1064
          },
          "mMusic": {
            "name": null,
            "id": 93721196,
            "size": 5777325,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 240000,
            "volumeDelta": -2
          },
          "lMusic": {
            "name": null,
            "id": 64671933,
            "size": 3851578,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 240000,
            "volumeDelta": 1659
          },
          "bMusic": {
            "name": null,
            "id": 64671933,
            "size": 3851578,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 240000,
            "volumeDelta": 1659
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 陀飞轮",
          "privilege": {
            "id": 308169,
            "fee": 8,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 0,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 320000,
            "fl": 128000,
            "toast": false,
            "flag": 4,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "That Girl",
          "id": 440208476,
          "position": 13,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7001,
          "disc": "1",
          "no": 13,
          "artists": [
            {
              "name": "Olly Murs",
              "id": 41034,
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
            "name": "24 HRS (Deluxe)",
            "id": 34970031,
            "type": "EP/Single",
            "size": 16,
            "picId": 18259589602949148,
            "blurPicUrl":
                "http://p2.music.126.net/5HEwV-KwHoazXJ2CAHy1XA==/18259589602949147.jpg",
            "companyId": 0,
            "pic": 18259589602949148,
            "picUrl":
                "http://p2.music.126.net/5HEwV-KwHoazXJ2CAHy1XA==/18259589602949147.jpg",
            "publishTime": 1478793600000,
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
            "status": 3,
            "copyrightId": 7001,
            "commentThreadId": "R_AL_3_34970031",
            "artists": [
              {
                "name": "Olly Murs",
                "id": 41034,
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
            "mark": 0,
            "picId_str": "18259589602949147"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 176746,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": null,
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_440208476",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 2,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 10862947,
          "hMusic": {
            "name": null,
            "id": 1256045774,
            "size": 7072958,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 176746,
            "volumeDelta": -24800
          },
          "mMusic": {
            "name": null,
            "id": 1256045775,
            "size": 4243792,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 176746,
            "volumeDelta": -22100
          },
          "lMusic": {
            "name": null,
            "id": 1256045776,
            "size": 2829209,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 176746,
            "volumeDelta": -20600
          },
          "bMusic": {
            "name": null,
            "id": 1256045776,
            "size": 2829209,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 176746,
            "volumeDelta": -20600
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 后来",
          "privilege": {
            "id": 440208476,
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
          "alg": "endRecentSubRC"
        },
        {
          "name": "妳太善良",
          "id": 26467599,
          "position": 1,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 1416248,
          "disc": "1",
          "no": 1,
          "artists": [
            {
              "name": "张智霖",
              "id": 6487,
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
            "name": "I AM CHILAM",
            "id": 2504696,
            "type": "专辑",
            "size": 18,
            "picId": 109951164078534560,
            "blurPicUrl":
                "http://p2.music.126.net/3HDF6C-N8gaKrVfIyaRT2w==/109951164078534563.jpg",
            "companyId": 0,
            "pic": 109951164078534560,
            "picUrl":
                "http://p2.music.126.net/3HDF6C-N8gaKrVfIyaRT2w==/109951164078534563.jpg",
            "publishTime": 1259510400000,
            "description": "",
            "tags": "",
            "company": "金力企业有限公司",
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
            "copyrightId": 1416248,
            "commentThreadId": "R_AL_3_2504696",
            "artists": [
              {
                "name": "张智霖",
                "id": 6487,
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
            "mark": 0,
            "picId_str": "109951164078534563"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 224346,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_26467599",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 2,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 0,
          "hMusic": {
            "name": null,
            "id": 3769135404,
            "size": 8976762,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 224346,
            "volumeDelta": -60256
          },
          "mMusic": {
            "name": null,
            "id": 3769135405,
            "size": 5386075,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 224346,
            "volumeDelta": -57667
          },
          "lMusic": {
            "name": null,
            "id": 3769135406,
            "size": 3590731,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 224346,
            "volumeDelta": -56077
          },
          "bMusic": {
            "name": null,
            "id": 3769135406,
            "size": 3590731,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 224346,
            "volumeDelta": -56077
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 最冷一天",
          "privilege": {
            "id": 26467599,
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
            "flag": 4,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "残忍",
          "id": 244126,
          "position": 3,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7003,
          "disc": "1",
          "no": 3,
          "artists": [
            {
              "name": "黄伊汶",
              "id": 7935,
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
            "name": "GOOD SHOW",
            "id": 24412,
            "type": "EP/Single",
            "size": 5,
            "picId": 80264348840408,
            "blurPicUrl":
                "http://p2.music.126.net/A0OFK6cYbA4VEz7zNzCWqw==/80264348840408.jpg",
            "companyId": 0,
            "pic": 80264348840408,
            "picUrl":
                "http://p2.music.126.net/A0OFK6cYbA4VEz7zNzCWqw==/80264348840408.jpg",
            "publishTime": 1096588800000,
            "description": "",
            "tags": "",
            "company": "环球唱片",
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
            "status": 3,
            "copyrightId": 7003,
            "commentThreadId": "R_AL_3_24412",
            "artists": [
              {
                "name": "黄伊汶",
                "id": 7935,
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
          "duration": 243435,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_244126",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 1,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 0,
          "hMusic": {
            "name": "残忍",
            "id": 31251792,
            "size": 5872319,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 243435,
            "volumeDelta": -2.19
          },
          "mMusic": {
            "name": "残忍",
            "id": 31251790,
            "size": 4907955,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 160000,
            "playTime": 243435,
            "volumeDelta": -1.75
          },
          "lMusic": {
            "name": "残忍",
            "id": 31251791,
            "size": 2960056,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 96000,
            "playTime": 243435,
            "volumeDelta": -1.77
          },
          "bMusic": {
            "name": "残忍",
            "id": 31251791,
            "size": 2960056,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 96000,
            "playTime": 243435,
            "volumeDelta": -1.77
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 最冷一天",
          "privilege": {
            "id": 244126,
            "fee": 8,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 0,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 128000,
            "fl": 128000,
            "toast": false,
            "flag": 4,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "过客",
          "id": 445665094,
          "position": 1,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 1416070,
          "disc": "1",
          "no": 1,
          "artists": [
            {
              "name": "周思涵",
              "id": 12292708,
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
            "name": "过客",
            "id": 35040037,
            "type": "EP/Single",
            "size": 2,
            "picId": 18770862510931330,
            "blurPicUrl":
                "http://p1.music.126.net/ai-tIcR1c69_tXCoDy8hyA==/18770862510931326.jpg",
            "companyId": 0,
            "pic": 18770862510931330,
            "picUrl":
                "http://p1.music.126.net/ai-tIcR1c69_tXCoDy8hyA==/18770862510931326.jpg",
            "publishTime": 1481126400007,
            "description": "",
            "tags": "",
            "company": "千和世纪",
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
            "copyrightId": 30002,
            "commentThreadId": "R_AL_3_35040037",
            "artists": [
              {
                "name": "周思涵",
                "id": 12292708,
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
            "picId_str": "18770862510931326"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 270000,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": null,
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_445665094",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 0,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 0,
          "hMusic": {
            "name": null,
            "id": 1258876216,
            "size": 10802199,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 270000,
            "volumeDelta": -16300
          },
          "mMusic": {
            "name": null,
            "id": 1258876217,
            "size": 6481337,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 270000,
            "volumeDelta": -13800
          },
          "lMusic": {
            "name": null,
            "id": 1258876218,
            "size": 4320906,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 270000,
            "volumeDelta": -12200
          },
          "bMusic": {
            "name": null,
            "id": 1258876218,
            "size": 4320906,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 270000,
            "volumeDelta": -12200
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 淘汰",
          "privilege": {
            "id": 445665094,
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
            "flag": 0,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "All Falls Down",
          "id": 515453363,
          "position": 1,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7001,
          "disc": "1",
          "no": 1,
          "artists": [
            {
              "name": "Alan Walker",
              "id": 1045123,
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
            {
              "name": "Noah Cyrus",
              "id": 12175271,
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
            {
              "name": "Digital Farm Animals",
              "id": 840929,
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
            "name": "All Falls Down",
            "id": 36682047,
            "type": "EP/Single",
            "size": 1,
            "picId": 18850027346628136,
            "blurPicUrl":
                "http://p1.music.126.net/rTb28CZeLWxIRuSlJWkPLQ==/18850027346628137.jpg",
            "companyId": 0,
            "pic": 18850027346628136,
            "picUrl":
                "http://p1.music.126.net/rTb28CZeLWxIRuSlJWkPLQ==/18850027346628137.jpg",
            "publishTime": 1509062400000,
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
            "status": 3,
            "copyrightId": 7001,
            "commentThreadId": "R_AL_3_36682047",
            "artists": [
              {
                "name": "Alan Walker",
                "id": 1045123,
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
              {
                "name": "Noah Cyrus",
                "id": 12175271,
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
              {
                "name": "Digital Farm Animals",
                "id": 840929,
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
            "picId_str": "18850027346628137"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 199111,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": null,
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_515453363",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 0,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 5694021,
          "hMusic": {
            "name": null,
            "id": 1379806671,
            "size": 7967391,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 199111,
            "volumeDelta": -35300
          },
          "mMusic": {
            "name": null,
            "id": 1379806672,
            "size": 4780452,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 199111,
            "volumeDelta": -33000
          },
          "lMusic": {
            "name": null,
            "id": 1379806673,
            "size": 3186982,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 199111,
            "volumeDelta": -31500
          },
          "bMusic": {
            "name": null,
            "id": 1379806673,
            "size": 3186982,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 199111,
            "volumeDelta": -31500
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 Always Online",
          "privilege": {
            "id": 515453363,
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
          "alg": "endRecentSubRC"
        },
        {
          "name": "再也没有",
          "id": 480580003,
          "position": 1,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 1374819,
          "disc": "1",
          "no": 0,
          "artists": [
            {
              "name": "永彬Ryan.B",
              "id": 12448205,
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
            {
              "name": "AY楊佬叁",
              "id": 12258420,
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
            "name": "再也没有",
            "id": 35559257,
            "type": "EP/Single",
            "size": 1,
            "picId": 18771962022944664,
            "blurPicUrl":
                "http://p1.music.126.net/B7MRU9cieODaInnwzyLwYQ==/18771962022944662.jpg",
            "companyId": 0,
            "pic": 18771962022944664,
            "picUrl":
                "http://p1.music.126.net/B7MRU9cieODaInnwzyLwYQ==/18771962022944662.jpg",
            "publishTime": 1496160000007,
            "description": "",
            "tags": "",
            "company": "独一不二",
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
            "copyrightId": 502010,
            "commentThreadId": "R_AL_3_35559257",
            "artists": [
              {
                "name": "永彬Ryan.B",
                "id": 12448205,
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
            "picId_str": "18771962022944662"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 212540,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": null,
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_480580003",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 0,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 5843664,
          "hMusic": {
            "name": null,
            "id": 1317247190,
            "size": 8504468,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 212540,
            "volumeDelta": -25300
          },
          "mMusic": {
            "name": null,
            "id": 1317247191,
            "size": 5102698,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 212540,
            "volumeDelta": -22700
          },
          "lMusic": {
            "name": null,
            "id": 1317247192,
            "size": 3401813,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 212540,
            "volumeDelta": -21099
          },
          "bMusic": {
            "name": null,
            "id": 1317247192,
            "size": 3401813,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 212540,
            "volumeDelta": -21099
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 好久不见",
          "privilege": {
            "id": 480580003,
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
          "alg": "itembased"
        },
        {
          "name": "浪子回头",
          "id": 516728102,
          "position": 6,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 653015,
          "disc": "1",
          "no": 6,
          "artists": [
            {
              "name": "茄子蛋",
              "id": 1039873,
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
            "name": "卡通人物",
            "id": 36693907,
            "type": "专辑",
            "size": 10,
            "picId": 109951163333175420,
            "blurPicUrl":
                "http://p1.music.126.net/emWwYFceRZ2plNWgnGUDfg==/109951163333175426.jpg",
            "companyId": 0,
            "pic": 109951163333175420,
            "picUrl":
                "http://p1.music.126.net/emWwYFceRZ2plNWgnGUDfg==/109951163333175426.jpg",
            "publishTime": 1509753600000,
            "description": "",
            "tags": "",
            "company": "茄子蛋EggPlantEgg",
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
            "copyrightId": 653015,
            "commentThreadId": "R_AL_3_36693907",
            "artists": [
              {
                "name": "茄子蛋",
                "id": 1039873,
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
            "picId_str": "109951163333175426"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 259373,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": null,
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_516728102",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 0,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 10729090,
          "hMusic": {
            "name": null,
            "id": 1496889633,
            "size": 10377970,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 259373,
            "volumeDelta": -2
          },
          "mMusic": {
            "name": null,
            "id": 1496889634,
            "size": 6226800,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 259373,
            "volumeDelta": -2
          },
          "lMusic": {
            "name": null,
            "id": 1496889635,
            "size": 4151214,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 259373,
            "volumeDelta": -2
          },
          "bMusic": {
            "name": null,
            "id": 1496889635,
            "size": 4151214,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 259373,
            "volumeDelta": -2
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 十年(Live)",
          "privilege": {
            "id": 516728102,
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
            "flag": 256,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "讲真的",
          "id": 30987293,
          "position": 1,
          "alias": [],
          "status": 0,
          "fee": 0,
          "copyrightId": 1382818,
          "disc": "1",
          "no": 2,
          "artists": [
            {
              "name": "曾惜",
              "id": 1053026,
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
            "name": "不要你为难",
            "id": 3109051,
            "type": "专辑",
            "size": 8,
            "picId": 2885118513459477,
            "blurPicUrl":
                "http://p1.music.126.net/cd9tDyVMq7zzYFbkr0gZcw==/2885118513459477.jpg",
            "companyId": 0,
            "pic": 2885118513459477,
            "picUrl":
                "http://p1.music.126.net/cd9tDyVMq7zzYFbkr0gZcw==/2885118513459477.jpg",
            "publishTime": 1426089600007,
            "description": "",
            "tags": "",
            "company": "花生米(北京)音乐文化有限公司",
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
            "copyrightId": 0,
            "commentThreadId": "R_AL_3_3109051",
            "artists": [
              {
                "name": "曾惜",
                "id": 1053026,
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
            "mark": 0
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 238000,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": null,
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_30987293",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 2,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 0,
          "hMusic": {
            "name": null,
            "id": 91538758,
            "size": 9561958,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 238000,
            "volumeDelta": -9200
          },
          "mMusic": {
            "name": null,
            "id": 91538759,
            "size": 5737213,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 238000,
            "volumeDelta": -6800
          },
          "lMusic": {
            "name": null,
            "id": 91538760,
            "size": 3824841,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 238000,
            "volumeDelta": -5700
          },
          "bMusic": {
            "name": null,
            "id": 91538760,
            "size": 3824841,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 238000,
            "volumeDelta": -5700
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 后来",
          "privilege": {
            "id": 30987293,
            "fee": 0,
            "payed": 0,
            "st": 0,
            "pl": 320000,
            "dl": 320000,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 320000,
            "fl": 999000,
            "toast": false,
            "flag": 256,
            "preSell": false
          },
          "alg": "endRecentSubRC"
        },
        {
          "name": "孤雏",
          "id": 421486605,
          "position": 1,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7003,
          "disc": "1",
          "no": 1,
          "artists": [
            {
              "name": "AGA",
              "id": 768208,
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
            "name": "孤雏",
            "id": 34732928,
            "type": "EP/Single",
            "size": 1,
            "picId": 18302470556355852,
            "blurPicUrl":
                "http://p1.music.126.net/1plA3qURt0VPElgnaTRg2w==/18302470556355853.jpg",
            "companyId": 0,
            "pic": 18302470556355852,
            "picUrl":
                "http://p1.music.126.net/1plA3qURt0VPElgnaTRg2w==/18302470556355853.jpg",
            "publishTime": 1468944000007,
            "description": "",
            "tags": "",
            "company": "环球唱片",
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
            "status": 3,
            "copyrightId": 7003,
            "commentThreadId": "R_AL_3_34732928",
            "artists": [
              {
                "name": "AGA",
                "id": 768208,
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
            "picId_str": "18302470556355853"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 293381,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": null,
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_421486605",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 1,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 5570570,
          "hMusic": {
            "name": null,
            "id": 1220443532,
            "size": 11736338,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 293381,
            "volumeDelta": -3.2
          },
          "mMusic": {
            "name": null,
            "id": 1220443533,
            "size": 5868192,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 160000,
            "playTime": 293381,
            "volumeDelta": -2.76
          },
          "lMusic": {
            "name": null,
            "id": 1220443534,
            "size": 3520933,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 96000,
            "playTime": 293381,
            "volumeDelta": -2.8
          },
          "bMusic": {
            "name": null,
            "id": 1220443534,
            "size": 3520933,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 96000,
            "playTime": 293381,
            "volumeDelta": -2.8
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 陀飞轮",
          "privilege": {
            "id": 421486605,
            "fee": 8,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 0,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 320000,
            "fl": 128000,
            "toast": false,
            "flag": 4,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "成都",
          "id": 436514312,
          "position": 1,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 1400821,
          "disc": "1",
          "no": 1,
          "artists": [
            {
              "name": "赵雷",
              "id": 6731,
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
            "name": "成都",
            "id": 34930257,
            "type": "EP/Single",
            "size": 1,
            "picId": 2946691234868155,
            "blurPicUrl":
                "http://p1.music.126.net/34YW1QtKxJ_3YnX9ZzKhzw==/2946691234868155.jpg",
            "companyId": 0,
            "pic": 2946691234868155,
            "picUrl":
                "http://p1.music.126.net/34YW1QtKxJ_3YnX9ZzKhzw==/2946691234868155.jpg",
            "publishTime": 1477238400007,
            "description": "",
            "tags": "",
            "company": "StreetVoice",
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
            "copyrightId": 36016,
            "commentThreadId": "R_AL_3_34930257",
            "artists": [
              {
                "name": "赵雷",
                "id": 6731,
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
            "mark": 0
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 328155,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": null,
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_436514312",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 2,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 5619601,
          "hMusic": {
            "name": null,
            "id": 1245191504,
            "size": 13139636,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 328155,
            "volumeDelta": -19400
          },
          "mMusic": {
            "name": null,
            "id": 1245191505,
            "size": 7883799,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 328155,
            "volumeDelta": -16700
          },
          "lMusic": {
            "name": null,
            "id": 1245191506,
            "size": 5255880,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 328155,
            "volumeDelta": -15100
          },
          "bMusic": {
            "name": null,
            "id": 1245191506,
            "size": 5255880,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 328155,
            "volumeDelta": -15100
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 十年(Live)",
          "privilege": {
            "id": 436514312,
            "fee": 8,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 0,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 320000,
            "fl": 128000,
            "toast": false,
            "flag": 256,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "稳稳的幸福 (live)",
          "id": 29932463,
          "position": 1,
          "alias": ["电影《越来越好之村晚》主题曲"],
          "status": 0,
          "fee": 0,
          "copyrightId": 0,
          "disc": "1",
          "no": 25,
          "artists": [
            {
              "name": "陈奕迅",
              "id": 2116,
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
            "name": "2015江苏卫视新年演唱会",
            "id": 3087145,
            "type": "",
            "size": 33,
            "picId": 3245758328218726,
            "blurPicUrl":
                "http://p1.music.126.net/RJoUUM_dSGSwwPzWaE041g==/3245758328218726.jpg",
            "companyId": 0,
            "pic": 3245758328218726,
            "picUrl":
                "http://p1.music.126.net/RJoUUM_dSGSwwPzWaE041g==/3245758328218726.jpg",
            "publishTime": 1420041600007,
            "description": "",
            "tags": "",
            "company": "江苏卫视",
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
            "copyrightId": 0,
            "commentThreadId": "R_AL_3_3087145",
            "artists": [
              {
                "name": "群星",
                "id": 122455,
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
            "subType": "现场版",
            "transName": null,
            "mark": 0
          },
          "starred": false,
          "popularity": 95,
          "score": 95,
          "starredNum": 0,
          "duration": 214000,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": null,
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_29932463",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 2,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 0,
          "hMusic": null,
          "mMusic": null,
          "lMusic": {
            "name": null,
            "id": 65181126,
            "size": 3435367,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 214000,
            "volumeDelta": 6535
          },
          "bMusic": {
            "name": null,
            "id": 65181126,
            "size": 3435367,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 214000,
            "volumeDelta": 6535
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 十年(Live)",
          "privilege": {
            "id": 29932463,
            "fee": 0,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 128000,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 128000,
            "fl": 999000,
            "toast": false,
            "flag": 128,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "漂洋过海来看你",
          "id": 30903117,
          "position": 1,
          "alias": [],
          "status": 0,
          "fee": 0,
          "copyrightId": 0,
          "disc": "1",
          "no": 1,
          "artists": [
            {
              "name": "周深",
              "id": 1030001,
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
            "name": "漂洋过海来看你",
            "id": 3106026,
            "type": "EP/Single",
            "size": 1,
            "picId": 7697680906845029,
            "blurPicUrl":
                "http://p1.music.126.net/nghrV1_ZW6lht9Ue7r4Ffg==/7697680906845029.jpg",
            "companyId": 0,
            "pic": 7697680906845029,
            "picUrl":
                "http://p1.music.126.net/nghrV1_ZW6lht9Ue7r4Ffg==/7697680906845029.jpg",
            "publishTime": 1409846400007,
            "description": "",
            "tags": "",
            "company": "独立发行",
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
            "copyrightId": 0,
            "commentThreadId": "R_AL_3_3106026",
            "artists": [
              {
                "name": "周深",
                "id": 1030001,
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
            "mark": 0
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 183000,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": null,
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_30903117",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 2,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 0,
          "hMusic": null,
          "mMusic": null,
          "lMusic": {
            "name": null,
            "id": 64734302,
            "size": 2937042,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 183000,
            "volumeDelta": 10255
          },
          "bMusic": {
            "name": null,
            "id": 64734302,
            "size": 2937042,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 183000,
            "volumeDelta": 10255
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 后来",
          "privilege": {
            "id": 30903117,
            "fee": 0,
            "payed": 0,
            "st": 0,
            "pl": 128000,
            "dl": 128000,
            "sp": 7,
            "cp": 1,
            "subp": 1,
            "cs": false,
            "maxbr": 128000,
            "fl": 999000,
            "toast": false,
            "flag": 128,
            "preSell": false
          },
          "alg": "endRecentSubRC"
        },
        {
          "name": "曾经的你",
          "id": 167975,
          "position": 3,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 7002,
          "disc": "1",
          "no": 3,
          "artists": [
            {
              "name": "许巍",
              "id": 5770,
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
            "name": "每一刻都是崭新的",
            "id": 16967,
            "type": "专辑",
            "size": 11,
            "picId": 109951163092691600,
            "blurPicUrl":
                "http://p1.music.126.net/GoiTB6oG3vQWntnCjKRw0g==/109951163092691594.jpg",
            "companyId": 0,
            "pic": 109951163092691600,
            "picUrl":
                "http://p1.music.126.net/GoiTB6oG3vQWntnCjKRw0g==/109951163092691594.jpg",
            "publishTime": 1102521600007,
            "description": "",
            "tags": "",
            "company": "华纳唱片",
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
            "status": 3,
            "copyrightId": 7002,
            "commentThreadId": "R_AL_3_16967",
            "artists": [
              {
                "name": "许巍",
                "id": 5770,
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
            "picId_str": "109951163092691594"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 261000,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "600902000005652557",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_167975",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 1,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 5300126,
          "hMusic": {
            "name": null,
            "id": 63607720,
            "size": 10460645,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 261000,
            "volumeDelta": -2
          },
          "mMusic": {
            "name": null,
            "id": 93673957,
            "size": 6276456,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 261000,
            "volumeDelta": -2
          },
          "lMusic": {
            "name": null,
            "id": 63607721,
            "size": 4184361,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 261000,
            "volumeDelta": -2
          },
          "bMusic": {
            "name": null,
            "id": 63607721,
            "size": 4184361,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 261000,
            "volumeDelta": -2
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 淘汰",
          "privilege": {
            "id": 167975,
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
          "name": "傻子",
          "id": 108194,
          "position": 9,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 677020,
          "disc": "1",
          "no": 9,
          "artists": [
            {
              "name": "林宥嘉",
              "id": 3685,
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
            "name": "大小说家",
            "id": 10752,
            "type": "专辑",
            "size": 15,
            "picId": 109951163167636210,
            "blurPicUrl":
                "http://p1.music.126.net/os7qbSSng_yni2ZFouUryw==/109951163167636205.jpg",
            "companyId": 0,
            "pic": 109951163167636210,
            "picUrl":
                "http://p1.music.126.net/os7qbSSng_yni2ZFouUryw==/109951163167636205.jpg",
            "publishTime": 1340294400000,
            "description": "",
            "tags": "",
            "company": "华研国际",
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
            "status": 40,
            "copyrightId": 1004,
            "commentThreadId": "R_AL_3_10752",
            "artists": [
              {
                "name": "林宥嘉",
                "id": 3685,
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
            "picId_str": "109951163167636205"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 214400,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": "600902000009105195",
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_108194",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 2,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 5842403,
          "hMusic": {
            "name": null,
            "id": 1426698168,
            "size": 8578656,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 214400,
            "volumeDelta": -2500
          },
          "mMusic": {
            "name": null,
            "id": 1426698169,
            "size": 5147211,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 214400,
            "volumeDelta": 0
          },
          "lMusic": {
            "name": null,
            "id": 1426698170,
            "size": 3431488,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 214400,
            "volumeDelta": 0
          },
          "bMusic": {
            "name": null,
            "id": 1426698170,
            "size": 3431488,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 214400,
            "volumeDelta": 0
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 淘汰",
          "privilege": {
            "id": 108194,
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
            "flag": 68,
            "preSell": false
          },
          "alg": "itembased"
        },
        {
          "name": "I don't wanna see u anymore",
          "id": 528326686,
          "position": 1,
          "alias": [],
          "status": 0,
          "fee": 8,
          "copyrightId": 0,
          "disc": "01",
          "no": 1,
          "artists": [
            {
              "name": "NINEONE",
              "id": 12276375,
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
            "name": "I don't wanna see u anymore",
            "id": 37154521,
            "type": "专辑",
            "size": 1,
            "picId": 109951163100083680,
            "blurPicUrl":
                "http://p1.music.126.net/a_gJIqhD4ICAC30UttQIGg==/109951163100083686.jpg",
            "companyId": 0,
            "pic": 109951163100083680,
            "picUrl":
                "http://p1.music.126.net/a_gJIqhD4ICAC30UttQIGg==/109951163100083686.jpg",
            "publishTime": 1515050237993,
            "description": "",
            "tags": "",
            "company": null,
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
            "copyrightId": 0,
            "commentThreadId": "R_AL_3_37154521",
            "artists": [
              {
                "name": "NINEONE#",
                "id": 12276375,
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
            "picId_str": "109951163100083686"
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 153840,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": null,
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_528326686",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 0,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 0,
          "hMusic": {
            "name": null,
            "id": 1405183219,
            "size": 6156582,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 153840,
            "volumeDelta": -2
          },
          "mMusic": {
            "name": null,
            "id": 1405183220,
            "size": 3693967,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 192000,
            "playTime": 153840,
            "volumeDelta": -2
          },
          "lMusic": {
            "name": null,
            "id": 1405183221,
            "size": 2462659,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 153840,
            "volumeDelta": -2
          },
          "bMusic": {
            "name": null,
            "id": 1405183221,
            "size": 2462659,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 128000,
            "playTime": 153840,
            "volumeDelta": -2
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你可能喜欢的单曲 Always Online",
          "privilege": {
            "id": 528326686,
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
        },
        {
          "name": "黑洞",
          "id": 33111724,
          "position": 4,
          "alias": [],
          "status": 0,
          "fee": 1,
          "copyrightId": 7003,
          "disc": "1",
          "no": 4,
          "artists": [
            {
              "name": "陈奕迅",
              "id": 2116,
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
            "name": "准备中",
            "id": 3184340,
            "type": "专辑",
            "size": 10,
            "picId": 7938473953631427,
            "blurPicUrl":
                "http://p1.music.126.net/JmNbYpBbsE7SLsnM_j0xvw==/7938473953631427.jpg",
            "companyId": 0,
            "pic": 7938473953631427,
            "picUrl":
                "http://p1.music.126.net/JmNbYpBbsE7SLsnM_j0xvw==/7938473953631427.jpg",
            "publishTime": 1436457600007,
            "description": "",
            "tags": "",
            "company": "EAS Music",
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
            "status": -4,
            "copyrightId": 7003,
            "commentThreadId": "R_AL_3_3184340",
            "artists": [
              {
                "name": "陈奕迅",
                "id": 2116,
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
            "mark": 0
          },
          "starred": false,
          "popularity": 100,
          "score": 100,
          "starredNum": 0,
          "duration": 221000,
          "playedNum": 0,
          "dayPlays": 0,
          "hearTime": 0,
          "ringtone": null,
          "crbt": null,
          "audition": null,
          "copyFrom": "",
          "commentThreadId": "R_SO_4_33111724",
          "rtUrl": null,
          "ftype": 0,
          "rtUrls": [],
          "copyright": 2,
          "transName": null,
          "sign": null,
          "mark": 0,
          "mvid": 5328038,
          "hMusic": {
            "name": null,
            "id": 97571744,
            "size": 8879723,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 320000,
            "playTime": 221000,
            "volumeDelta": -0.3
          },
          "mMusic": {
            "name": null,
            "id": 97571745,
            "size": 4439952,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 160000,
            "playTime": 221000,
            "volumeDelta": -0.000265076
          },
          "lMusic": {
            "name": null,
            "id": 97571746,
            "size": 2664043,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 96000,
            "playTime": 221000,
            "volumeDelta": -0.000265076
          },
          "bMusic": {
            "name": null,
            "id": 97571746,
            "size": 2664043,
            "extension": "mp3",
            "sr": 44100,
            "dfsId": 0,
            "bitrate": 96000,
            "playTime": 221000,
            "volumeDelta": -0.000265076
          },
          "mp3Url": null,
          "rtype": 0,
          "rurl": null,
          "reason": "根据你的口味",
          "privilege": {
            "id": 33111724,
            "fee": 1,
            "payed": 0,
            "st": 0,
            "pl": 0,
            "dl": 0,
            "sp": 0,
            "cp": 1,
            "subp": 0,
            "cs": false,
            "maxbr": 999000,
            "fl": 0,
            "toast": false,
            "flag": 4,
            "preSell": false
          },
          "alg": "daily_ts_recall"
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

  // 获取所有榜单
  static getTopListAll() async {
    var url = '${API_HOST}toplist';
    try {
      Response response = await Dio().get(url);
      var list = json.decode(response.toString())['list'];
      return list;
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
