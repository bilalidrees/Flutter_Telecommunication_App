import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' show Client;

import 'package:ufone_web/src/resource/network/network_client.dart';

class PrayerProvider {
  final Position? position;
  Client client = Client();

  PrayerProvider({this.position});
  Future<NetworkClientState?> fetchData(String baseUrl, String endpoint,double lat,double lng,String city) async {
    NetworkClientState? networkClientState = NetworkClientState.getInstance();

    final queryParameters = {
      'tz': '5',
      'a': 'HANAFI',
      // 'm': city.toUpperCase(),
      'lt': lat.toString(),
      'lg': lng.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;

    var requestUrl = endpoint + '?' + queryString;
    // final uri = Uri.https(baseUrl, endpoint, queryParameters);
    final response = await networkClientState!.getRequest(requestUrl);
    return response;
  }

}
