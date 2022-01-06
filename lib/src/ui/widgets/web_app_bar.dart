import 'package:flutter/material.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/style.dart';

class WebAppBar extends StatelessWidget {
  String? appBarMessage;
  bool centerTitle;
  WebAppBar({Key? key, this.appBarMessage,this.centerTitle=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: Text(AppLocalizations.of(context)!.translate(appBarMessage!),
          style: Styles.getDrawerItemStyle(
              color: AppColors.greenColor,
              fontSize: AppConfig.of(context).appWidth(4.5),
              fontWeight: FontWeight.w400),
          textAlign: TextAlign.center),
      elevation: 0.0,
      //backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.orange),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
