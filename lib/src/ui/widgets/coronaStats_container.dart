import 'package:flutter/material.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';

class CoronaStats extends StatelessWidget {
  final String string;
  final String value;
  final int? cases;
  final double stringSize;
  final double valueSize;

  const CoronaStats(this.string, this.value,
      {this.cases, this.stringSize = 4, this.valueSize = 4});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          string,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: AppConfig.of(context).appWidth(stringSize)),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: AppColors.greenColor, fontSize: AppConfig.of(context).appWidth(valueSize)),
        ),
        const SizedBox(height: 3),
        if (cases == 1)
          Text(
            'CASES [24HRS]',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontStyle: FontStyle.italic, fontSize: 11),
          ),
        if (cases == 2)
          Text(
            'DEATHS [24HRS]',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontStyle: FontStyle.italic, fontSize: 11),
          ),
        if (cases == 3)
          Text(
            'TESTS [24HRS]',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontStyle: FontStyle.italic, fontSize: 11),
          ),
      ],
    );
  }
}
