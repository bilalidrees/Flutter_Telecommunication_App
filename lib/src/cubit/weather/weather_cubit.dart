import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:ufone_web/src/model/weather.dart';
import 'package:ufone_web/src/resource/repository/weather_repository.dart';
import 'package:ufone_web/src/ui/ui_constants/resolvers/image_assets_resolver.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository? weatherRepository;

  WeatherCubit({required this.weatherRepository}) : super(WeatherInitial());

  void getWeatherUpdates(double lat, double lng) async {
    emit(WeatherLoadingState());
    await weatherRepository!.getWeatherStates(lat.toString(), lng.toString()).then(
        (weather) async {
      emit(WeatherSuccessState(weather: weather));
    }, onError: (exception) {
      print(exception.toString());
      emit(WeatherErrorState(message: exception.toString()));
    });
  }

  static String getWeatherImage(String key) {
    return ImageAssetsResolver.getWeatherImage(key);
  }

  static String getDateFromTimeStamp(int timestamp) {
    List months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var current_mon = time.month;
   // print(months[current_mon - 1]);

    return "${time.day} ${months[current_mon - 1]}";
  }
}
