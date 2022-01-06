import 'dart:async';
import 'package:http/http.dart' show Client;

import 'package:ufone_web/src/resource/network/network_client.dart';

class WeatherProvider {
  Client client = Client();

  Future<NetworkClientState?> postData(String endpoint, String body) async {
    NetworkClientState? networkClientState = NetworkClientState.getInstance();
    final response = await networkClientState!
        .postRequest(endpoint: endpoint, jsonBody: body);
    return response;
  }
}
