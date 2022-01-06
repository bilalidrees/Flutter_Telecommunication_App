part of 'corona_news_cubit.dart';

@immutable
abstract class CoronaNewsState {}

class CoronaNewsInitial extends CoronaNewsState {}

class CoronaNewsInitialState extends CoronaNewsState {
  CoronaNewsInitialState();
}

class CoronaNewsLoadingState extends CoronaNewsState {
  bool? isVisible;

  CoronaNewsLoadingState({isVisible});
}

// ignore: must_be_immutable
class CoronaNewsSuccessState extends CoronaNewsState {
  bool? isSuccess;
  List<CoronaNews>? coronaNewsList;

  CoronaNewsSuccessState({this.isSuccess, this.coronaNewsList});
}

class CoronaNewsErrorState extends CoronaNewsState {
  final String? message;

  CoronaNewsErrorState({this.message});
}
