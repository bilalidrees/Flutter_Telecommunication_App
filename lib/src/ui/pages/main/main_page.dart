// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/bloc/authentication_bloc.dart';
import 'package:ufone_web/src/bloc/news_bloc.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/cubit/corona/corona_update/corona_cubit.dart';
import 'package:ufone_web/src/cubit/finance/finance_cubit.dart';
import 'package:ufone_web/src/cubit/prayer/prayer_cubit.dart';
import 'package:ufone_web/src/cubit/weather/weather_cubit.dart';
import 'package:ufone_web/src/model/weather.dart';
import 'package:ufone_web/src/provider/geolocation_proivder.dart';
import 'package:ufone_web/src/ui/pages/drawer_section/about_page.dart';
import 'package:ufone_web/src/ui/pages/drawer_section/quran_page/al_quran_page.dart';
import 'package:ufone_web/src/ui/pages/drawer_section/setting_page.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/style.dart';
import 'package:ufone_web/src/ui/widgets/custom_drawer.dart';
import 'package:ufone_web/src/ui/widgets/drawer_category.dart';

class MainPage1 extends StatefulWidget {
  int? currentTab = 0;
  String currentTitle;
  Widget currentPage;
  String? currentDeliveryAddress;

  MainPage1(
      {Key? key,
      this.currentTab,
      required this.currentPage,
      required this.currentTitle})
      : super(key: key);

  @override
  _MainPage1State createState() => _MainPage1State();
}

class _MainPage1State extends State<MainPage1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<CustomDrawerState> _drawerKey =
      new GlobalKey<CustomDrawerState>();
  AuthenticationBloc? authenticationBloc;
  NewsBloc? mainPageBloc;

  initState() {
    authenticationBloc = AuthenticationBloc.getInstance();
    authenticationBloc!.loginDrawerStream.listen((event) {
      _drawerKey.currentState!.toggleDrawer();
    });
    super.initState();
  }

  final SizedBox sizedBox = const SizedBox(height: 25);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Container(
            child: Column(
              children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(
                    AppLocalizations.of(context)!.translate(AppString.menu),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppColors.orangeColor),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close),
                        color: AppColors.orangeColor),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: CircleAvatar()),
                          Expanded(
                              flex: 3,
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .translate(AppString.WELCOME)!,
                                  style:
                                      Theme.of(context).textTheme.bodyText1)),
                        ],
                      ),
                      SizedBox(height: 20),
                      DrawerCategory(Icons.home, AppString.HOME, AboutPage(),drawEum: DrawEum.home),
                      // sizedBox,
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //   child: Text('Apps',
                      //       style: Theme.of(context).textTheme.bodyText1),
                      // ),
                      sizedBox,
                      Divider(thickness: 1),
                      sizedBox,
                      DrawerCategory(
                        Icons.book,
                        AppString.al_quran,
                        AlQuranPage(),
                        drawEum: DrawEum.quran,
                      ),
                      sizedBox,
                      DrawerCategory(
                          Icons.translate, AppString.LANGUAGE, AboutPage(),
                          drawEum: DrawEum.language),
                      sizedBox,
                      DrawerCategory(Icons.settings, AppString.SETTINGS,
                          SettingPage(homeCardsOptionCallback: (index, value) {
                        print('$index, $value');
                        switch (index) {
                          case 0:
                            if (!value) {
                              BlocProvider.of<CoronaCubit>(context)
                                  .emit(CoronaInitialState());
                            } else {
                              BlocProvider.of<CoronaCubit>(context)
                                  .getCoronaUpdates();
                            }
                            break;
                          case 1:
                            if (!value) {
                              BlocProvider.of<PrayerCubit>(context)
                                  .emit(PrayerInitialState());
                            } else {
                              BlocProvider.of<PrayerCubit>(context)
                                  .prayerUpdates(
                                  context.read<GeoLocationProvider>().position.latitude,
                                  context.read<GeoLocationProvider>().position.longitude,
                                  context.read<GeoLocationProvider>().city);
                            }
                            break;
                          case 2:
                            if (!value) {
                              BlocProvider.of<WeatherCubit>(context)
                                  .emit(WeatherInitial());
                            } else {
                              BlocProvider.of<WeatherCubit>(context)
                                  .getWeatherUpdates(
                                  context.read<GeoLocationProvider>().position.latitude,
                                  context.read<GeoLocationProvider>().position.longitude);
                            }
                            break;
                          case 3:
                            if (!value) {
                              BlocProvider.of<FinanceCubit>(context)
                                  .emit(FinanceInitial());
                            } else {
                              BlocProvider.of<FinanceCubit>(context)
                                  .getFinanceUpdates();
                            }
                            break;

                        }
                      }), drawEum: DrawEum.setting),
                      sizedBox,
                      DrawerCategory(Icons.error, AppString.ABOUT, AboutPage(),
                          drawEum: DrawEum.about),
                      sizedBox,
                    ],
                  ),
                ),
              ],
            ),
          ),
          // child: Container(
          //   alignment: Alignment.center,
          //   color: Colors.white,
          //   child: Column(
          //     children: [
          //       Consumer<DomesticToInternation>(
          //         builder: (context,locale,child){
          //           return Switch(
          //             value: locale.localeState,
          //             onChanged:locale.changeEnglishToUrdu,
          //             activeTrackColor: AppColors.greenColor,
          //             activeColor: Colors.white,
          //           );
          //         },
          //       ),
          //
          //     ],
          //   ),
          // ),
        ),
        key: _scaffoldKey,
        appBar: AppBar(
          title: getTitleText(),
          // backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
              icon: widget.currentTitle ==
                      AppLocalizations.of(context)!
                          .translate(AppString.MAIN_PAGE)
                  ? Icon(
                      Icons.dehaze,
                      color: Colors.orange,
                    )
                  : Icon(Icons.arrow_back, color: Colors.orange),
              onPressed: () {
                if (widget.currentTitle !=
                    AppLocalizations.of(context)!
                        .translate(AppString.MAIN_PAGE)) {
                  Navigator.pop(context);
                } else {
                  _scaffoldKey.currentState!.openDrawer();
                }
              }),
          //automaticallyImplyLeading: true,
          centerTitle: false,
        ),
        body: widget.currentPage,
      ),
    );
  }

  Text getTitleText() {
    String titleText;
    if (widget.currentTitle != null)
      titleText = widget.currentTitle;
    else
      titleText = "Main Page";
    return Text(titleText,
        style: Styles.getDrawerItemStyle(
            color: AppColors.greenColor,
            fontSize: AppConfig.of(context).appWidth(4.5),
            fontWeight: FontWeight.w400),
        textAlign: TextAlign.center);
  }
}
