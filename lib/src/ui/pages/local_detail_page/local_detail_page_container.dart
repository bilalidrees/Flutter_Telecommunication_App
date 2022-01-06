import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/route_generator.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/cubit/corona/corona_news/corona_news_cubit.dart';
import 'package:ufone_web/src/ui/pages/local_detail_page/trending_news.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/widgets/main_container.dart';
import 'package:ufone_web/src/ui/widgets/symptoms_widget.dart';
import '../../../cubit/corona/corona_update/corona_cubit.dart';
import 'package:ufone_web/src/model/corona_news.dart';
import 'package:ufone_web/src/model/corona_update.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';
import 'package:ufone_web/src/ui/widgets/coronaStats_container.dart';
import 'package:ufone_web/src/ui/widgets/corona_rich_text.dart';
import 'package:ufone_web/src/ui/widgets/covid_confirm_cases.dart';

import 'local_detail_see_all_page.dart';

class LocalDetailPageContainer extends StatelessWidget {
  final CoronaUpdate? coronaUpdate;

  const LocalDetailPageContainer({Key? key, this.coronaUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      padding: EdgeInsets.symmetric(
          horizontal: AppConfig.of(context).appWidth(6.0),
          vertical: AppConfig.of(context).appWidth(4.5)),
      margin: EdgeInsets.symmetric(
        vertical: AppConfig.of(context).appWidth(4.5),
        horizontal: AppConfig.of(context).appWidth(2.9),
      ),
      height: 245,
      width: double.infinity,
      boxDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Column(
        //shrinkWrap: true,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CoronaRichText(
            textOne: AppLocalizations.of(context)!.translate(AppString.coronavirus)!,
            textTwo: AppLocalizations.of(context)!.translate(AppString.in_pakistan)!,
            textOneSize: AppConfig.of(context).appWidth(6.0),
            textTwoSize: AppConfig.of(context).appWidth(6.0),
          ),
          SizedBox(height: AppConfig.of(context).appWidth(3.6)),
          CovidConfirmCases(
            textOne: AppLocalizations.of(context)!.translate(AppString.confirmed_cases)!,
            textTwo: coronaUpdate!.confirmedCases!,
            textOneSize: AppConfig.of(context).appWidth(7.0),
            textTwoSize: AppConfig.of(context).appWidth(7.0),
          ),
          SizedBox(height: AppConfig.of(context).appWidth(3.6)),
          const Divider(color: Colors.orange),
          SizedBox(height: AppConfig.of(context).appWidth(3.6)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: CoronaStats(
                AppLocalizations.of(context)!.translate(AppString.recovered)!,
                coronaUpdate!.recovered!,
                cases: 1,
                stringSize: AppConfig.of(context).appWidth(0.8),
                valueSize: AppConfig.of(context).appWidth(1.2),
              )),
              Expanded(
                  child: CoronaStats(
                    AppLocalizations.of(context)!.translate(AppString.test)!,
                coronaUpdate!.totalTests!,
                cases: 2,
                stringSize: AppConfig.of(context).appWidth(0.8),
                valueSize: AppConfig.of(context).appWidth(1.2),
              )),
              Expanded(
                  child: CoronaStats(
                    AppLocalizations.of(context)!.translate(AppString.death)!,
                coronaUpdate!.deaths!,
                cases: 3,
                stringSize: AppConfig.of(context).appWidth(0.8),
                valueSize: AppConfig.of(context).appWidth(1.2),
              )),
            ],
          ),
          SizedBox(height: AppConfig.of(context).appWidth(3.6)),
          const Divider(color: Colors.orange),
          SizedBox(height: AppConfig.of(context).appWidth(3.6)),
          Wrap(
            //alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            spacing: AppConfig.of(context).appWidth(4),
            runSpacing: AppConfig.of(context).appWidth(8.0),
            children: [
              CoronaStats(
                AppString.ict.toUpperCase(),
                coronaUpdate!.islamabad!,
                stringSize: AppConfig.of(context).appWidth(1),
                valueSize: AppConfig.of(context).appWidth(1.2),
              ),
              CoronaStats(
                AppString.punjab.toUpperCase(),
                coronaUpdate!.punjab!,
                stringSize: AppConfig.of(context).appWidth(1),
                valueSize: AppConfig.of(context).appWidth(1.2),
              ),
              CoronaStats(
                AppString.sindh.toUpperCase(),
                coronaUpdate!.sindh!,
                stringSize: AppConfig.of(context).appWidth(1),
                valueSize: AppConfig.of(context).appWidth(1.2),
              ),
              CoronaStats(
                AppString.kpk.toUpperCase(),
                coronaUpdate!.kP!,
                stringSize: AppConfig.of(context).appWidth(1),
                valueSize: AppConfig.of(context).appWidth(1.2),
              ),
              CoronaStats(
                AppString.ajk.toUpperCase(),
                coronaUpdate!.aJK!,
                stringSize: AppConfig.of(context).appWidth(1),
                valueSize: AppConfig.of(context).appWidth(1.2),
              ),
              CoronaStats(
                AppString.gb.toUpperCase(),
                coronaUpdate!.gB!,
                stringSize: AppConfig.of(context).appWidth(1),
                valueSize: AppConfig.of(context).appWidth(1.2),
              ),
              CoronaStats(
                AppString.balochistan.toUpperCase(),
                coronaUpdate!.balochistan!,
                stringSize: AppConfig.of(context).appWidth(1),
                valueSize: AppConfig.of(context).appWidth(1.2),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppConfig.of(context).appWidth(3)),
            child: Text(
              AppString.covidGov,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w300,
                  fontSize: AppConfig.of(context).appWidth(4)),
            ),
          ),
          const Divider(color: Colors.orange),
          Center(
              child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () {},
                  child:
                      Text(AppString.pakistanDetailStatistics.toUpperCase()))),
          SizedBox(height: AppConfig.of(context).appWidth(3.6)),
          Row(
            children: [
              Text(
                AppString.trending.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColors.orangeColor,
                    fontWeight: FontWeight.w400,
                    fontSize: AppConfig.of(context).appWidth(7)),
              ),
              Spacer(),
              Transform.scale(
                scale: AppConfig.of(context).appWidth(0.20),
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: AppColors.greenColor),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.LOCALDETAILSEEALL,
                        arguments: ScreenArguments(
                            buildContext: context,
                            message: AppLocalizations.of(context)!
                                .translate(AppString.COVID)));
                  },
                  child: Text(
                    AppString.seeAll,
                    style: TextStyle(
                      fontSize: AppConfig.of(context).appWidth(4.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: Colors.grey),
          SizedBox(height: AppConfig.of(context).appWidth(3.6)),
          TrendingSectionWidget(isApiToCall: true),
        ],
      ),
    );
  }
}
