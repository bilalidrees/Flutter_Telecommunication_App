import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:ufone_web/src/resource/network/network_client.dart';

class UserProvider {
  Client client = Client();

  Future<NetworkClientState?> fetchData(String endpoint) async {
    NetworkClientState? networkClientState = NetworkClientState.getInstance();
    //await networkClientState.setSessionToken();
    final response = networkClientState!.getRequest(endpoint);
    return response;
  }

  Future<NetworkClientState?> postData({String? endpoint, String? body}) async {
    NetworkClientState? networkClientState = NetworkClientState.getInstance();
    //await networkClientState.setSessionToken();
    final response =
        networkClientState!.postRequest(endpoint: endpoint, jsonBody: body);
    return response;
  }
}
