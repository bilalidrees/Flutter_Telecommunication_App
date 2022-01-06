import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ufone_web/src/model/finance.dart';
import 'package:ufone_web/src/model/forex_finance.dart';
import 'package:ufone_web/src/model/kse_rate_finance.dart';
import 'package:ufone_web/src/resource/repository/finance_repository.dart';

part 'finance_state.dart';

class FinanceCubit extends Cubit<FinanceState> {
  final FinanceRepository? financeRepository;
  List<Finance>? financeList;

  FinanceCubit({required this.financeRepository}) : super(FinanceInitial());

  void getFinanceUpdates() async {
    emit(FinanceLoadingState());
    await financeRepository!.getFinanceStates().then((finance_List) async {
      financeList = finance_List;
      var kseRates = financeList![0] as KseRateFinance;
      var forexRates = financeList![1] as ForexFinance;
      emit(FinanceSuccessState(
          kseRateFinance: kseRates, forexFinance: forexRates));
    }, onError: (exception) {
      emit(FinanceErrorState(message: exception.toString()));
    });
  }
}
