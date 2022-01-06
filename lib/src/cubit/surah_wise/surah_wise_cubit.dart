import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ufone_web/src/model/surah_wise.dart';
import 'package:ufone_web/src/resource/repository/surah_wise_repository.dart';

part 'surah_wise_state.dart';

class SurahWiseCubit extends Cubit<SurahWiseState> {
  final SurahWiseRepository _surahWiseRepo;

  SurahWiseCubit(this._surahWiseRepo) : super(SurahWiseInitial());

  Future<void> getSurahByIdAndLang(int surah) async {
    emit(SurahWiseLoadingState());
    await _surahWiseRepo.getSurahList(surah, "ar").then((arbiList) async {
      await _surahWiseRepo.getSurahList(surah, "ur").then((urduList) {
        emit(SurahWiseSuccessState(arbiSurah: arbiList, urduSurah: urduList));
      }, onError: (exception) {
        emit(SurahWiseErrorState(message: exception.toString()));
      });
    }, onError: (exception) {
      emit(SurahWiseErrorState(message: exception.toString()));
    });
  }
}
