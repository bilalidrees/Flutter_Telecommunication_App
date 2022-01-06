import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';

class CustomLoader extends StatefulWidget {
  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.greenColor,
        child: Center(child: SpinKitRotatingCircle(color: AppColors.white)));
  }
}
