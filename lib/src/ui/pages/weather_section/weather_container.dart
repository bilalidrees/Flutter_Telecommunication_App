import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/route_generator.dart';
import 'package:ufone_web/src/app.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/cubit/weather/weather_cubit.dart';
import 'package:ufone_web/src/model/weather.dart';
import 'package:ufone_web/src/model/weekly.dart';
import 'package:ufone_web/src/provider/theme_provider.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/widgets/humidity_text.dart';
import 'package:ufone_web/src/ui/widgets/main_container.dart';
import 'package:ufone_web/src/ui/widgets/temperature_text.dart';
import 'package:provider/provider.dart';
class WeatherContainer extends StatelessWidget {
  final Weather weather;
  List<Weekly>? weekly = [];

  WeatherContainer({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    weekly = weather.weekly!.take(6).toList();
    weekly!.removeAt(0);
    weekly;
    return InkWell(
      onTap: () {
        FirebaseAnalyticsObservers.firebaseObserver.analytics.logEvent(
            name: "weather_event${weather.datetime}");
        Navigator.pushNamed(context, RouteNames.WEATHERDETAILPAGE,
            arguments: ScreenArguments(data: weather));
      },
      child: MainContainer(
        boxDecoration: BoxDecoration(
          color: context.watch<ThemeProvider>().selectedTheme
              ? AppColors.itemBackgroundScreenColor
              : Colors.white,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: AppConfig.of(context).appWidth(6.0),
            vertical: AppConfig.of(context).appWidth(4.5)),
        margin:
            EdgeInsets.symmetric(vertical: AppConfig.of(context).appWidth(4.5)),
        height: 105,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset(
                          WeatherCubit.getWeatherImage(
                              weather.currently!.icon!),
                          width: AppConfig.of(context).appWidth(30),
                          height: AppConfig.of(context).appWidth(35),
                        ),
                        Text(
                          weather.currently!.summary!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize:
                                      AppConfig.of(context).appWidth(4.3)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.translate(weather.city!),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: AppConfig.of(context).appWidth(8),
                                    )),
                        SizedBox(height: AppConfig.of(context).appWidth(2)),
                        TemperatureText(
                            value: weather.currently!.temperature!,
                            valueSize: 8,
                            mainAxisAlignment: MainAxisAlignment.start),
                        SizedBox(height: AppConfig.of(context).appWidth(2)),
                        HumidityText(
                            value: weather.getRound(
                          weather.currently!.humidity,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.orangeColor),
            Expanded(
              child: Row(
                children: weekly!
                    .asMap()
                    .map((i, element) {
                      return MapEntry(
                          i,
                          Expanded(
                            child: Container(
                              height: AppConfig.of(context).appWidth(38),
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                              padding: EdgeInsets.symmetric(
                                horizontal: AppConfig.of(context).appWidth(1.5),
                              ),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0, 1.5),
                                        blurRadius: 1)
                                  ],
                                  color: context.watch<ThemeProvider>().selectedTheme
                                      ? AppColors.itemBackgroundScreenColor
                                      : Colors.white,
                                  border: Border.all(
                                      width: 0.1, color: Colors.grey[50]!)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: AppConfig.of(context).appWidth(3),
                                  ),
                                  Text('${weather.getRound(element.humidity)}%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                          fontSize: AppConfig.of(context)
                                              .appWidth(3),
                                          fontWeight: FontWeight.w300)),
                                  SizedBox(
                                    height: AppConfig.of(context).appWidth(2),
                                  ),
                                  Image.asset(WeatherCubit.getWeatherImage(
                                      element.icon!)),
                                  SizedBox(
                                    height: AppConfig.of(context).appWidth(2),
                                  ),
                                  TemperatureText(
                                      value: element.temperatureLow!,
                                      valueSize: 4),
                                  SizedBox(
                                    height: AppConfig.of(context).appWidth(1),
                                  ),
                                  Text(
                                    WeatherCubit.getDateFromTimeStamp(
                                        element.time!),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                        fontSize:
                                        AppConfig.of(context).appWidth(3),
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: AppConfig.of(context).appWidth(1),
                                  ),
                                ],
                              ),
                            ),
                          ));
                })
                    .values
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
