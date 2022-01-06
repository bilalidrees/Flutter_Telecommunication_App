import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ufone_web/src/model/weather.dart';
import 'package:ufone_web/src/model/corona_news.dart';
import 'package:ufone_web/src/model/corona_update.dart';
import 'package:ufone_web/src/model/finance.dart';
import 'package:ufone_web/src/model/forex_finance.dart';
import 'package:ufone_web/src/model/kse_rate_finance.dart';
import 'package:ufone_web/src/resource/network/network_client.dart';
import 'package:ufone_web/src/resource/network/network_constants.dart';
import 'package:ufone_web/src/resource/provider/corona_provider.dart';
import 'package:ufone_web/src/resource/provider/finance_provider.dart';
import 'package:ufone_web/src/resource/provider/weather_provider.dart';

class WeatherRepository {
  static WeatherRepository? weatherRepository;
  final weatherProvider = WeatherProvider();

  static WeatherRepository? getInstance() {
    weatherRepository ??= WeatherRepository();
    return weatherRepository;
  }

  Future<Weather?> getWeatherStates(String lat, String lng) async {
    Map latLng = {"lat": lat, "long": lng};
    String jsonString = jsonEncode(latLng);
    NetworkClientState? response = await weatherProvider.postData(
        "${NetworkConstants.UFONE_INFO_URL}${NetworkConstants.WEATHER_INFORMATION}",
        jsonString);
    if (response is OnSuccessState) {
      OnSuccessState onSuccessState = response;
      final parsed = json.decode(onSuccessState.response);
      final data = parsed['data'] as Map<String, dynamic>;
      return Weather.fromJson(data);
    } else if (response is OnFailureState) {
      OnFailureState onErrorState = response;
      throw onErrorState.throwable;
    }
    return null;
  }
}
