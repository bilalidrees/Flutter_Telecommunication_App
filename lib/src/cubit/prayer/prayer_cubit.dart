import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/model/prayer.dart';
import 'package:ufone_web/src/model/prayer_info.dart';
import 'package:ufone_web/src/resource/repository/prayer_repository.dart';
import 'package:ufone_web/src/ui/ui_constants/resolvers/image_assets_resolver.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerRepository prayerRepository;
  BuildContext context;
  String? sunriseTimeStart, sunsetTimeStart, zawalTimeStart, chashtNamazTime;
  PrayerInfo? _prayerInfo;
  String? currentTime;
  String? nowText, nextText;
  List<Prayer> prayerList = [];

  PrayerCubit(this.prayerRepository,this.context) : super(PrayerInitialState());

  void prayerCubitStatus(bool status) {
    if (!status) {
      emit(PrayerInitialState());
    } else {
      emit(PrayerSuccessState(prayerInfo: _prayerInfo));
    }
  }

  void prayerUpdates(double lat, double long, String city) async {
    prayerList.clear();
    await prayerRepository.getPrayerInformation(lat, long, city).then(
        (prayerInfo) async {
      _prayerInfo = prayerInfo;
      prayerList.add(Prayer(
          namazName: "Fajr",
          namazTime: _prayerInfo!.fajr,
          lightImage: ImageAssetsResolver.LIGHT_THEME,
          darkImage: ImageAssetsResolver.DARK_THEME,
          isCurrentNamaz: false));
      prayerList.add(
        Prayer(
            namazName: "Zuhr",
            namazTime: _prayerInfo!.dhuhr,
            lightImage: ImageAssetsResolver.LIGHT_THEME,
            darkImage: ImageAssetsResolver.DARK_THEME,
            isCurrentNamaz: false),
      );
      prayerList.add(
        Prayer(
            namazName: "Asr",
            namazTime: _prayerInfo!.asr,
            lightImage: ImageAssetsResolver.LIGHT_THEME,
            darkImage: ImageAssetsResolver.DARK_THEME,
            isCurrentNamaz: false),
      );
      prayerList.add(
        Prayer(
            namazName: "Maghrib",
            namazTime: _prayerInfo!.maghrib,
            lightImage: ImageAssetsResolver.LIGHT_THEME,
            darkImage: ImageAssetsResolver.DARK_THEME,
            isCurrentNamaz: false),
      );
      prayerList.add(
        Prayer(
            namazName: "Isha",
            namazTime: _prayerInfo!.isha,
            lightImage: ImageAssetsResolver.LIGHT_THEME,
            darkImage: ImageAssetsResolver.DARK_THEME,
            isCurrentNamaz: false),
      );
      await getPrayerTime();

      emit(PrayerSuccessState(prayerInfo: _prayerInfo));
    }, onError: (exception) {
      emit(PrayerErrorState(message: exception.toString()));
    });
  }

  Future<void> getPrayerTime() async {
    // GETTING ZAWAL AND SUNRISE TIME START
    sunriseTimeStart = await getDecreasedTime(_prayerInfo!.sunrise, 15);
    sunsetTimeStart = await getDecreasedTime(_prayerInfo!.sunset, 6);
    zawalTimeStart = await getDecreasedTime(_prayerInfo!.dhuhr, 40);
    chashtNamazTime = await getDecreasedTime(zawalTimeStart, 120);
    currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
    await setPrayerTimeImages();
    await getHeadingText();
  }

  Future<String> getDecreasedTime(String? time, int decreaseFactor) async {
    List<String> splittedTime = time!.split(':');
    DateTime prayerTime = DateTime(
        0, 0, 0, int.parse(splittedTime[0]), int.parse(splittedTime[1]), 0, 0);
    prayerTime = DateTime(0, 0, 0, int.parse(splittedTime[0]),
        prayerTime.minute - decreaseFactor, 0, 0);
    String hr = "0${prayerTime.hour}";
    hr = hr.substring(hr.length - 2);
    String mnt = "0${prayerTime.minute}";
    mnt = mnt.substring(mnt.length - 2);
    return "$hr:$mnt";
  }

  Future<bool> setPrayerTimeImages() async {
    if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.fajr}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.sunrise}")!) {
      prayerList[0].isCurrentNamaz = true;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.sunrise}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.dhuhr}")!) {
      prayerList[0].isCurrentNamaz = false;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.dhuhr}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.asr}")!) {
      prayerList[1].isCurrentNamaz = true;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.asr}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds(sunsetTimeStart!)!) {
      prayerList[2].isCurrentNamaz = true;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds(sunsetTimeStart!)! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.maghrib}")!) {
      prayerList[2].isCurrentNamaz = false;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.maghrib}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.isha}")!) {
      prayerList[3].isCurrentNamaz = true;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.isha}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds('23:59:59')!) {
      prayerList[4].isCurrentNamaz = true;
    } else if (getIntoSeconds(currentTime!)! >= getIntoSeconds('00:00:00')! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.fajr}")!) {
      prayerList[4].isCurrentNamaz = true;
    }
    return true;
  }

  int? getIntoSeconds(String? time) {
    List<String> splittedTime = time!.split(':');
    int hr_sec = int.parse(splittedTime[0]) * 60 * 60;
    int min_sec = int.parse(splittedTime[1]) * 60;
    return hr_sec + min_sec;
  }

  getHeadingText() async {
    if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.fajr}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds(sunriseTimeStart)!) {
      nowText =  AppLocalizations.of(context)!.translate(AppString.nowFajr);
     // nowText = "Now Fajr";
   //   nextText = "Next Sunrise";
      nextText=  AppLocalizations.of(context)!.translate(AppString.nextSunrise);
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds(sunriseTimeStart)! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.sunrise}")!) {
      nowText =  AppLocalizations.of(context)!.translate(AppString.nowFajr);
      nextText=  AppLocalizations.of(context)!.translate(AppString.nextSunrise);
      // nowText = "Now Fajr";
      // nextText = "Next Sunrise";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.sunrise}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds(chashtNamazTime)!) {
      nowText =  AppLocalizations.of(context)!.translate(AppString.nowIshraq);
    nextText =  AppLocalizations.of(context)!.translate(AppString.nextChash);
      // nowText = "Now Ishraq";
      // nextText = "Next Chasht";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds(chashtNamazTime)! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds(zawalTimeStart)!) {
      nowText =  AppLocalizations.of(context)!.translate(AppString.nowIshraq);
      nextText =  AppLocalizations.of(context)!.translate(AppString.nextZawal);
      // nowText = "Now Chasht";
      // nextText = "Next Zawal";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds(zawalTimeStart)! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.dhuhr}")!) {
      nowText =  AppLocalizations.of(context)!.translate(AppString.zawalTime);
      nextText = "${AppLocalizations.of(context)!.translate(AppString.nextZuhr)} ${_prayerInfo!.dhuhr}" ;
      // nowText = "Zawal Time";
      // nextText = "Next Zuhr ${_prayerInfo!.dhuhr}";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.dhuhr}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.asr}")!) {
      nowText =  AppLocalizations.of(context)!.translate(AppString.nowZuhr);
      nextText = "${AppLocalizations.of(context)!.translate(AppString.nextAsr)} ${_prayerInfo!.asr}" ;
      // nowText = "Now Zuhr";
      // nextText = "Next Asr ${_prayerInfo!.asr}";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.asr}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds(sunsetTimeStart!)!) {
      nowText =  AppLocalizations.of(context)!.translate(AppString.nowAsr);
      nextText = "${AppLocalizations.of(context)!.translate(AppString.nextSunset)}" ;
      // nowText = "Now Asr";
      // nextText = "Next Sunset";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds(sunsetTimeStart!)! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.maghrib}")!) {
      nowText =  AppLocalizations.of(context)!.translate(AppString.nowAsr);
      nextText = "${AppLocalizations.of(context)!.translate(AppString.nextSunset)}" ;
      // nowText = "Now Asr";
      // nextText = "Next Sunset";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.maghrib}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.isha}")!) {
      nowText =  AppLocalizations.of(context)!.translate(AppString.nowMaghrib);
      nextText = "${AppLocalizations.of(context)!.translate(AppString.nextIsha)} ${_prayerInfo!.isha}" ;
      // nowText = "Now Maghrib";
      // nextText = "Next Ish ${_prayerInfo!.isha}";
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.isha}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds('23:59:59')!) {
    nowText =  AppLocalizations.of(context)!.translate(AppString.nowIsha);
    nextText = "${AppLocalizations.of(context)!.translate(AppString.nextFajr)}${_prayerInfo!.fajr}" ;
      // nowText = "Now Isha";
      // nextText = "Next Fajr ${_prayerInfo!.fajr}";
    } else if (getIntoSeconds(currentTime!)! >= getIntoSeconds('00:00:00')! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.fajr}")!) {
      nowText =  AppLocalizations.of(context)!.translate(AppString.nowIsha);
      nextText = "${AppLocalizations.of(context)!.translate(AppString.nextFajr)}${_prayerInfo!.fajr}" ;
      // nowText = "Now Isha";
      // nextText = "Next Fajr ${_prayerInfo!.fajr}";
      // nextText = "${_prayerInfo!.fajr} Next Fajr ";
    }
  }
}
