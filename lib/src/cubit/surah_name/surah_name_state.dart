part of 'surah_name_cubit.dart';

@immutable
abstract class SurahNameState {
  const SurahNameState();
}

class SurahNameInitial extends SurahNameState {
  const SurahNameInitial();
}

class SurahNameLoadingState extends SurahNameState {
  final bool? isVisible;

  const SurahNameLoadingState({this.isVisible});
}

class SurahNameSuccessState extends SurahNameState {
  final bool isSuccess;
  final List<SurahName> SurahNameList;

  const SurahNameSuccessState({required this.isSuccess,required this.SurahNameList});
}

class SurahNameErrorState extends SurahNameState {
  final String? message;

  const SurahNameErrorState({this.message});
}

