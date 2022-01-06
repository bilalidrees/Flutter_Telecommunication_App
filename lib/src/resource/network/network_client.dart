import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ufone_web/src/resource/network/network_constants.dart';

class NetworkClientState {
  static const String URL = 'https://jsonplaceholder.typicode.com/posts';

  BuildContext? _buildContext;
  static NetworkClientState? networkClientState;
  String? token, apiUrl;
  var apiResponse;

  NetworkClientState.createInstance();

  NetworkClientState();

  static NetworkClientState? getInstance() {
    networkClientState ??= NetworkClientState();
    return networkClientState;
  }

  Future<NetworkClientState?> postRequest(
      {String? endpoint, String? jsonBody}) async {
    try {
      final Map<String, String> headers = {
        'Content-type': 'application/json',
      };
      print("post $endpoint");
      print("post $jsonBody");
      apiResponse = await http.post(endpoint, body: jsonBody, headers: headers);
      return NetworkClientState._onSuccess(apiResponse.body, endpoint!);
    } on TimeoutException catch (_) {
      return NetworkClientState._onFailure(
          Exception("Timeout occured"), endpoint!);
    } on Error catch (exception) {
      if (apiResponse.statusCode == 403) {
      } else {
        return NetworkClientState._onFailure(Exception(exception), endpoint!);
      }
    } on Exception catch (exception) {
      //return NetworkClientState._onFailure(exception, endpoint);
    }
  }

  Future<NetworkClientState?> getRequest(String endpoint) async {
    try {
      print("get $endpoint");
      apiResponse = await http.get(endpoint, headers: {
        "Content-type": "application/json",
        "Access-Control-Allow-Origin": "*"
      });

      return NetworkClientState._onSuccess(apiResponse.body, endpoint);
    } on Error catch (_) {
      if (apiResponse.statusCode == 401 || apiResponse.statusCode == 403) {
      } else {
        return NetworkClientState._onFailure(
            Exception("on error triggered"), endpoint);
      }
    } on Exception catch (exception) {
      return NetworkClientState._onFailure(exception, endpoint);
    }
  }

  Future<NetworkClientState?> apiTestSerivce(String endpoint) async {
    try {
      apiResponse =
          await http.get(endpoint).timeout(const Duration(seconds: 5));
      return NetworkClientState._onSuccess(apiResponse.body, endpoint);
    } on TimeoutException catch (_) {
      return NetworkClientState._onError(Exception("Time Out Exception"),
          endpoint, Status.timeOutException.index);
    } on Error catch (_) {
      return NetworkClientState._onFailure(
          Exception("on error triggered"), endpoint);
    } on Exception catch (exception) {
      return NetworkClientState._onFailure(exception, endpoint);
    }
  }

  factory NetworkClientState._onSuccess(String response, String apiEndpoint) =
      OnSuccessState;

  factory NetworkClientState._onError(
      Exception throwable, String apiEndpoint, int errorType) = OnErrorState;

  factory NetworkClientState._onFailure(Exception throwable, String endPoint) =
      OnFailureState;
}

class OnSuccessState extends NetworkClientState {
  String response, apiEndpoint;

  OnSuccessState(this.response, this.apiEndpoint) : super.createInstance();
}

class OnErrorState extends NetworkClientState {
  Exception throwable;
  String apiEndpoint;
  int errorType;

  OnErrorState(this.throwable, this.apiEndpoint, this.errorType)
      : super.createInstance();
}

class OnFailureState extends NetworkClientState {
  Exception throwable;
  String apiEndpoint;

  OnFailureState(this.throwable, this.apiEndpoint) : super.createInstance();
}
