import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

const API_HOST = 'http://192.168.206.133:3000/';

class NeteaseRepository {
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
  static Future<List> doSearchSingAlbum(String keyword) async {
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
    var url = '${API_HOST}song/url?id=$id';
    try {
      Response response = await Dio().get(url);
      var data = json.decode(response.toString())['data'][0];
      return data['url'];
    } catch (e) {
      print(e);
    }
  }

  // 获取所有歌曲
  static getSongs(String keyword) async {
    var url = '${API_HOST}search?keywords=$keyword';
    try {
      Response response = await Dio().get(url);
      var songRes = json.decode(response.toString())['result']['songs'];
      return songRes;
    } catch (e) {}
  }

  // 获取所有歌单
  static getPlaylist(String keyword) async {
    var url = '${API_HOST}search?keywords=$keyword&type=1000';
    try {
      Response response = await Dio().get(url);
      var plays = json.decode(response.toString())['result']['playlists'];

      return plays;
    } catch (e) {
      print(e);
    }
  }
}
