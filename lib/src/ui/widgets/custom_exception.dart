import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/provider/theme_provider.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/String.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:provider/provider.dart';

class CustomException extends StatefulWidget {
  @override
  _CustomExceptionState createState() => _CustomExceptionState();
}

class _CustomExceptionState extends State<CustomException> {


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: AppConfig.of(context).appWidth(10),
          left: AppConfig.of(context).appWidth(7.4),
          right: AppConfig.of(context).appWidth(10)),
      height: AppConfig.of(context).appWidth(25),
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.watch<ThemeProvider>().selectedTheme
            ? AppColors.itemBackgroundScreenColor
            : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        margin: EdgeInsets.only(
            top: AppConfig.of(context).appWidth(5),
            right: AppConfig.of(context).appWidth(3)),
        child: Column(
          children: <Widget>[
            Container(
              height: AppConfig.of(context).appWidth(13),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.translate(AppString.NOT_AVAILABLE)!,
                  style: Theme.of(context).textTheme.headline2,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
