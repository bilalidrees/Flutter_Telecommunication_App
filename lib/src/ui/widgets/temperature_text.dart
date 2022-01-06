import 'package:flutter/material.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';

class TemperatureText extends StatelessWidget {
  final dynamic value;
  final double valueSize;
  final Color color;
  final MainAxisAlignment mainAxisAlignment;
  final  double degree;
  const TemperatureText(
      {Key? key,
      required this.value,
        this.degree = 6 / 2,
      this.valueSize = 16,
      this.color = Colors.black,
      this.mainAxisAlignment = MainAxisAlignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(value.toString().split(".").first,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: AppConfig.of(context).appWidth(valueSize),
                fontWeight: FontWeight.w300)),
        Text('o',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: AppConfig.of(context).appWidth(degree))),
        Text('C',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: AppConfig.of(context).appWidth(valueSize / 1.1))),
      ],
    );
  }
}
