import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/cubit/weather/weather_cubit.dart';
import 'package:ufone_web/src/model/weather.dart';
import 'package:ufone_web/src/ui/ui_constants/resolvers/image_assets_resolver.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';
import 'package:ufone_web/src/ui/widgets/humidity_text.dart';
import 'package:ufone_web/src/ui/widgets/main_container.dart';
import 'package:ufone_web/src/ui/widgets/temperature_text.dart';
import 'package:ufone_web/src/ui/widgets/web_app_bar.dart';

class WeatherDetailPage extends StatelessWidget {
  final Weather weather;

  const WeatherDetailPage({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: WebAppBar(appBarMessage: AppString.weather_details),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.asset(
                  ImageAssetsResolver.WEATHER_BACKGROUND,
                ).image,
                fit: BoxFit.fill),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppConfig.of(context).appWidth(4.5),
                  horizontal: 10),
              child: Column(
                children: [
                  Text(AppLocalizations.of(context)!.translate(weather.city!),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: AppConfig.of(context).appWidth(10))),
                  SizedBox(height: AppConfig.of(context).appWidth(2.5)),
                  Container(
                    height: AppConfig.of(context).appWidth(55),
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: Row(
                      children: [
                        Expanded(
                          child: Image.asset(WeatherCubit.getWeatherImage(
                              weather.currently!.icon!)),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                weather.currently!.summary!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize:
                                            AppConfig.of(context).appWidth(5)),
                              ),
                              Text(
                                WeatherCubit.getDateFromTimeStamp(
                                    weather.currently!.time!),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize:
                                            AppConfig.of(context).appWidth(5),
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppConfig.of(context).appWidth(3.5)),
                  Row(
                    children: [
                      Expanded(
                          child: _TemperatureSection(
                        tempText: AppString.low_Temperature,
                        imgSource: ImageAssetsResolver.lowTemp,
                        value: weather.weekly![0].temperatureLow!,
                      )),
                      Expanded(
                          child: _TemperatureSection(
                        tempText: AppString.high_Temperature,
                        imgSource: ImageAssetsResolver.highTemp,
                        value: weather.weekly![0].temperatureHigh!,
                      )),
                    ],
                  ),
                  SizedBox(height: AppConfig.of(context).appWidth(3.5)),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppConfig.of(context).appWidth(2),
                        vertical: AppConfig.of(context).appWidth(2)),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greenColor, width: 1),
                    ),
                    height: AppConfig.of(context).appWidth(40),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.network(ImageAssetsResolver.humidity,
                                height: 85, width: 50),
                            HumidityText(
                                value: weather
                                    .getRound(weather.weekly![0].humidity),
                                color: Colors.white,
                                size: 5),
                          ],
                        ),
                        Column(
                          children: [
                            Image.network(ImageAssetsResolver.uv_index,
                                height: 85, width: 50),
                            UVText(
                                value: weather
                                    .getRound(weather.currently!.uvIndex),
                                color: Colors.white,
                                size: 5),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _RowText(
                    string: AppString.feels_Like,
                    value: weather.currently!.apparentTemperature!,
                    degree: true,
                  ),
                  _RowText(
                      string: AppString.precipitation_Probability,
                      value: weather.currently!.precipProbability!),
                  _RowText(
                      string: AppString.precipitation_Intensity,
                      value: weather.currently!.precipIntensity!),
                  SizedBox(height: AppConfig.of(context).appWidth(3.5)),
                  Container(
                    height: AppConfig.of(context).appWidth(50),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        //color: Color(0xffFFE3E3),
                        ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: weather.weekly!.length,
                      itemBuilder: (context, index) {
                        int count = index == weather.weekly!.length - 1
                            ? index
                            : index+1;
                        return Container(
                          width: AppConfig.of(context).appWidth(23.0),
                          // height: AppConfig.of(context).appWidth(34),
                          margin: EdgeInsets.symmetric(
                              horizontal: AppConfig.of(context).appWidth(3.0)),
                          // padding: EdgeInsets.symmetric(
                          //   horizontal: AppConfig.of(context).appWidth(1.5),
                          // ),
                          decoration: BoxDecoration(
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.5),
                            //     spreadRadius: 5,
                            //     blurRadius: 7,
                            //     offset: Offset(0, 3), // changes position of shadow
                            //   ),
                            // ],
                            color: Colors.transparent,
                            border: Border(
                                top:
                                    BorderSide(width: 0.5, color: Colors.black),
                                right:
                                    BorderSide(width: 0.5, color: Colors.black),
                                left:
                                    BorderSide(width: 0.5, color: Colors.black),
                                bottom: BorderSide(
                                    width: 1.5, color: Colors.black)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: AppConfig.of(context).appWidth(3),
                              ),
                              Text(
                                  '${weather.getRound(weather.weekly![count].humidity)}%',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize:
                                              AppConfig.of(context).appWidth(4),
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white)),
                              SizedBox(
                                height: AppConfig.of(context).appWidth(2),
                              ),
                              Image.asset(
                                WeatherCubit.getWeatherImage(
                                    weather.weekly![count].icon!),
                              ),
                              SizedBox(
                                height: AppConfig.of(context).appWidth(2),
                              ),
                              TemperatureText(
                                  degree: 2,
                                  color: Colors.white,
                                  value: weather.weekly![count].temperatureLow!,
                                  valueSize: 4),
                              SizedBox(
                                height: AppConfig.of(context).appWidth(1),
                              ),
                              Text(
                                WeatherCubit.getDateFromTimeStamp(
                                    weather.weekly![count].time!),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize:
                                            AppConfig.of(context).appWidth(4),
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                height: AppConfig.of(context).appWidth(1),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TemperatureSection extends StatelessWidget {
  final String imgSource;
  final String tempText;
  final double value;

  const _TemperatureSection(
      {Key? key,
      required this.value,
      required this.imgSource,
      required this.tempText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        AppLocalizations.of(context)!.translate(tempText),
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.white, fontSize: AppConfig.of(context).appWidth(4.9)),
      ),
      Image.network(imgSource,
          height: AppConfig.of(context).appWidth(30),
          width: AppConfig.of(context).appWidth(10)),
      TemperatureText(
        value: value,
        color: Colors.white,
        valueSize: AppConfig.of(context).appWidth(3.9),
      ),
    ]);
  }
}

class _RowText extends StatelessWidget {
  final String string;
  final dynamic value;
  final double size;
  final Color color;
  final bool degree;

  const _RowText(
      {Key? key,
      required this.string,
      required this.value,
      this.degree = false,
      this.size = 5,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: AppConfig.of(context).appWidth(2.5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.translate(string),
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: color, fontSize: AppConfig.of(context).appWidth(size)),
          ),
          degree
              ? TemperatureText(
                  value: value,
                  color: color,
                  valueSize: size,
                )
              : Text(
                  value.toString(),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: color,
                      fontSize: AppConfig.of(context).appWidth(size)),
                ),
        ],
      ),
    );
  }
}
