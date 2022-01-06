import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:ufone_web/src/resource/network/network_client.dart';

class NewsProvider {
  Client client = Client();

  Future<NetworkClientState?> fetchData(String endpoint) async {
    NetworkClientState? networkClientState = NetworkClientState.getInstance();
    final response = networkClientState!.getRequest(endpoint);
    return response;
  }

  Future<NetworkClientState?> postData({required String endpoint, required String body}) async {
    NetworkClientState? networkClientState = NetworkClientState.getInstance();
    final response =
    networkClientState!.postRequest(endpoint: endpoint, jsonBody: body);
    return response;
  }
}
