import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ufone_web/src/model/surah_name.dart';
import 'package:ufone_web/src/resource/repository/surah_name_repository.dart';

part 'surah_name_state.dart';

class SurahNameCubit extends Cubit<SurahNameState> {
  final SurahNameRepository _surahNameRepository;
  SurahNameCubit(this._surahNameRepository) : super(SurahNameInitial());

  Future<void> getSurahList()async{
    emit(const SurahNameLoadingState());
    await _surahNameRepository.getSurahList().then((value){
      emit( SurahNameSuccessState(isSuccess: true,SurahNameList: value));
    },onError: (exception){
      emit(SurahNameErrorState(message: exception));
    });

  }
}