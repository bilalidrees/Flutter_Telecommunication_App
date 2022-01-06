import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';

class CurrencyRateWidget extends StatelessWidget {
  final String? flag, currency, buying, selling;
  final double textSize;
  CurrencyRateWidget({this.flag, this.currency, this.buying, this.selling,this.textSize = 18});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          flag!.isNotEmpty? Container(
              child: Expanded(
                child: Flag.fromCode(getFlag(flag!), height: textSize, width: textSize),
              ),
            ):Expanded(
              child: Center(
                child: Text(AppString.flag,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(
                  // color: AppColors.greenColor,
                  fontSize: textSize,
                  fontWeight: FontWeight.w400)),
              ),
            ),
          Container(
            child: Expanded(
              child: Center(
                child: Text(currency!,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(
                       // color: AppColors.greenColor,
                        fontSize: textSize,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ),
          Container(
            child: Expanded(
              child: Center(
                child: Text(buying!,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(
                       // color: AppColors.greenColor,
                        fontSize: textSize,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ),
          Container(
            child: Expanded(
              child: Center(
                child: Text(selling!,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(
                       // color: AppColors.greenColor,
                        fontSize: textSize,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  FlagsCode getFlag(String flagId) {
    if (flagId == "USD") {
      return FlagsCode.US;
    } else if (flagId == "SAR") {
      return FlagsCode.SA;
    } else if (flagId == "AED") {
      return FlagsCode.AE;
    } else if (flagId == "GBP") {
      return FlagsCode.GB;
    } else if (flagId == "JPY") {
      return FlagsCode.JP;
    } else {
      return FlagsCode.ER;
    }
  }
}
