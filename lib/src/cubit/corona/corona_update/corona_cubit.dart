import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ufone_web/src/model/corona_news.dart';
import 'package:ufone_web/src/model/corona_update.dart';
import 'package:ufone_web/src/model/country_stats.dart';
import 'package:ufone_web/src/resource/network/network_constants.dart';
import 'package:ufone_web/src/resource/repository/corona_repository.dart';

part 'corona_state.dart';

class CoronaCubit extends Cubit<CoronaState> {
  final CoronaRepository coronaRepository;
  CoronaUpdate? _coronaUpdate;

  CoronaUpdate? get coronaUpdate => _coronaUpdate;

  CoronaCubit({required this.coronaRepository}) : super(CoronaInitialState());

  void getCoronaUpdates() async {
    emit(CoronaLoadingState());
    await coronaRepository.getCoronaStats().then((coronaUpdate) async {
      _coronaUpdate = coronaUpdate;
      CountryStats totalStats = _coronaUpdate!.worldwide!.data!.last;
      _coronaUpdate!.worldwide!.data!.removeLast();
      _coronaUpdate!.worldwide!.data!.insert(0, totalStats);
      emit(CoronaSuccessState(coronaUpdate: _coronaUpdate));
    }, onError: (exception) {
      if (exception is int) {
        emit(CoronaErrorState(errorType: exception));
      } else {
        emit(CoronaErrorState(message: exception.toString()));
      }
    });
  }
}
