import 'package:http/http.dart';
import 'package:ufone_web/src/resource/network/network_client.dart';

class SurahWiseProvider {
  Client client = Client();

  Future<NetworkClientState?> fetchData(int surah, String lang) async {
    NetworkClientState? networkClientState = NetworkClientState.getInstance();

    final queryParameters = {
      'surah': "$surah",
      'ayat': '0',
      'limit': '0',
      'lang':lang,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var requestUrl = "https://vp.vxt.net:31786/api/surah" + '?' + queryString;
    final response = await networkClientState!.getRequest(requestUrl);
    return response;
  }
}