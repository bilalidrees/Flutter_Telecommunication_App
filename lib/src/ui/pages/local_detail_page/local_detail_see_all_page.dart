import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/cubit/corona/corona_news/corona_news_cubit.dart';
import 'package:ufone_web/src/model/corona_news.dart';
import 'package:ufone_web/src/model/corona_update.dart';
import 'package:ufone_web/src/ui/pages/local_detail_page/local_detail_page_container.dart';
import 'package:ufone_web/src/ui/pages/local_detail_page/trending_news.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';
import 'package:ufone_web/src/ui/widgets/main_container.dart';
import 'package:ufone_web/src/ui/widgets/web_app_bar.dart';

class LocalDetailSeeAll extends StatelessWidget {
  final String? appBarMessage;

  const LocalDetailSeeAll({Key? key, this.appBarMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: WebAppBar(appBarMessage: appBarMessage),
      ),
      body: CustomScrollView(
        //physics: NeverScrollableScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              MainContainer(
                padding: EdgeInsets.symmetric(
                    horizontal: AppConfig.of(context).appWidth(6.0),
                    vertical: AppConfig.of(context).appWidth(4.5)),
                margin: EdgeInsets.symmetric(
                  vertical: AppConfig.of(context).appWidth(4.5),
                  horizontal: AppConfig.of(context).appWidth(2.9),
                ),
                //height: 340,
                isHeightGiven: false,
                width: double.infinity,
                boxDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppString.trending.toUpperCase(),
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: AppColors.orangeColor,
                              fontWeight: FontWeight.w400,
                              fontSize: AppConfig.of(context).appWidth(7)),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey),
                    SizedBox(height: AppConfig.of(context).appWidth(3.6)),
                    TrendingSectionWidget(isApiToCall: false),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
