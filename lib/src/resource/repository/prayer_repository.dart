import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:ufone_web/src/model/corona_news.dart';
import 'package:ufone_web/src/model/corona_update.dart';
import 'package:ufone_web/src/model/prayer_info.dart';
import 'package:ufone_web/src/resource/network/network_client.dart';
import 'package:ufone_web/src/resource/network/network_constants.dart';
import 'package:ufone_web/src/resource/provider/corona_provider.dart';
import 'package:ufone_web/src/resource/provider/prayer_provider.dart';

class PrayerRepository {
   PrayerProvider? prayerProvider;

  PrayerRepository(){
    prayerProvider= PrayerProvider();
  }

  Future<PrayerInfo?> getPrayerInformation(double lat ,double long,String city) async {
    NetworkClientState? response = await prayerProvider!.fetchData(
        NetworkConstants.BASE_URL, NetworkConstants.PRAYER_INFORMATION,lat,long,city);
    if (response is OnSuccessState) {
      OnSuccessState onSuccessState = response;
      final parsed = json.decode(onSuccessState.response);
      return PrayerInfo.fromJson(parsed);
    } else if (response is OnFailureState) {
      OnFailureState onErrorState = response;
      throw onErrorState.throwable;
    }
    return null;
  }
}
