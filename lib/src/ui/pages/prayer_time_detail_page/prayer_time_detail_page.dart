import 'package:flutter/material.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/bloc/utility/string_extensions.dart';
import 'package:ufone_web/src/cubit/prayer/prayer_cubit.dart';
import 'package:ufone_web/src/model/prayer.dart';
import 'package:ufone_web/src/ui/ui_constants/resolvers/image_assets_resolver.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';
import 'package:ufone_web/src/ui/widgets/main_container.dart';
import 'package:ufone_web/src/ui/widgets/web_app_bar.dart';

class PrayerTimeDetail extends StatelessWidget {
  final PrayerCubit prayer;

  const PrayerTimeDetail({Key? key, required this.prayer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final prayer = BlocProvider.of<PrayerCubit>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: WebAppBar(appBarMessage: AppString.PRAYER_DETAILS),
        ),
        body: Container(
            height: AppConfig.of(context).appWidth(250),
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.bottomCenter,
                  image: AssetImage(
                    ImageAssetsResolver.Mosque_Image,
                  )),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.lightGreen[300]!.withOpacity(0.3),
                    AppColors.greenColor.withOpacity(0.8),
                  ]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: prayer.prayerList.map((e) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: AppConfig.of(context).appWidth(5)),
                      padding: EdgeInsets.symmetric(
                          horizontal: AppConfig.of(context).appWidth(3),
                          vertical: AppConfig.of(context).appWidth(3)),
                      color: e.isCurrentNamaz!
                          ? AppColors.greenColor.withOpacity(0.5)
                          : Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.translate(e.namazName!),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                          ),
                          Text(
                            e.namazTime!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                Column(
                  children: [
                    Text(
                      prayer.nowText!,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: AppConfig.of(context).appWidth(10),
                          color: AppColors.greenColor,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      prayer.nextText!,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontWeight: FontWeight.w300,fontSize: AppConfig.of(context).appWidth(7), color: AppColors.greenColor),
                    ),
                    SizedBox(
                      height: AppConfig.of(context).appWidth(43),
                    )
                  ],
                )
              ],
            )));
  }
}
