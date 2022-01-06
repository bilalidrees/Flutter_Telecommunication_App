part of 'corona_cubit.dart';

@immutable
abstract class CoronaState {}

class CoronaInitialState extends CoronaState {
  CoronaInitialState();
}

class CoronaLoadingState extends CoronaState {
  bool? isVisible;

  CoronaLoadingState({isVisible});
}

// ignore: must_be_immutable
class CoronaSuccessState extends CoronaState {
  bool? isSuccess;
  CoronaUpdate? coronaUpdate;
  List<CoronaNews>? coronaNewsList;

  CoronaSuccessState({this.isSuccess, this.coronaUpdate, this.coronaNewsList});
}

class CoronaErrorState extends CoronaState {
  final String? message;
  final int? errorType;

  CoronaErrorState({this.message, this.errorType});
}
