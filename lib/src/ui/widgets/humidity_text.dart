import 'package:flutter/material.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';

class HumidityText extends StatelessWidget {
  final int value;
  final Color color;
  final double size;

  const HumidityText(
      {Key? key,
      required this.value,
      this.color = Colors.black,
      this.size = 6.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('${AppLocalizations.of(context)!.translate(AppString.humidity)} ${value}%',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: AppConfig.of(context).appWidth(size)));
  }
}

class UVText extends StatelessWidget {
  final int value;
  final Color color;
  final double size;

  const UVText(
      {Key? key,
      required this.value,
      this.color = Colors.black,
      this.size = 6.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('${AppLocalizations.of(context)!.translate(AppString.UVindex)} $value%',
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontSize: AppConfig.of(context).appWidth(size)));
  }
}
