import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/model/corona_news.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/String.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/widgets/main_container.dart';
import 'package:ufone_web/src/ui/widgets/web_app_bar.dart';

class CoronaNewsDetails extends StatelessWidget {
  final CoronaNews? coronaNews;

  CoronaNewsDetails({this.coronaNews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: WebAppBar(appBarMessage: AppString.coronavirus.toUpperCase()),
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Directionality(
                textDirection: coronaNews!.language == "English"
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                child: MainContainer(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppConfig.of(context).appWidth(6.0),
                      vertical: AppConfig.of(context).appWidth(10.5)),
                  margin: EdgeInsets.symmetric(
                    vertical: AppConfig.of(context).appWidth(4),
                    horizontal: AppConfig.of(context).appWidth(2.9),
                  ),
                  // height: 400,
                  isHeightGiven: false,
                  width: double.infinity,
                  boxDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.trending.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: AppColors.orangeColor,
                            fontWeight: FontWeight.w400,
                            fontSize: AppConfig.of(context).appWidth(7)),
                      ),
                      const Divider(color: AppColors.orangeColor),
                      Center(
                        child: Image.network(
                          coronaNews!.image!,
                          //height: AppConfig.of(context).appWidth(100),
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: AppConfig.of(context).appWidth(3)),
                      Text(
                        coronaNews!.title!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                            fontSize: AppConfig.of(context).appWidth(5)),
                      ),
                      SizedBox(height: AppConfig.of(context).appWidth(2.5)),
                      Text(
                        coronaNews!.description!,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w300,
                            color: AppColors.black,
                            fontSize: AppConfig.of(context).appWidth(4.5)),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
