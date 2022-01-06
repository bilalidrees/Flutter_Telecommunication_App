import 'package:flutter/material.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';

class IndexWidget extends StatelessWidget {
  String? indexKey, indexValue;
  
  IndexWidget({this.indexKey, this.indexValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(indexKey!,
            style: Theme
                .of(context)
                .textTheme
                .bodyText1!
                .copyWith(
                fontSize: AppConfig.of(context).appWidth(4),
                color: Colors.black,
                fontWeight: FontWeight.w300)),
        SizedBox(height: AppConfig.of(context).appWidth(4.5)),
        Text(indexValue!.split(".").first,
            style: Theme
                .of(context)
                .textTheme
                .bodyText1!
                .copyWith(
                //color: AppColors.greenColor,
                fontSize: AppConfig.of(context).appWidth(4),
                color: Colors.black,
                fontWeight: FontWeight.w300))
      ],
    );
  }
}
