//@dart=2.9
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

import 'package:ufone_web/src/app.dart';
import 'package:ufone_web/src/provider/geolocation_proivder.dart';
import 'package:ufone_web/src/provider/theme_provider.dart';

import 'package:ufone_web/src/provider/domestic_to_internation.dart';
import 'package:ufone_web/src/ui/pages/geo_location_access/geo_location_access.dart';
import 'package:ufone_web/src/ui/widgets/restart.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  //   print("errorBuilder:${errorDetails.exceptionAsString()}");
  //   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  //   return ShowErrorWidget(errorDetails.exceptionAsString());
  // };
  // ErrorWidget.builder = (errorDetails) {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ThemeProvider>(create: (_)=>ThemeProvider()),
    ChangeNotifierProvider<DomesticToInternation>(
        create: (context) => DomesticToInternation()),
    Provider<GeoLocationAccess>(create: (context) => GeoLocationAccess()),
    ChangeNotifierProxyProvider<GeoLocationAccess, GeoLocationProvider>(
        create: (context) => GeoLocationProvider(context.read<GeoLocationAccess>()),
        update: (context, geoAccess, geoPro) => GeoLocationProvider(geoAccess),lazy: true)
  ], child: RestartWidget(child: App())));
}



