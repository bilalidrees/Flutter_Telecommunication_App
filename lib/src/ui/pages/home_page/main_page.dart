import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/cubit/finance/finance_cubit.dart';
import 'package:ufone_web/src/cubit/weather/weather_cubit.dart';
import 'package:ufone_web/src/model/Weather.dart';
import 'package:ufone_web/src/provider/geolocation_proivder.dart';
import 'package:ufone_web/src/resource/provider/prayer_provider.dart';
import 'package:ufone_web/src/ui/pages/finance/finance_widget.dart';
import 'package:ufone_web/src/ui/pages/geo_location_access/geo_location_access.dart';
import 'package:ufone_web/src/ui/pages/weather_section/weather_container.dart';
import 'package:ufone_web/src/ui/widgets/error_widget.dart';
import '../../../cubit/corona/corona_update/corona_cubit.dart';
import 'package:ufone_web/src/cubit/prayer/prayer_cubit.dart';
import 'package:ufone_web/src/ui/pages/home_page/local_and_gobal_wrapper.dart';
import 'package:ufone_web/src/ui/pages/home_page/salah_time_container.dart';
import 'package:ufone_web/src/ui/pages/local_detail_page/local_detail_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {

    WidgetsBinding.instance!.addPostFrameCallback((_) {

    });
    BlocProvider.of<CoronaCubit>(context).getCoronaUpdates();
    BlocProvider.of<FinanceCubit>(context).getFinanceUpdates();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    Provider.of<GeoLocationProvider>(context);
    if (context.read<GeoLocationProvider>().state == GeoLocationState.loaded) {


      BlocProvider.of<PrayerCubit>(context).prayerUpdates(
          context.read<GeoLocationProvider>().position.latitude,
          context.read<GeoLocationProvider>().position.longitude,
          context.read<GeoLocationProvider>().city);
      BlocProvider.of<WeatherCubit>(context).getWeatherUpdates(
          context.read<GeoLocationProvider>().position.latitude,
          context.read<GeoLocationProvider>().position.longitude);

    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding:
          EdgeInsets.symmetric(horizontal: AppConfig.of(context).appWidth(2.9)),
      //padding:  EdgeInsets.symmetric(horizontal: 10),
      children: [
        BlocConsumer<CoronaCubit, CoronaState>(
          listener: (context, state) {
            if (state is CoronaErrorState) {
            }
            // final snackBar = SnackBar(content: Text(context.read<GeoLocationProvider>().city));
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);

          },
          builder: (context, state) {
            if(state is CoronaInitialState){
              return SizedBox.shrink();
            }
            else if(state is CoronaLoadingState){
              return Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppConfig.of(context).appWidth(25)),
                    child: CircularProgressIndicator(),
                  ));
            }
            else if (state is CoronaSuccessState) {
              return CoronavirusContainer(coronaUpdate: state.coronaUpdate);
            }
            else  if (state is CoronaErrorState){
              return SizedBox.shrink();
            }else{
              return SizedBox.shrink();
            }
          },
        ),
        BlocConsumer<PrayerCubit, PrayerState>(
          builder: (context, state) {
            if(state is PrayerInitialState){
              return SizedBox.shrink();
            }
            else if (state is PrayerSuccessState) {
              return SalahTime(
                prayerInfo: state.prayerInfo!,
              );
            }else if (state is PrayerLoadingState){
              return const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            else  if (state is PrayerErrorState){
              return SizedBox.shrink();
            }else{
              return SizedBox.shrink();
            }
          },
          listener: (context, state) {
            if (state is PrayerErrorState) {
              // Toast.show("${state.message}", context,
              //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            }
          },
        ),
        BlocConsumer<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if(state is WeatherInitial){
              return SizedBox.shrink();
            }
            else if (state is WeatherSuccessState) {
              return WeatherContainer(weather: state.weather!);
            }else if (state is WeatherLoadingState){
              return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            else if (state is WeatherErrorState){
              return SizedBox.shrink();
            }
            else {
              return SizedBox.shrink();
            }
          },
          listener: (context, state) {
            if (state is PrayerErrorState) {
              // Toast.show("${state.message}", context,
              //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            }
          },
        ),
        BlocConsumer<FinanceCubit, FinanceState>(
          builder: (context, state) {
            if(state is FinanceInitial){
              return SizedBox.shrink();
            }
            else if(state is FinanceLoadingState){
              return const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            else if (state is FinanceSuccessState) {
              return FinanceWidget(
                kseRateFinance: state.kseRateFinance,
                forexFinance: state.forexFinance,
              );
            } else if (state is FinanceErrorState){
              return SizedBox.shrink();
            }
            else {
              return SizedBox.shrink();
            }
          },
          listener: (context, state) {
            if (state is PrayerErrorState) {
              // Toast.show("${state.message}", context,
              //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            }
          },
        )
      ],
    );
  }
}
