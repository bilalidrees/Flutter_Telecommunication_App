import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ufone_web/src/model/NewsFeed.dart';
import 'package:ufone_web/src/resource/network/network_client.dart';
import 'package:ufone_web/src/resource/network/network_constants.dart';

class AppUtility {
  static getSources(String sourceList) {
    var array = sourceList.split('.');
    var retMap = {};
    if (array[0] != null) retMap['source'] = '"${array[0]}"';
    if (array[1] != null) retMap['category'] = '"${array[1]}"';
    if (array[2] != null) retMap['type'] = '"${array[2]}"';
    if (array[3] != null) retMap['sub_type'] = '"${array[3]}"';
    return retMap;
  }

  static Future<List<NewsFeed>> getPublishTime(
      List<NewsFeed> newsFeedList) async {
    List<NewsFeed> newNewsFeed = [];

    newsFeedList.forEach((news) {
      List<String> split = news.pubdate.split("T");
      String time = "${split[0]} ${split[1]}";
      DateTime tempDate =
          new DateFormat("yyyy-MM-dd hh:mm:ss").parse(time, false);
      DateTime currentDate = DateTime.now();

      double seconds = (currentDate.millisecondsSinceEpoch -
              tempDate.millisecondsSinceEpoch) /
          1000;
      String intervalType;
      double mathValue;
      mathValue = seconds / 31536000;
      int interval = mathValue.round();
      if (interval >= 1) {
        intervalType = 'year';
      } else {
        mathValue = seconds / 2592000;
        interval = mathValue.round();
        if (interval >= 1) {
          intervalType = 'month';
        } else {
          mathValue = seconds / 86400;
          interval = mathValue.round();
          if (interval >= 1) {
            intervalType = 'day';
          } else {
            mathValue = seconds / 3600;
            interval = mathValue.round();
            if (interval >= 1) {
              intervalType = 'hour';
            } else {
              mathValue = seconds / 60;
              interval = mathValue.round();
              if (interval >= 1) {
                intervalType = 'minute';
              } else {
                interval = seconds as int;
                intervalType = 'second';
              }
            }
          }
        }
      }
      //    adding a plural to text, optional
      if (interval > 1 || interval == 0) {
        intervalType += 's';
      }
      if (interval is String || (interval <= 0)) {
        news.articlePublishedTime = "";
        newNewsFeed.add(news);
      } else {
        news.articlePublishedTime = "$interval $intervalType ago";
        newNewsFeed.add(news);
      }
    });

    return newNewsFeed;
  }

  static Future<List<dynamic>> getRootBundle() async {
    final String response =
        await rootBundle.loadString("assets/lang/sourceList.json");
    final data = await json.decode(response);
    List<dynamic> responseData = data as List<dynamic>;
    return responseData;
  }

  static Future<bool> apiUrlTestService(String baseUrl) async {
    NetworkClientState? networkClientState = NetworkClientState.getInstance();
    final response = await networkClientState!.apiTestSerivce(baseUrl);
    if (response is OnSuccessState) {
      NetworkConstants.UFONE_INFO_URL = baseUrl;
      return true;
    } else {
      return false;
    }
  }

  static Future<bool?> checkApiBaseUrl() async {
    bool api01 =
        await apiUrlTestService("https://api01.vectracom.net:8443/zong-info/");
    if (api01) {
      return api01;
    }
    else {
      bool api02 = await apiUrlTestService(
          "https://api02.vectracom.net:8443/zong-info/");
      if (api02) {
        return api02;
      }
      else {
        bool api03 = await apiUrlTestService(
            "https://api03.vectracom.net:8443/zong-info/");
        if (api03) {
          return true;
        }
      }
    }
  }
}
