import 'package:flutter/material.dart';
import 'package:ufone_web/src/bloc/utility/Validations.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/String.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';

import '../../../app_localizations.dart';


class CustomTextField extends StatelessWidget {
  String labelText;
  TextInputType textInputType;
  VALIDATION_TYPE validationType;
  IconData icon;
  TextEditingController controller;
  bool obscureText, isEnabled;
  VoidCallback onPasswordVisiblityChange;
  Function onKeyPressed;

  CustomTextField(
      this.labelText,
      this.textInputType,
      this.validationType,
      this.icon,
      this.controller,
      this.obscureText,
      this.onPasswordVisiblityChange,
      {required this.isEnabled,
        required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: (isEnabled != null ? isEnabled : true),
      controller: controller,
      enableInteractiveSelection: true,
      obscureText: obscureText,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: AppConfig.of(context).appWidth(3.5),
        color: AppColors.black,
        fontWeight: FontWeight.w300,
      ),
      keyboardType: textInputType,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.greyTextColor,
        prefixIcon: Icon(
          icon,
          color: AppColors.timberWolf,
        ),
        suffixIcon: IconButton(
          icon: checkForVisiblityIcon(),
          onPressed: onPasswordVisiblityChange,
        ),
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.headline4,
        contentPadding: EdgeInsets.fromLTRB(15.0, 16.0, 15.0, 16.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.timberWolf, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        )
        ,
      ),
      validator: (value) => checkFieldValidation(
          val: value,
          password: '',
          fieldName:
          "${AppLocalizations.of(context)!.translate(AppString.PLEASE_ENTER_TEXT)} $labelText ",
          fieldType: validationType,
          context: context),
      onFieldSubmitted: (value) => {onKeyPressed()},
    );
  }

  Widget checkForVisiblityIcon() {
    if (validationType == VALIDATION_TYPE.PASSWORD) {
      if (obscureText) {
        return Icon(
          Icons.visibility_off,
          color: AppColors.timberWolf,
        );
      } else {
        return Icon(
          Icons.visibility,
          color: AppColors.timberWolf,
        );
      }
    } else {
      return Container();
    }
  }
}
