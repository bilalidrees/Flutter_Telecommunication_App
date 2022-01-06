import 'package:flutter/material.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';

class CoronaRichText extends StatelessWidget {
  final String textOne;
  final String textTwo;
  final double textOneSize;
  final double textTwoSize;

  const CoronaRichText(
      {Key? key,
      required this.textOne,
      required this.textTwo,
      this.textOneSize =14,
      this.textTwoSize =14})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: textOne.toUpperCase(),
            style: TextStyle(color: AppColors.greenColor,fontSize: textOneSize),
            children: [
          TextSpan(
              text: " ${textTwo.toUpperCase()}",
              style: TextStyle(color: Colors.black,fontSize: textTwoSize)),
        ]));
  }
}
