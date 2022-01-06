import 'package:flutter/material.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/ui/ui_constants/resolvers/image_assets_resolver.dart';


class CustomErrorWidget extends StatelessWidget {
  final String message;
  const CustomErrorWidget(this.message,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      height: AppConfig.of(context).appWidth(30),
      margin: EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error),
          SizedBox(height: 10),
          Text(message,style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
    );
  }
}
