import 'package:flutter/material.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'package:ufone_web/src/model/NewsFeed.dart';
import 'package:ufone_web/src/provider/theme_provider.dart';
import 'package:ufone_web/src/ui/ui_constants/resolvers/image_assets_resolver.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';

class CustomNewsWidget extends StatefulWidget {
  GestureTapCallback onPressed;
  NewsFeed newsFeed;
  String logoUrl;

  CustomNewsWidget(
      {required this.onPressed, required this.newsFeed, required this.logoUrl});

  @override
  _CustomNewsWidgetState createState() => _CustomNewsWidgetState();
}

class _CustomNewsWidgetState extends State<CustomNewsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            margin: EdgeInsets.fromLTRB(
                AppConfig.of(context).appWidth(10),
                AppConfig.of(context).appWidth(5),
                AppConfig.of(context).appWidth(5),
                AppConfig.of(context).appWidth(1)),
            height: AppConfig.of(context).appWidth(35),
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.watch<ThemeProvider>().selectedTheme
                  ? AppColors.itemBackgroundScreenColor
                  : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Container(
              margin: EdgeInsets.only(
                  left: AppConfig.of(context).appWidth(35),
                  top: AppConfig.of(context).appWidth(3),
                  right: AppConfig.of(context).appWidth(3)),
              child: Column(
                children: <Widget>[
                  Container(
                    height: AppConfig.of(context).appWidth(7),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.newsFeed.title,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            height: 2.1,
                            color: context.watch<ThemeProvider>().selectedTheme
                                ? AppColors.white
                                : AppColors.black),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: AppConfig.of(context).appWidth(18),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.newsFeed.description,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(height: 2.1),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            top: AppConfig.of(context).appWidth(3),
                          ),
                          child: Text(
                            widget.newsFeed.articlePublishedTime,
                            style: Theme.of(context).textTheme.headline5,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(width: AppConfig.of(context).appWidth(3)),
                        Container(
                          margin: EdgeInsets.only(
                            top: AppConfig.of(context).appWidth(3),
                          ),
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(10.0),
                            child: Image(
                              width: AppConfig.of(context).appWidth(15),
                              height: AppConfig.of(context).appWidth(6),
                              image: NetworkImage(widget.logoUrl),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(width: AppConfig.of(context).appWidth(3)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: AppConfig.of(context).appWidth(5),
          top: AppConfig.of(context).appWidth(8),
          bottom: AppConfig.of(context).appWidth(4),
          child: GestureDetector(
            onTap: widget.onPressed,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Hero(
                  tag: widget.newsFeed.tuuid,
                  child: FadeInImage(
                    width: AppConfig.of(context).appWidth(32),
                    image: (widget.newsFeed.mediaLinks != null &&
                            widget.newsFeed.mediaLinks!.picture != null &&
                            widget.newsFeed.mediaLinks!.picture!.link != null)
                        ? NetworkImage(widget.logoUrl ==
                                "https://vp.vxt.net:41538/itgn/assets/imgs/logos/ITGN-logo.png"
                            ? "https://vp.vxt.net/viper/photos/${widget.newsFeed.mediaLinks!.picture!.link}"
                            : widget.newsFeed.mediaLinks!.picture!.link)
                        : AssetImage(ImageAssetsResolver.ITGN_PLACEHOLDER_ICON)
                            as ImageProvider,
                    fit: BoxFit.fill,
                    placeholder:
                        AssetImage(ImageAssetsResolver.ITGN_PLACEHOLDER_ICON),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
