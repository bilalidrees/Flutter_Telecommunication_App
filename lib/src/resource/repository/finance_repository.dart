import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ufone_web/src/model/corona_news.dart';
import 'package:ufone_web/src/model/corona_update.dart';
import 'package:ufone_web/src/model/finance.dart';
import 'package:ufone_web/src/model/forex_finance.dart';
import 'package:ufone_web/src/model/kse_rate_finance.dart';
import 'package:ufone_web/src/resource/network/network_client.dart';
import 'package:ufone_web/src/resource/network/network_constants.dart';
import 'package:ufone_web/src/resource/provider/corona_provider.dart';
import 'package:ufone_web/src/resource/provider/finance_provider.dart';

class FinanceRepository {
  static FinanceRepository? _financeRepository;
  final financeProvider = FinanceProvider();

  static FinanceRepository? getInstance() {
    _financeRepository ??= FinanceRepository();
    return _financeRepository;
  }

  Future<List<Finance>?> getFinanceStates() async {
    NetworkClientState? response =
        await financeProvider.fetchData(
            "${NetworkConstants.UFONE_INFO_URL}${NetworkConstants.FINANCE_INFORMATION}");
    if (response is OnSuccessState) {
      OnSuccessState onSuccessState = response;
      List l = json.decode(onSuccessState.response);
      List<Finance> finance = [];
      for (int index = 0; index < l.length; index++) {
        if (index == 0) {
          finance.add(KseRateFinance.fromJson(l[index]));
        } else {
          finance.add(ForexFinance.fromJson(l[index]));
        }
      }
      return finance;
    } else if (response is OnFailureState) {
      OnFailureState onErrorState = response;
      throw onErrorState.throwable;
    }
    return null;
  }
}
