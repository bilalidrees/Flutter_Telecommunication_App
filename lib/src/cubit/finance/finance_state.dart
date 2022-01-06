part of 'finance_cubit.dart';

@immutable
abstract class FinanceState {}

class FinanceInitial extends FinanceState {}

class FinanceLoadingState extends FinanceState {
  bool? isVisible;

  FinanceLoadingState({isVisible});
}

// ignore: must_be_immutable
class FinanceSuccessState extends FinanceState {
  bool? isSuccess;
  KseRateFinance? kseRateFinance;
  ForexFinance? forexFinance;

  FinanceSuccessState({this.isSuccess, this.kseRateFinance, this.forexFinance});
}

class FinanceErrorState extends FinanceState {
  final String? message;

  FinanceErrorState({this.message});
}
