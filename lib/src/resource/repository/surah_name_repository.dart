import 'dart:convert';

import 'package:ufone_web/src/model/surah_name.dart';
import 'package:ufone_web/src/resource/network/network_client.dart';
import 'package:ufone_web/src/resource/provider/surah_name_provider.dart';


class SurahNameRepository {
  static SurahNameRepository? _surahRepository;
  final surahProvider = SurahNameProvider();

  static SurahNameRepository? getInstance() {
    _surahRepository ??= SurahNameRepository();
    return _surahRepository;
  }

  Future<List<SurahName>> getSurahList() async {
    NetworkClientState? response = await surahProvider.fetchData(
        "https://vp.vxt.net:31786/api/list");
    if (response is OnSuccessState) {
      OnSuccessState onSuccessState = response;
      final parsed = json.decode(onSuccessState.response) as List;
      return parsed.map<SurahName>((data) => SurahName.fromJson(data)).toList();
    } else if (response is OnFailureState) {
      OnFailureState onErrorState = response;
      throw onErrorState.throwable;
    } else if (response is OnErrorState) {
      OnErrorState onErrorState = response;
      throw onErrorState.errorType;
    }
    return throw Exception();
  }
}
