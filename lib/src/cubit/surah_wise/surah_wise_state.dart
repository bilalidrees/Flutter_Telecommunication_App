part of 'surah_wise_cubit.dart';

@immutable
abstract class SurahWiseState {
  const SurahWiseState();
}

class SurahWiseInitial extends SurahWiseState {
  const SurahWiseInitial();
}

class SurahWiseLoadingState extends SurahWiseState {
  const SurahWiseLoadingState();
}

class SurahWiseSuccessState extends SurahWiseState {
  final List<SurahWise> arbiSurah;
  final List<SurahWise> urduSurah;

  const SurahWiseSuccessState({required this.arbiSurah, required this.urduSurah});
}

class SurahWiseErrorState extends SurahWiseState {
  final String message;

  const SurahWiseErrorState({required this.message});
}
