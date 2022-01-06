import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/model/corona_update.dart';
import 'package:ufone_web/src/ui/pages/global_detail_page/covid_table.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/String.dart';
import 'package:ufone_web/src/ui/widgets/coronaStats_container.dart';
import 'package:ufone_web/src/ui/widgets/corona_rich_text.dart';
import 'package:ufone_web/src/ui/widgets/covid_confirm_cases.dart';
import 'package:ufone_web/src/ui/widgets/main_container.dart';
import 'package:ufone_web/src/ui/widgets/symptoms_widget.dart';
import 'package:ufone_web/src/ui/widgets/web_app_bar.dart';

class GlobalDetail extends StatelessWidget {
  final CoronaUpdate coronaUpdate;
  final String? appBarMessage;

  const GlobalDetail({Key? key, required this.coronaUpdate, this.appBarMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: WebAppBar(appBarMessage: appBarMessage),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                MainContainer(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppConfig.of(context).appWidth(1.0),
                      vertical: AppConfig.of(context).appWidth(4.5)),
                  margin: EdgeInsets.symmetric(
                      vertical: AppConfig.of(context).appWidth(4.5),
                      horizontal: AppConfig.of(context).appWidth(2.9)),
                  height: 240,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: AppConfig.of(context).appWidth(6.0)),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           CoronaRichText(
                             textOne: AppLocalizations.of(context)!.translate(AppString.coronavirus)!,
                             textTwo: AppLocalizations.of(context)!.translate(AppString.in_worldWide)!,
                             textOneSize: AppConfig.of(context).appWidth(6.0),
                             textTwoSize: AppConfig.of(context).appWidth(6.0),
                           ),
                           SizedBox(height: AppConfig.of(context).appWidth(3.6)),
                           CovidConfirmCases(
                             textOne: AppLocalizations.of(context)!.translate(AppString.confirmed_cases)!,
                             textOneSize: AppConfig.of(context).appWidth(7.0),
                             textTwo:
                             coronaUpdate.worldwide!.summary!.coronaviruscases!,
                             textTwoSize: AppConfig.of(context).appWidth(7.0),
                           ),
                           SizedBox(height: AppConfig.of(context).appWidth(3.6)),
                           Divider(color: Colors.orange),
                           SizedBox(height: AppConfig.of(context).appWidth(3.6)),
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               CoronaStats(
                                 AppLocalizations.of(context)!.translate(AppString.recovered)!,
                                 coronaUpdate
                                     .worldwide!.summary!.recoverdcoronaviruscases!,
                                 valueSize: AppConfig.of(context).appWidth(2),
                                 stringSize: AppConfig.of(context).appWidth(1.3),
                               ),
                               CoronaStats(
                                 AppLocalizations.of(context)!.translate(AppString.death)!,
                                 coronaUpdate
                                     .worldwide!.summary!.deathcoronaviruscases!,
                                 stringSize: AppConfig.of(context).appWidth(1.3),
                                 valueSize: AppConfig.of(context).appWidth(2),
                               ),
                             ],
                           ),
                         ],
                       ),
                     ),
                      SizedBox(height: AppConfig.of(context).appWidth(3.6)),
                      Divider(color: Colors.grey),
                      GlobalCoronaDataTable(
                          countryStats: coronaUpdate.worldwide!.data!),
                    ],
                  ),
                ),

                SizedBox(height: AppConfig.of(context).appWidth(2)),
                SymptomsWidget(),
              ]),
            ),

          ],
        ));
  }
}
