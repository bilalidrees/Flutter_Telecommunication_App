import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/main.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/provider/domestic_to_internation.dart';
import 'package:ufone_web/src/provider/theme_provider.dart';
import '../route_generator.dart';
import 'ui/ui_constants/theme/app_colors.dart';
import 'package:flutter/services.dart';

class App extends StatefulWidget {
  static BuildContext? rootContext;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return context.watch<ThemeProvider>().selectedTheme
            ? Theme(
                data: ThemeData(
                    brightness: Brightness.dark,
                    textTheme: TextTheme(
                      //used as drawer items
                      headline1: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'RobotoCondensed',
                        fontSize: AppConfig.of(context).appWidth(5),
                        // color: AppColors.black,
                      ),
                      //used as main headline items
                      headline2: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'RobotoCondensed',
                        fontSize: AppConfig.of(context).appWidth(7),
                      ),
                      //used as item text 1
                      headline3: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: AppConfig.of(context).appWidth(4),
                        fontWeight: FontWeight.w600,
                      ),
                      //used as item text 2
                      headline4: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: AppConfig.of(context).appWidth(4.3),
                        fontWeight: FontWeight.w400,
                      ),
                      //used as item descriptio
                      // n
                      headline5: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: AppConfig.of(context).appWidth(3.2),
                        fontWeight: FontWeight.w400,
                      ),
                      headline6: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: AppConfig.of(context).appWidth(5),
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                      subtitle1: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors(context).mainColor(1)),
                      subtitle2: TextStyle(
                          fontFamily: 'RobotoCondensed',
                          fontSize: AppConfig.of(context).appWidth(4.5),
                          fontWeight: FontWeight.w300,
                          color: AppColors(context).secondColor(0.7)),
                      bodyText1: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: AppConfig.of(context).appWidth(5),
                        fontWeight: FontWeight.w400,
                      ),
                      bodyText2: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'RobotoCondensed',
                          fontSize: AppConfig.of(context).appWidth(4.2),
                          color: AppColors(context).secondColor(1)),
                    )),
                child: child!)
            : Theme(
                data: ThemeData(
                  fontFamily: 'Roboto',
                  primarySwatch: AppColors.whiteAppBar,
                  primaryColor: Colors.white,
                  scaffoldBackgroundColor: Color(0xFFFFFFFF),
                  accentColor: AppColors(context).mainColor(1),
                  focusColor: AppColors(context).accentColor(1),
                  hintColor: AppColors.timberWolf,
                  //canvasColor: Colors.transparent,
                  brightness: Brightness.light,
                  unselectedWidgetColor: AppColors(context).mainColor(1),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.greenColor)),
                  ),
                  textTheme: TextTheme(
                    //used as drawer items
                    headline1: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'RobotoCondensed',
                      fontSize: AppConfig.of(context).appWidth(5),
                      // color: AppColors.black,
                    ),
                    //used as main headline items
                    headline2: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'RobotoCondensed',
                      fontSize: AppConfig.of(context).appWidth(7),
                    ),
                    //used as item text 1
                    headline3: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      fontSize: AppConfig.of(context).appWidth(4),
                      fontWeight: FontWeight.w600,
                    ),
                    //used as item text 2
                    headline4: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      fontSize: AppConfig.of(context).appWidth(4.3),
                      fontWeight: FontWeight.w400,
                    ),
                    //used as item descriptio
                    // n
                    headline5: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: AppConfig.of(context).appWidth(3.2),
                      fontWeight: FontWeight.w400,
                    ),
                    headline6: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: AppConfig.of(context).appWidth(5),
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                    subtitle1: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors(context).mainColor(1)),
                    subtitle2: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: AppConfig.of(context).appWidth(4.5),
                        fontWeight: FontWeight.w300,
                        color: AppColors(context).secondColor(0.7)),
                    bodyText1: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: AppConfig.of(context).appWidth(5),
                        fontWeight: FontWeight.w400,
                        color: AppColors(context).secondColor(0.6)),
                    bodyText2: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'RobotoCondensed',
                        fontSize: AppConfig.of(context).appWidth(4.2),
                        color: AppColors(context).secondColor(1)),
                  ),
                ),
                child: child!,
              );
      },
      // locale: Locale.fromSubtags(countryCode: 'US', languageCode: 'en'),
      // locale: Locale.fromSubtags(countryCode: 'PK', languageCode: 'ur'),
      locale: Provider.of<DomesticToInternation>(context).localeState
          ? Locale.fromSubtags(countryCode: 'US', languageCode: 'en')
          : Locale.fromSubtags(countryCode: 'PK', languageCode: 'ur'),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ur', 'PK'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      // home: SplashScreen(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        RouteObservers.routeObserver,
        FirebaseAnalyticsObservers.firebaseObserver,
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class RouteObservers {
  static RouteObserver<void> routeObserver = RouteObserver<PageRoute>();
}

class FirebaseAnalyticsObservers {
  static FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver firebaseObserver =
      FirebaseAnalyticsObserver(analytics: firebaseAnalytics);
}

class RouteAwareWidget extends StatefulWidget {
  final String name;
  final Widget child;

  RouteAwareWidget(this.name, {required this.child});

  @override
  State<RouteAwareWidget> createState() => RouteAwareWidgetState();
}

class RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteObservers.routeObserver.subscribe(this, ModalRoute.of(context));
    FirebaseAnalyticsObservers.firebaseObserver
        .subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    RouteObservers.routeObserver.unsubscribe(this);
    FirebaseAnalyticsObservers.firebaseObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    FirebaseAnalyticsObservers.firebaseObserver.analytics.setCurrentScreen(
      screenName: 'Screen Name: ${widget.name}',
    );
  }

  @override
  // Called when the top route has been popped off, and the current route shows up.
  void didPopNext() {}

  @override
  Widget build(BuildContext context) => widget.child;
}
