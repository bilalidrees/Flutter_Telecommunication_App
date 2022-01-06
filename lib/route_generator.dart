import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ufone_web/src/app.dart';
import 'package:ufone_web/src/cubit/corona/corona_news/corona_news_cubit.dart';
import 'package:ufone_web/src/cubit/finance/finance_cubit.dart';
import 'package:ufone_web/src/cubit/prayer/prayer_cubit.dart';
import 'package:ufone_web/src/cubit/weather/weather_cubit.dart';
import 'package:ufone_web/src/resource/repository/finance_repository.dart';
import 'package:ufone_web/src/resource/repository/prayer_repository.dart';
import 'package:ufone_web/src/resource/repository/weather_repository.dart';
import 'package:ufone_web/src/ui/pages/global_detail_page/global_detail_page.dart';
import 'package:ufone_web/src/bloc/bloc_provider.dart' as bloc;
import 'package:ufone_web/src/bloc/news_bloc.dart';
import 'package:ufone_web/src/ui/pages/home_page/main_page.dart';
import 'package:ufone_web/src/ui/pages/local_detail_page/corona_news_detail.dart';
import 'package:ufone_web/src/ui/pages/local_detail_page/local_detail_page.dart';
import 'package:ufone_web/src/ui/pages/local_detail_page/local_detail_see_all_page.dart';
import 'package:ufone_web/src/ui/pages/prayer_time_detail_page/prayer_time_detail_page.dart';
import 'package:ufone_web/src/ui/pages/main/main_page.dart';
import 'package:ufone_web/src/ui/pages/main/splash_screen.dart';
import 'package:ufone_web/src/ui/pages/news/news_detail_page.dart';
import 'package:ufone_web/src/ui/pages/weather_section/weather_deatail_page.dart';

import 'src/cubit/corona/corona_update/corona_cubit.dart';
import 'src/resource/repository/corona_repository.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    ScreenArguments args;
    if (settings.arguments != null)
      args = settings.arguments as ScreenArguments;
    else
      args = ScreenArguments();
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => RouteAwareWidget("/", child: SplashScreen()));
      case RouteNames.MAINPAGE:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider<CoronaCubit>(
                    create: (context) => CoronaCubit(
                        coronaRepository: CoronaRepository.getInstance()!)),
                BlocProvider<CoronaNewsCubit>(
                    create: (context) => CoronaNewsCubit(
                        coronaRepository: CoronaRepository.getInstance()!)),
                BlocProvider<PrayerCubit>(
                    create: (context) => PrayerCubit(PrayerRepository(),context)),
                BlocProvider<FinanceCubit>(
                    create: (context) =>
                        FinanceCubit(financeRepository: FinanceRepository())),
                BlocProvider<WeatherCubit>(
                    create: (context) =>
                        WeatherCubit(weatherRepository: WeatherRepository())),
              ],
              child: RouteAwareWidget(
                RouteNames.MAINPAGE,
                child: MainPage1(
                    currentPage: args.currentPage!,
                    currentTitle: args.message!),
              )),
        );

      case RouteNames.NEWS_DETAILS:
        return MaterialPageRoute(
            builder: (_) => RouteAwareWidget(RouteNames.NEWS_DETAILS,
                child: NewsDetailPage(
                    newsFeed: args.data, sourceLogo: args.message!)));
      // case "/":
      //   return MaterialPageRoute(
      //       builder: (_) => RouteAwareWidget("/", child: HomePage()));
      case RouteNames.HOMEPAGE:
      // MaterialPageRoute(
      //    builder: (_) => BlocProvider<CoronaCubit>(
      //          create: (context) => CoronaCubit(CoronaRepository()),
      //          child:
      //              RouteAwareWidget(RouteNames.HOMEPAGE, child: MainPage()),
      //        ));
      // return MaterialPageRoute(
      //     builder: (_) => MultiBlocProvider(
      //           providers: [
      //             // BlocProvider<CoronaCubit>(
      //             //     create: (context) => CoronaCubit(CoronaRepository())),
      //             BlocProvider<PrayerCubit>(
      //                 create: (context) => PrayerCubit(PrayerRepository())),
      //           ],
      //           child:
      //               RouteAwareWidget(RouteNames.HOMEPAGE, child: MainPage()),
      //         ));

      case RouteNames.LOCALDETAIL:
        return MaterialPageRoute<LocalDetailPage>(
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<CoronaNewsCubit>(args.buildContext!),
            child: LocalDetailPage(
                coronaUpdate: args.data, appBarMessage: args.message),
          ),
        );

      case RouteNames.LOCALDETAILSEEALL:
        return MaterialPageRoute<LocalDetailSeeAll>(
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<CoronaNewsCubit>(args.buildContext!),
            child: LocalDetailSeeAll(
              appBarMessage: args.message,
            ),
          ),
        );
      case RouteNames.LOCAL_NEWS_DETAIL:
        return MaterialPageRoute<LocalDetailSeeAll>(
          builder: (_) => CoronaNewsDetails(
            coronaNews: args.data,
          ),
        );
      case RouteNames.GLOBALDETAIL:
        return MaterialPageRoute(
            builder: (context) => GlobalDetail(
                coronaUpdate: args.data, appBarMessage: args.message));
      // case RouteNames.PRAYERTIMEDETAIL:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => PrayerTimeDetail());
      case RouteNames.WEATHERDETAILPAGE:
        return MaterialPageRoute(builder: (context)=>WeatherDetailPage(weather: args.data));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Center(
          child: Text(""),
        ),
      );
    });
  }
}

class RouteNames {
  static const String SPLASH = "/welcome";
  static const String MAINPAGE = "/MainPage";
  static const String NEWS_DETAILS = "/NewsDetails";
  static const String SUB_CATEGORY = "/Sub_Category";
  static const String LOGIN = "/Login";
  static const String SIGN_UP = "/SignUp";
  static const String FORGOT_PASSWORD = "/Forgot_Password";
  static const String PROFILE = "/Profile";
  static const String ABOUT = "/ABOUT";

  //covid
  static const String HOMEPAGE = "/homePage";
  static const String LOCALDETAIL = "/localDetail";
  static const String LOCALDETAILSEEALL = '/seeAll';
  static const String LOCAL_NEWS_DETAIL = '/local_news_detail';
  static const String GLOBALDETAIL = '/globalDetail';
  static const String PRAYERTIMEDETAIL = '/PrayerTimeDetail';
  static const String WEATHERDETAILPAGE = '/weatherDetailPage';
}

class ScreenArguments<T> {
  final int? tab;
  final Widget? currentPage;
  final String? message;
  final bool? flag;
  final T? data;
  final T? secondData;
  final BuildContext? buildContext;

  ScreenArguments(
      {this.tab,
      this.currentPage,
      this.message,
      this.data,
      this.secondData,
      this.flag,
      this.buildContext});
}
