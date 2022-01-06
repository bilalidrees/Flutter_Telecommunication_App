import 'dart:async';
import 'package:http/http.dart' show Client;

import 'package:ufone_web/src/resource/network/network_client.dart';

class CoronaProvider {
  Client client = Client();

  Future<NetworkClientState?> fetchData(String endpoint) async {
    NetworkClientState? networkClientState = NetworkClientState.getInstance();
    final response = await networkClientState!.getRequest(endpoint);
    return response;
  }
}
