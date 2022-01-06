import 'package:flutter/material.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';

class MainContainer extends StatelessWidget {
  final Widget child;
  final double height, width;
  final bool isHeightGiven;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BoxDecoration? boxDecoration;

  const MainContainer({
    Key? key,
    required this.child,
    this.height = 1,
    this.isHeightGiven = true,
    this.width = 1,
    this.padding = const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
    this.margin = const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
    this.boxDecoration = const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
            color: Colors.black38,
            offset: Offset(0, 1.5),
            blurRadius: 0.5,
            spreadRadius: 1),
      ],
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          padding: padding,
          margin: margin,
          decoration: boxDecoration!
              .copyWith(borderRadius: BorderRadius.circular(18.0)),
          height: isHeightGiven ? AppConfig.of(context).appWidth(height) : null,
          width: AppConfig.of(context).appWidth(width),
          child: child,
        ),
        Container(
          padding: padding,
          margin: margin,
          height: 10,
          width: size.width * width,
          decoration: BoxDecoration(
            color: AppColors.orangeColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(18.0),
                topLeft: Radius.circular(18.0)),
          ),
        ),
      ],
    );
  }
}
