import 'package:flutter/material.dart';

class CustomTitleWidget extends StatelessWidget {
  String title;
  BuildContext context;
  CustomTitleWidget({required this.context,required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:Theme.of(context).textTheme.headline2,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
