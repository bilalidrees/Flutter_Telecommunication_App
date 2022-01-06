import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ufone_web/src/model/corona_news.dart';
import 'package:ufone_web/src/resource/repository/corona_repository.dart';

part 'corona_news_state.dart';

class CoronaNewsCubit extends Cubit<CoronaNewsState> {
  final CoronaRepository coronaRepository;
  List<CoronaNews>? _coronaNewsList, _englishList, _urduList;

  CoronaNewsCubit({required this.coronaRepository})
      : super(CoronaNewsInitial());

  List<CoronaNews> get coronaNewsList => _coronaNewsList!;

  get englishList => _englishList;

  get urduList => _urduList;

  void getCoronaNews() async {
    emit(CoronaNewsLoadingState());
    await coronaRepository.getCoronaNews().then((coronaNewsList) async {
      _coronaNewsList = coronaNewsList;
      _englishList = _coronaNewsList!.where((element) {
        return element.language == "English";
      }).toList();
      _urduList = _coronaNewsList!.where((element) {
        return element.language == "Urdu";
      }).toList();
      emit(CoronaNewsSuccessState(coronaNewsList: _englishList));
    }, onError: (exception) {
      emit(CoronaNewsErrorState(message: exception.toString()));
    });
  }

  void change(bool toggle) {
    emit(CoronaNewsSuccessState(
        coronaNewsList: toggle ? _englishList : _urduList));
  }

  void invokeSuccessState() {
    emit(CoronaNewsSuccessState(coronaNewsList: _englishList));
  }
}
