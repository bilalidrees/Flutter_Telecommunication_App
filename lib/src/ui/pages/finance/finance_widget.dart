import 'package:flutter/material.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/model/forex_finance.dart';
import 'package:ufone_web/src/model/kse_rate_finance.dart';
import 'package:ufone_web/src/provider/theme_provider.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';
import 'package:ufone_web/src/ui/widgets/currency_rate_widget.dart';
import 'package:ufone_web/src/ui/widgets/index_widget.dart';
import 'package:ufone_web/src/ui/widgets/main_container.dart';
import 'package:provider/provider.dart';
class FinanceWidget extends StatelessWidget {
  final KseRateFinance? kseRateFinance;
  final ForexFinance? forexFinance;

  FinanceWidget({this.kseRateFinance, this.forexFinance});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainContainer(
          padding: EdgeInsets.symmetric(
              horizontal: AppConfig.of(context).appWidth(6.0),
              vertical: AppConfig.of(context).appWidth(6.5)),
          margin: EdgeInsets.symmetric(
              vertical: AppConfig.of(context).appWidth(4.5)),
          height: 75,
          width: double.infinity,
          boxDecoration: BoxDecoration(
            color: context.watch<ThemeProvider>().selectedTheme
                ? AppColors.itemBackgroundScreenColor
                : Colors.white,
            borderRadius: BorderRadius.circular(18.0),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 1.5),
                  blurRadius: 0.5,
                  spreadRadius: 1)
            ],
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(kseRateFinance!.kseRate![0].indexCode!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: AppConfig.of(context).appWidth(4.5),
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              SizedBox(height: AppConfig.of(context).appWidth(1.5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_drop_up_outlined,
                    color: AppColors.greenColor,
                    size: AppConfig.of(context).appWidth(15.5),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: AppConfig.of(context).appWidth(8)),
                    child: Text(
                        kseRateFinance!.kseRate![0].currentIndex!
                            .split(".")
                            .first,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.black,
                            fontSize: AppConfig.of(context).appWidth(6.5),
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
              SizedBox(height: AppConfig.of(context).appWidth(3.3)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IndexWidget(
                      indexKey: AppLocalizations.of(context)!.translate(AppString.lowIndex),
                      indexValue: kseRateFinance!.kseRate![0].lowIndex),
                  IndexWidget(
                      indexKey: AppLocalizations.of(context)!.translate(AppString.highIndex),
                      indexValue: kseRateFinance!.kseRate![0].highIndex),
                ],
              ),
              SizedBox(height: AppConfig.of(context).appWidth(3.8)),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: AppConfig.of(context).appWidth(1)),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.lightGreen[400],
                ),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.translate(AppString.net_change)!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                    //SizedBox(height: AppConfig.of(context).appWidth(1)),
                    Text(
                      kseRateFinance!.kseRate![0].netChange!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        MainContainer(
          padding: EdgeInsets.symmetric(
              horizontal: AppConfig.of(context).appWidth(6.0),
              vertical: AppConfig.of(context).appWidth(5)),
          margin: EdgeInsets.symmetric(
              vertical: AppConfig.of(context).appWidth(4.5)),
          height: 80,
          width: double.infinity,
          boxDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.0),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 1.5),
                  blurRadius: 0.5,
                  spreadRadius: 1)
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: AppConfig.of(context).appWidth(1.5),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey,
                  child: CurrencyRateWidget(
                    textSize: 14,
                    flag: '',
                    currency: AppString.currency,
                    buying: AppString.buying,
                    selling: AppString.selling,
                  ),
                ),
              ),
              SizedBox(
                height: AppConfig.of(context).appWidth(3.2),
              ),
              Expanded(
                flex: 6,
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CurrencyRateWidget(
                        textSize: AppConfig.of(context).appWidth(4.6),
                        flag: forexFinance!.forex![index].key,
                        currency: forexFinance!.forex![index].key,
                        buying: forexFinance!.forex![index].value!.buying,
                        selling: forexFinance!.forex![index].value!.selling,
                      );
                    },
                    separatorBuilder: (context, value) {
                      return const Divider(color: Colors.orange);
                    },
                    itemCount: forexFinance!.forex!.length),
              ),
            ],
          ),
          // child: CustomScrollView(
          //   slivers: [
          //     SliverList(delegate: SliverChildListDelegate([])),
          //   ],
        ),
      ],
    );
  }
}
