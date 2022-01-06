import 'package:http/http.dart';
import 'package:ufone_web/src/resource/network/network_client.dart';

class SurahNameProvider {
  Client client = Client();

  Future<NetworkClientState?> fetchData(String endpoint) async {
    NetworkClientState? networkClientState = NetworkClientState.getInstance();
    final response = await networkClientState!.getRequest(endpoint);
    return response;
  }
}