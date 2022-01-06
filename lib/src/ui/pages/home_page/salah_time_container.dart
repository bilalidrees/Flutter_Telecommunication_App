import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/route_generator.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/cubit/prayer/prayer_cubit.dart';
import 'package:ufone_web/src/model/prayer_info.dart';
import 'package:ufone_web/src/provider/theme_provider.dart';
import 'package:ufone_web/src/ui/pages/prayer_time_detail_page/prayer_time_detail_page.dart';
import 'package:ufone_web/src/ui/ui_constants/resolvers/image_assets_resolver.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';
import 'package:ufone_web/src/ui/widgets/main_container.dart';

class SalahTime extends StatelessWidget {
  final PrayerInfo prayerInfo;
  const SalahTime({Key? key, required this.prayerInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prayer = BlocProvider.of<PrayerCubit>(context);
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute<PrayerTimeDetail>(
            builder: (_) => BlocProvider.value(
              value: BlocProvider.of<PrayerCubit>(context),
              child: PrayerTimeDetail(prayer: prayer
              ),
            ),
          ),
        );
      },
      child: MainContainer(
          padding: EdgeInsets.symmetric(
              horizontal: AppConfig.of(context).appWidth(6.0),
              vertical: AppConfig.of(context).appWidth(1.5)),
          margin: EdgeInsets.symmetric(vertical: AppConfig.of(context).appWidth(4.5)),
          height: 78,
          width: double.infinity,
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
                  spreadRadius: 1)
            ],
          ),
          child: Column(
            children: [
              Container(
                height: AppConfig.of(context).appWidth(30),
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                        child: Image.asset(
                      ImageAssetsResolver.Mosque_PNG,
                    )),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(prayer.nowText!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: AppColors.greenColor,
                                      fontSize:
                                          AppConfig.of(context).appWidth(5.0),
                                      fontWeight: FontWeight.w400)),
                          Text("${prayer.nextText}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.orange,
                                      fontSize:
                                          AppConfig.of(context).appWidth(5.4),
                                      fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppConfig.of(context).appWidth(1.0)),

              Row(
                children: prayer.prayerList
                    .asMap()
                    .map((i, element) => MapEntry(
                        i,
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: AppConfig.of(context).appWidth(40),
                                //width: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          element.isCurrentNamaz!
                                              ? ImageAssetsResolver
                                                  .light_image_list[i]
                                              : ImageAssetsResolver
                                                  .dark_image_list[i]),
                                      fit: BoxFit.fill),
                                  border: element.isCurrentNamaz!
                                      ? Border.all(
                                          color: AppColors.greenColor,
                                          width: 2.5)
                                      : Border.all(
                                          color: Colors.transparent, width: 0),
                                  // color: e.isCurrentNamaz!?Colors.orange:Colors.lime
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    top: AppConfig.of(context).appWidth(25)),
                                height: AppConfig.of(context).appWidth(7),
                                //width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300]!.withOpacity(0.6),
                                ),
                                child: Text(
                                  element.namazTime!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                    color: element.isCurrentNamaz!?Colors.white:Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        )))
                    .values
                    .toList(),
              ),
            ],
          )),
    );
  }
}
