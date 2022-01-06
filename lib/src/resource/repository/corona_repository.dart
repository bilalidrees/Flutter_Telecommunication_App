import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ufone_web/src/model/corona_news.dart';
import 'package:ufone_web/src/model/corona_update.dart';
import 'package:ufone_web/src/resource/network/network_client.dart';
import 'package:ufone_web/src/resource/network/network_constants.dart';
import 'package:ufone_web/src/resource/provider/corona_provider.dart';

class CoronaRepository {
  static CoronaRepository? _coronaRepository;
  final coronaProvider = CoronaProvider();

  static CoronaRepository? getInstance() {
    _coronaRepository ??= CoronaRepository();
    return _coronaRepository;
  }

  Future<CoronaUpdate?> getCoronaStats() async {
    NetworkClientState? response = await coronaProvider.fetchData(
        "${NetworkConstants.UFONE_INFO_URL}${NetworkConstants.CORONA_STATS}");
    if (response is OnSuccessState) {
      OnSuccessState onSuccessState = response;
      final parsed = json.decode(onSuccessState.response);
      return CoronaUpdate.fromJson(parsed);
    } else if (response is OnFailureState) {
      OnFailureState onErrorState = response;
      throw onErrorState.throwable;
    } else if (response is OnErrorState) {
      OnErrorState onErrorState = response;
      throw onErrorState.errorType;
    }
    return null;
  }

  Future<List<CoronaNews>?> getCoronaNews() async {
    NetworkClientState? response = await coronaProvider.fetchData(
        "${NetworkConstants.UFONE_INFO_URL}${NetworkConstants.CORONA_NEWS}");
    if (response is OnSuccessState) {
      OnSuccessState onSuccessState = response;
      Iterable l = json.decode(onSuccessState.response);
      List<CoronaNews> posts =
          List<CoronaNews>.from(l.map((model) => CoronaNews.fromJson(model)));
      return posts;
    } else if (response is OnFailureState) {
      OnFailureState onErrorState = response;
      throw onErrorState.throwable;
    }
    return null;
  }
}
