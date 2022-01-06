import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/resource/provider/prayer_provider.dart';
import 'package:ufone_web/src/ui/pages/news/home_page.dart';
import 'package:ufone_web/src/ui/ui_constants/resolvers/image_assets_resolver.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/String.dart';
import '../../../../route_generator.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5)).then((value) {
      navigateToMainScreen(context);
    });
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Image.asset(
          ImageAssetsResolver.ITGN_IMAGE,
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }

  void navigateToMainScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(RouteNames.MAINPAGE,
        arguments: ScreenArguments(
            currentPage: HomePage(),
            message:
            AppLocalizations.of(context)!.translate(AppString.MAIN_PAGE),
        ));
  }
}
