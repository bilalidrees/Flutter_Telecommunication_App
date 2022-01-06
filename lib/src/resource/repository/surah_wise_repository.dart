import 'dart:convert';

import 'package:ufone_web/src/model/surah_wise.dart';
import 'package:ufone_web/src/resource/network/network_client.dart';
import 'package:ufone_web/src/resource/provider/surah_wise_provider.dart';

class SurahWiseRepository {
  static SurahWiseRepository? _surahWiseRepository;
  final surahWiseProvider = SurahWiseProvider();

  static SurahWiseRepository? getInstance() {
    _surahWiseRepository ??= SurahWiseRepository();
    return _surahWiseRepository;
  }

  Future<List<SurahWise>> getSurahList(int surah, String lang) async {
    NetworkClientState? response = await surahWiseProvider.fetchData(surah, lang);
    if (response is OnSuccessState) {
      OnSuccessState onSuccessState = response;
      final parsed = json.decode(onSuccessState.response) as List;
      return parsed.map<SurahWise>((data) => SurahWise.fromJson(data)).toList();
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
