import 'package:flutter/material.dart';

import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';

const double CHECKBOX_ITEM_HEIGHT = 10;

class CustomRadio extends StatelessWidget {
  const CustomRadio({
    required this.label,
    required this.isSelected,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool isSelected;
  final EdgeInsets padding;
  final int groupValue;
  final int value;
  final Function? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) onChanged!(value);
      },
      child: Container(
        height: AppConfig.of(context).appWidth(CHECKBOX_ITEM_HEIGHT),
        child: Row(
          children: <Widget>[
            Radio<int>(
              groupValue: groupValue,
              value: value,
              onChanged: (int? newValue) {
                onChanged!(newValue);
              },
            ),
            Container(
              width: AppConfig.of(context).appWidth(20),
              child: buildText(context),
            ),
          ],
        ),
      ),
    );
  }

  Text buildText(BuildContext context) {
    if (isSelected)
      return Text(label,
          maxLines: 2,
          style: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: AppConfig.of(context).appWidth(4),
              fontWeight: FontWeight.w400,
              color: AppColors(context).secondColor(1)));
    else
      return Text(label,
          maxLines: 2,
          style: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: AppConfig.of(context).appWidth(4),
              fontWeight: FontWeight.w200,
              color: AppColors(context).secondColor(1)));
  }
}
