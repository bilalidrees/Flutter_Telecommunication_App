import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/provider/domestic_to_internation.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';
import 'package:provider/provider.dart';
import 'package:ufone_web/src/ui/widgets/restart.dart';

class DrawerCategory extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Widget child;
  final DrawEum drawEum;

  const DrawerCategory(this.iconData, this.text, this.child,
      {Key? key, this.drawEum = DrawEum.about})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (drawEum == DrawEum.about) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => child));
        } else if (drawEum == DrawEum.setting) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => child));
        } else if (drawEum == DrawEum.language) {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => _AlertDialog());
        } else if (drawEum == DrawEum.home) {
          Navigator.pop(context);
        } else if (drawEum == DrawEum.quran) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => child));
        }
      },
      child: Row(
        children: [
          Expanded(child: Icon(iconData, color: AppColors.orangeColor)),
          Expanded(
              flex: 3,
              child: Text(AppLocalizations.of(context)!.translate(text)!,
                  style: Theme.of(context).textTheme.bodyText1)),
        ],
      ),
    );
  }
}

class _AlertDialog extends StatelessWidget {
  const _AlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      title: Center(
          child:  Text(AppLocalizations.of(context)!.translate(AppString.LANGUAGE),
        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.greenColor),
      )),
      content: Consumer<DomesticToInternation>(
        builder: (context, locale, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(thickness: 1),
              ListTile(
                title: const Text('English'),
                leading: Radio<bool>(
                  value: true,
                  groupValue: locale.localeState,
                  onChanged: (bool? value) {
                    locale.changeEnglishToUrdu(value!);
                    RestartWidget.restartApp(context);
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: const Text('اردو'),
                leading: Radio<bool>(
                  value: false,
                  groupValue: locale.localeState,
                  onChanged: (bool? value) {
                    locale.changeEnglishToUrdu(value!);
                    RestartWidget.restartApp(context);
                    Navigator.pop(context);
                  },
                ),
              ),
              Divider(thickness: 1),
            ],
          );
        },
      ),
      // actions: <Widget>[
      //   TextButton(
      //     onPressed: () => Navigator.pop(context, 'Cancel'),
      //     child: const Text('Cancel'),
      //   ),
      //   TextButton(
      //     onPressed: () => Navigator.pop(context, 'OK'),
      //     child: const Text('OK'),
      //   ),
      // ],
    );
  }
}

enum DrawEum { about, setting, language, quran, home }
