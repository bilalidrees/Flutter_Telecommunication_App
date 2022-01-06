import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ufone_web/src/model/Category.dart';
import 'package:ufone_web/src/model/NewsFeed.dart';
import 'package:ufone_web/src/resource/network/network_client.dart';
import 'package:ufone_web/src/resource/network/network_constants.dart';
import 'package:ufone_web/src/resource/provider/news_provider.dart';

class NewsRepository {
  final newsProvider = NewsProvider();

  Future<List<Category>?> getNewsCategories(bool locale) async {
    NetworkClientState? response = await newsProvider.fetchData(locale
        ? NetworkConstants.CATEGORIES_URL
        : NetworkConstants.CATEGORIES_URL_URDU);
    if (response is OnSuccessState) {
      OnSuccessState onSuccessState = response;
      Iterable l = json.decode(onSuccessState.response);
      List<Category> posts =
          List<Category>.from(l.map((model) => Category.fromJson(model)));
      return posts;
    } else if (response is OnFailureState) {
      OnFailureState onErrorState = response;
      throw onErrorState.throwable;
    }
    return null;
  }

  // GraphQL query
  Future<List<NewsFeed>?> fetchFeed(String sourceList,
      {String? responseString}) async {
    final url = 'https://vp.vxt.net:9443/rdrss/v3/api';
    var requiredResponse;
    if (responseString != null) {
      requiredResponse = responseString;
    } else {
      requiredResponse =
          'title description encoded_content long_description tuuid sno media_links { picture {title link}} pubdate lang';
    }

    final sourceFilter = getSources(sourceList).toString();
    final filterData = {
      "query": "{feeds(feedFilter:$sourceFilter){$requiredResponse}}"
    };
    print('Query: ${json.encode(filterData)}');
    final Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final response =
        await http.post(url, headers: headers, body: json.encode(filterData));
    print("2 ${response.body}");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // return data['data']['feeds'];
      List<dynamic> responseData = data['data']['feeds'] as List<dynamic>;
      return (responseData).map((i) => NewsFeed.fromJson(i)).toList();
    }
  }

  getSources(String sourceList) {
    var array = sourceList.split('.');
    var retMap = {};
    if (array[0] != null) retMap['source'] = '"${array[0]}"';
    if (array[1] != null) retMap['category'] = '"${array[1]}"';
    if (array[2] != null) retMap['type'] = '"${array[2]}"';
    if (array[3] != null) retMap['sub_type'] = '"${array[3]}"';
    return retMap;
  }
}
