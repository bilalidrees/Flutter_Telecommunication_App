part of 'prayer_cubit.dart';

@immutable
abstract class PrayerState {}

class PrayerInitialState extends PrayerState {
  PrayerInitialState();
}

class PrayerLoadingState extends PrayerState {
  bool? isVisible;

  PrayerLoadingState({isVisible});
}

// ignore: must_be_immutable
class PrayerSuccessState extends PrayerState {
  bool? isSuccess;
  PrayerInfo? prayerInfo;
  List<Prayer>? prayerList;
  PrayerSuccessState({this.isSuccess,this.prayerInfo,this.prayerList});
}

class PrayerErrorState extends PrayerState {
  final String? message;

  PrayerErrorState({this.message});
}
