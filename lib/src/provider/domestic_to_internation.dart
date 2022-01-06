import 'package:flutter/material.dart';

class DomesticToInternation with ChangeNotifier{
  bool _state = true;
  bool get state=>_state;
  void changeDomesticToInternation(){
    _state =!_state;
    notifyListeners();
  }

  bool _localeState= true;
  bool get localeState=>_localeState;
  void changeEnglishToUrdu(bool value){
    _localeState =value;
    notifyListeners();
  }
}