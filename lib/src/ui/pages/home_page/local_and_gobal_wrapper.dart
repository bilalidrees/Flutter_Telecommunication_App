import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/cubit/corona/corona_news/corona_news_cubit.dart';
import 'package:ufone_web/src/provider/theme_provider.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/widgets/main_container.dart';
import '../../../cubit/corona/corona_update/corona_cubit.dart';
import 'package:ufone_web/src/model/corona_update.dart';
import 'package:ufone_web/src/provider/domestic_to_internation.dart';
import 'package:provider/provider.dart';
import 'package:ufone_web/src/ui/pages/local_detail_page/local_detail_page.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';
import 'package:ufone_web/src/ui/widgets/coronaStats_container.dart';
import 'package:ufone_web/src/ui/widgets/corona_rich_text.dart';
import 'package:ufone_web/src/ui/widgets/covid_confirm_cases.dart';

import '../../../../route_generator.dart';

class CoronavirusContainer extends StatelessWidget {
  final CoronaUpdate? coronaUpdate;

  const CoronavirusContainer({Key? key, this.coronaUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.watch<DomesticToInternation>().state
        ? _CovidContainerLocal(coronaUpdate: coronaUpdate)
        : _CovidContainerGlobal(coronaUpdate: coronaUpdate);
  }
}

class _CovidContainerLocal extends StatelessWidget {
  final CoronaUpdate? coronaUpdate;

  const _CovidContainerLocal({Key? key, this.coronaUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      padding: EdgeInsets.only(
          right: AppConfig.of(context).appWidth(6.0),
          left: AppConfig.of(context).appWidth(6.0),
          top: AppConfig.of(context).appWidth(8.0),
          bottom: AppConfig.of(context).appWidth(7.0)),
      margin: EdgeInsets.symmetric(
        vertical: AppConfig.of(context).appWidth(4.5),
      ),
      height: 93.3,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CoronaRichText(
              textOne: AppLocalizations.of(context)!.translate(AppString.coronavirus)!,
              textTwo: AppLocalizations.of(context)!.translate(AppString.in_pakistan)!),
          SizedBox(height: AppConfig.of(context).appWidth(3.5)),
          CovidConfirmCases(
              textOne: AppLocalizations.of(context)!.translate(AppString.confirmed_cases)!,
              textTwo: coronaUpdate!.confirmedCases!.toUpperCase()),
          SizedBox(height: AppConfig.of(context).appWidth(3.5)),
          const Divider(color: Colors.orange),
          SizedBox(height: AppConfig.of(context).appWidth(3.5)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CoronaStats(
                  AppLocalizations.of(context)!.translate(AppString.recovered)!, coronaUpdate!.recovered!,
                  stringSize: 4.05),
              CoronaStats(
                AppLocalizations.of(context)!.translate(AppString.test)!,
                coronaUpdate!.totalTests!,
                stringSize: 4.05,
              ),
              CoronaStats(AppLocalizations.of(context)!.translate(AppString.death)!, coronaUpdate!.deaths!,
                  stringSize: 4.05),
            ],
          ),
          SizedBox(height: AppConfig.of(context).appWidth(3.5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  context
                      .read<DomesticToInternation>()
                      .changeDomesticToInternation();
                },
                child: Text(AppLocalizations.of(context)!.translate(AppString.in_worldWide)!),
                style: Theme.of(context).elevatedButtonTheme.style,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.LOCALDETAIL,
                        arguments: ScreenArguments(
                          data: coronaUpdate,
                          buildContext: context,
                          message: AppLocalizations.of(context)!
                              .translate(AppString.COVID),
                        ));
                  },
                  child: Text(AppString.read_more.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.red,
                          fontSize: AppConfig.of(context).appWidth(3),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w300)))
            ],
          ),
          InkWell(
            onTap: (){},
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: AppConfig.of(context).appWidth(3)),
              child: Text(
                AppString.covidGov,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w300,
                    fontSize: AppConfig.of(context).appWidth(4)),
              ),
            ),
          ),
        ],
      ),
      boxDecoration: BoxDecoration(
        color: context.watch<ThemeProvider>().selectedTheme
            ? AppColors.itemBackgroundScreenColor
            : Colors.white,
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 1.5),
              blurRadius: 0.5,
              spreadRadius: 1),
        ],
      ),
    );
  }
}

class _CovidContainerGlobal extends StatelessWidget {
  final CoronaUpdate? coronaUpdate;

  const _CovidContainerGlobal({Key? key, this.coronaUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      padding: EdgeInsets.only(
          right: AppConfig.of(context).appWidth(6.0),
          left: AppConfig.of(context).appWidth(6.0),
          top: AppConfig.of(context).appWidth(8.0),
          bottom: AppConfig.of(context).appWidth(7.0)),
      margin: EdgeInsets.symmetric(
        vertical: AppConfig.of(context).appWidth(4.5),
      ),
      height: 93.3,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CoronaRichText(
              textOne: AppLocalizations.of(context)!.translate(AppString.coronavirus)!,
              textTwo: AppLocalizations.of(context)!.translate(AppString.in_worldWide)!),
          SizedBox(height: AppConfig.of(context).appWidth(3.5)),
          CovidConfirmCases(
              textOne: AppLocalizations.of(context)!.translate(AppString.confirmed_cases)!,
              textTwo: coronaUpdate!.worldwide!.summary!.coronaviruscases!),
          SizedBox(height: AppConfig.of(context).appWidth(3.5)),
          Divider(color: Colors.orange),
          SizedBox(height: AppConfig.of(context).appWidth(3.5)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CoronaStats(AppLocalizations.of(context)!.translate(AppString.recovered)!,
                  coronaUpdate!.worldwide!.summary!.recoverdcoronaviruscases!,
                  stringSize: 4.05),
              CoronaStats(AppLocalizations.of(context)!.translate(AppString.death)!,
                  coronaUpdate!.worldwide!.summary!.deathcoronaviruscases!,
                  stringSize: 4.05),
            ],
          ),
          SizedBox(height: AppConfig.of(context).appWidth(3.5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  context
                      .read<DomesticToInternation>()
                      .changeDomesticToInternation();
                },
                child: Text(AppLocalizations.of(context)!.translate(AppString.pakistan)!),
                style: Theme.of(context).elevatedButtonTheme.style,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.GLOBALDETAIL,
                        arguments: ScreenArguments(
                            data: coronaUpdate,
                            message: AppLocalizations.of(context)!
                                .translate(AppString.COVID)));
                  },
                  child: Text(AppString.read_more.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.red,
                          fontSize: AppConfig.of(context).appWidth(3),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w300)))
            ],
          ),
          InkWell(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppString.world_meter,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w300,
                    fontSize: AppConfig.of(context).appWidth(4)),
              ),
            ),
          )
        ],
      ),
      boxDecoration: BoxDecoration(
        color: context.watch<ThemeProvider>().selectedTheme
            ? AppColors.itemBackgroundScreenColor
            : Colors.white,
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 1.5),
              blurRadius: 0.5,
              spreadRadius: 1),
        ],
      ),
    );
  }
}
