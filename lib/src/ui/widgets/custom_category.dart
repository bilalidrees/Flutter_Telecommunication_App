import 'package:flutter/material.dart';

import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/ui/ui_constants/resolvers/image_assets_resolver.dart';

class CustomCategory extends StatefulWidget {
  String? title, imageUrl;
  GestureTapCallback onPressed;

  CustomCategory({this.title, this.imageUrl, required this.onPressed});

  @override
  _CustomCategoryState createState() => _CustomCategoryState();
}

class _CustomCategoryState extends State<CustomCategory> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                left: AppConfig.of(context).appWidth(2),
                right: AppConfig.of(context).appWidth(3),
                top: AppConfig.of(context).appWidth(6),
                bottom: AppConfig.of(context).appWidth(2)),
            child: Center(
              child: FadeInImage(
                width: AppConfig.of(context).appWidth(70),
                height: AppConfig.of(context).appWidth(40),
                placeholder:
                    AssetImage(ImageAssetsResolver.ITGN_PLACEHOLDER_ICON),
                image: NetworkImage(widget.imageUrl!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
