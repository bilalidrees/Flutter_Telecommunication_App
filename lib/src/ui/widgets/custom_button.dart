import 'package:flutter/material.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  String text;
  Color textColor, backgorundColor;
  IconData? icon;
  GestureTapCallback onPressed;
  bool isToShowEndingIcon;
  double? width;
  double? height;
  double? radius;

  CustomButton({
    required this.text,
    required this.textColor,
    required this.backgorundColor,
    required this.onPressed,
    required this.width,
    required this.radius,
    this.icon,
    this.height,
    this.isToShowEndingIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius!),
      ),
      color: backgorundColor,
      onPressed: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        onPressed();
      },
      child: Container(
        margin: EdgeInsets.only(left: AppConfig.of(context).appWidth(5)),
        width: (width != null ? width : double.infinity),
        height: (height != null ? height : AppConfig.of(context).appWidth(14)),
        alignment: Alignment.center,
        child: buildRow(context, isToShowEndingIcon),
      ),
    );
  }

  Row buildRow(BuildContext context, bool isToShowEndingIcon) {
    if (isToShowEndingIcon) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: AppConfig.of(context).appWidth(5)),
              child: Text(
                (text).toUpperCase(),
                style: TextStyle(
                    fontSize: AppConfig.of(context).appWidth(4.5),
                    fontFamily: 'RobotoCondensed',
                    color: textColor,
                    letterSpacing: 0.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            width: AppConfig.of(context).appWidth(14.5),
            height: AppConfig.of(context).appWidth(18),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: new Icon(
              icon,
              color: AppColors.black,
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: AppConfig.of(context).appWidth(4)),
              child: Text(
                (text).toUpperCase(),
                style: TextStyle(
                    fontSize: AppConfig.of(context).appWidth(4.5),
                    fontFamily: 'RobotoCondensed',
                    color: textColor,
                    letterSpacing: 0.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          buildContainer(),
        ],
      );
    }
  }

  Container buildContainer() {
    if (icon != null)
      return Container(
        width: 50,
        height: 50,
        child: new Icon(icon, color: AppColors.white),
      );
    else
      return Container();
  }
}
