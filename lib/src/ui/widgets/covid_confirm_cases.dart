import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/provider/domestic_to_internation.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';

class CovidConfirmCases extends StatelessWidget {
  final String textOne;
  final String textTwo;
  final double textOneSize;
  final double textTwoSize;

  const CovidConfirmCases(
      {Key? key,
      required this.textOne,
      required this.textTwo,
      this.textOneSize = 25,
      this.textTwoSize = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DomesticToInternation>(
      builder: (context,locale,child){
        return Row(
          children: [
            Expanded(
                child: Align(
                  alignment: locale.localeState?Alignment.centerLeft:Alignment.centerRight,
                  child: Text(
                    textOne.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: textOneSize, color: Colors.black),
                  ),
                )),
            Expanded(
                child: Align(
                    alignment: locale.localeState?Alignment.centerRight:Alignment.centerLeft,
                    child: Text(textTwo.toUpperCase(),
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: AppColors.greenColor, fontSize: textTwoSize)))),
          ],
        );
      },
    );
  }
}
