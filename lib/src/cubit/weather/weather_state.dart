part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoadingState extends WeatherState {
  bool? isVisible;

  WeatherLoadingState({isVisible});
}

// ignore: must_be_immutable
class WeatherSuccessState extends WeatherState {
  bool? isSuccess;
  Weather? weather;

  WeatherSuccessState({required this.weather});
}

class WeatherErrorState extends WeatherState {
  final String? message;

  WeatherErrorState({this.message});
}
