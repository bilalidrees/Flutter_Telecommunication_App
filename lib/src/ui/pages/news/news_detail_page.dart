import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/rich_text_parser.dart';

import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/model/NewsFeed.dart';
import 'package:ufone_web/src/provider/domestic_to_internation.dart';
import 'package:ufone_web/src/provider/theme_provider.dart';
import 'package:ufone_web/src/ui/ui_constants/resolvers/image_assets_resolver.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/widgets/custom_back_button.dart';
import 'package:provider/provider.dart';

class NewsDetailPage extends StatefulWidget {
  NewsFeed newsFeed;
  String sourceLogo;

  NewsDetailPage({required this.newsFeed, required this.sourceLogo});

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Hero(
              tag: widget.newsFeed.tuuid,
              child: Container(
                height: AppConfig.of(context).appWidth(100),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: (widget.newsFeed.mediaLinks != null &&
                            widget.newsFeed.mediaLinks!.picture != null &&
                            widget.newsFeed.mediaLinks!.picture!.link != null)
                        ? NetworkImage(widget.sourceLogo ==
                                "https://vp.vxt.net:41538/itgn/assets/imgs/logos/ITGN-logo.png"
                            ? "https://vp.vxt.net/viper/photos/${widget.newsFeed.mediaLinks!.picture!.link}"
                            : widget.newsFeed.mediaLinks!.picture!.link)
                        : AssetImage(ImageAssetsResolver.ITGN_PLACEHOLDER_ICON)
                            as ImageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // IntrinsicHeight(
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: Colors.white.withOpacity(0.7),
                    //       borderRadius: BorderRadius.all(Radius.circular(15)),
                    //     ),
                    //     margin: EdgeInsets.only(
                    //         left: AppConfig.of(context).appWidth(3),
                    //         right: AppConfig.of(context).appWidth(3),
                    //         bottom: AppConfig.of(context).appWidth(2)),
                    //     padding: EdgeInsets.only(
                    //         left: AppConfig.of(context).appWidth(6),
                    //         right: AppConfig.of(context).appWidth(6),
                    //         bottom: AppConfig.of(context).appWidth(1.5)),
                    //     // height: AppConfig.of(context).appWidth(26),
                    //     child: Align(
                    //       alignment: Alignment.centerLeft,
                    //       child: Text(
                    //         widget.newsFeed.title,
                    //         style: Theme
                    //             .of(context)
                    //             .textTheme
                    //             .headline6,
                    //         // overflow: TextOverflow.ellipsis,
                    //         // maxLines: 3,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      padding: EdgeInsets.only(
                          left: AppConfig.of(context).appWidth(6),
                          right: AppConfig.of(context).appWidth(6),
                          bottom: AppConfig.of(context).appWidth(1.5)),
                      margin: EdgeInsets.only(
                          left: AppConfig.of(context).appWidth(3),
                          right: AppConfig.of(context).appWidth(3),
                          bottom: AppConfig.of(context).appWidth(2)),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      // height: 100,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.newsFeed.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(height: 2.1),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          margin: EdgeInsets.only(
                              left: AppConfig.of(context).appWidth(7.4),
                              right: AppConfig.of(context).appWidth(7.4),
                              bottom: AppConfig.of(context).appWidth(4)),
                          padding: EdgeInsets.only(
                              left: AppConfig.of(context).appWidth(3),
                              right: AppConfig.of(context).appWidth(3),
                              bottom: AppConfig.of(context).appWidth(1),
                              top: AppConfig.of(context).appWidth(1)),
                          child: Text(
                            widget.newsFeed.articlePublishedTime,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(width: AppConfig.of(context).appWidth(15)),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          margin: EdgeInsets.only(
                              left: AppConfig.of(context).appWidth(7.4),
                              bottom: AppConfig.of(context).appWidth(3)),
                          child: Image(
                            width: AppConfig.of(context).appWidth(16),
                            height: AppConfig.of(context).appWidth(6),
                            image: NetworkImage(widget.sourceLogo),
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: AppConfig.of(context).appWidth(3)),
                      ],
                    ),
                    SizedBox(
                      height: AppConfig.of(context).appWidth(10),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: AppConfig.of(context).appWidth(100),
              child: Container(
                height: AppConfig.of(context).appWidth(100),
                width: AppConfig.of(context).appWidth(100),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.5,
              maxChildSize: 0.8,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: context.watch<ThemeProvider>().selectedTheme
                        ? AppColors.itemBackgroundScreenColor
                        : Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: scrollController,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(
                          top: AppConfig.of(context).appWidth(8),
                          left: AppConfig.of(context).appWidth(4),
                          right: AppConfig.of(context).appWidth(4),
                        ),
                        // height: AppConfig.of(context).appHeight(40),
                        child: widget.newsFeed.encodedContent != null
                            ? Center(
                                child: SingleChildScrollView(
                                  child: Html(
                                      customTextAlign: (_) => TextAlign.justify,
                                      defaultTextStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontWeight: context
                                                    .watch<
                                                        DomesticToInternation>()
                                                    .localeState
                                                ? null
                                                : FontWeight.bold,
                                          ),
                                      padding: EdgeInsets.all(12.0),
                                      data: """
           ${widget.newsFeed.encodedContent}
            """),
                                ),
                              )
                            : Text(
                                (widget.newsFeed.longDescription == null)
                                    ? widget.newsFeed.description
                                    : widget.newsFeed.longDescription,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                      );
                    },
                  ),
                );
              },
            ),
            CustomBackButton(),
          ],
        ),
      ),
    );
  }
}
