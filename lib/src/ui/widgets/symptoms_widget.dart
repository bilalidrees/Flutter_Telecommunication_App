import 'package:flutter/material.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/ui/ui_constants/resolvers/image_assets_resolver.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/String.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';

class SymptomsWidget extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SymptomsWidget> {
  bool isSymptomSelected = false,
      isPrecautionSelected = false,
      isLaboritoriesSeleceted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppConfig.of(context).appWidth(6.0),
          vertical: AppConfig.of(context).appWidth(4.5)),
      margin: EdgeInsets.symmetric(
        vertical: AppConfig.of(context).appWidth(4.5),
        horizontal: AppConfig.of(context).appWidth(2.9),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              onPressed: () {
                setState(() {
                  isSymptomSelected = !isSymptomSelected;
                });
              },
              child: Text(AppString.SYMPTOMS)),
          if (isSymptomSelected)
            Wrap(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: AppConfig.of(context).appWidth(1),
                    horizontal: AppConfig.of(context).appWidth(2.9),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.translate(AppString.symptomsText)!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: AppConfig.of(context).appWidth(4)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Image.network(
                              ImageAssetsResolver.cough,
                              fit: BoxFit.cover,
                              width: AppConfig.of(context).appWidth(30),
                              height: AppConfig.of(context).appWidth(30),
                            ),
                            SizedBox(
                              height: AppConfig.of(context).appWidth(1),
                            ),
                            Text(
                              " ${AppLocalizations.of(context)!.translate(AppString.caughing)} ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: AppColors.orangeColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize:
                                          AppConfig.of(context).appWidth(3)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Image.network(
                              ImageAssetsResolver.fever,
                              fit: BoxFit.cover,
                              width: AppConfig.of(context).appWidth(30),
                              height: AppConfig.of(context).appWidth(30),
                            ),
                            SizedBox(
                              height: AppConfig.of(context).appWidth(1),
                            ),
                            Text(
                              "  ${AppLocalizations.of(context)!.translate(AppString.fever)} ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: AppColors.orangeColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize:
                                          AppConfig.of(context).appWidth(3)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  // margin: EdgeInsets.symmetric(
                  //   vertical: AppConfig.of(context).appWidth(1),
                  //   horizontal: AppConfig.of(context).appWidth(4),
                  // ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Image.network(
                              ImageAssetsResolver.breath,
                              fit: BoxFit.cover,
                              width: AppConfig.of(context).appWidth(30),
                              height: AppConfig.of(context).appWidth(30),
                            ),
                            SizedBox(height: AppConfig.of(context).appWidth(1)),
                            Text(
                              " ${AppLocalizations.of(context)!.translate(AppString.breath)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: AppColors.orangeColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize:
                                          AppConfig.of(context).appWidth(3)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Image.network(
                              ImageAssetsResolver.throat,
                              fit: BoxFit.cover,
                              width: AppConfig.of(context).appWidth(30),
                              height: AppConfig.of(context).appWidth(30),
                            ),
                            SizedBox(
                              height: AppConfig.of(context).appWidth(1),
                            ),
                            Text(
                              "${AppLocalizations.of(context)!.translate(AppString.throat)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: AppColors.orangeColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize:
                                          AppConfig.of(context).appWidth(3)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              onPressed: () {
                setState(() {
                  isPrecautionSelected = !isPrecautionSelected;
                });
              },
              child: Text(AppString.PRECAUTIONS)),
          // SizedBox(height: AppConfig.of(context).appWidth(4)),
          if (isPrecautionSelected)
            Wrap(
              direction: Axis.horizontal,
              children: [
                Text(
                  " ${AppLocalizations.of(context)!.translate(AppString.precautionHeading)}",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: AppConfig.of(context).appWidth(4)),
                ),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.pointOne)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.pointTwo)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.pointThree)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.pointFour)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.pointFour)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.pointSix)!),
              ],
            ),
          //SizedBox(height: AppConfig.of(context).appWidth(4)),
          ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              onPressed: () {
                setState(() {
                  isLaboritoriesSeleceted = !isLaboritoriesSeleceted;
                });
              },
              child: Text(AppString.LABORTORIES)),
          if (isLaboritoriesSeleceted)
            Wrap(
              direction: Axis.horizontal,
              children: [
                _BulletHeading(text: AppLocalizations.of(context)!.translate(AppString.Islamabad)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.NIH)!),
                _BulletHeading(text: AppLocalizations.of(context)!.translate(AppString.Karachi)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.Aga)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.Civil_Hospital)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.Ojha)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.Indus)!),
                _BulletHeading(text: AppLocalizations.of(context)!.translate(AppString.Rawalpindi)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.AFIP)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.AIDS_Lab)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.Shaukat_Khanum)!),
                _BulletHeading(text: AppLocalizations.of(context)!.translate(AppString.Multan)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.Nishtar)!),
                _BulletHeading(text: AppLocalizations.of(context)!.translate(AppString.Peshawer)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.Punjab_Health)!),
                _BulletHeading(text: AppLocalizations.of(context)!.translate(AppString.Quetta)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.Fatima_Jinnah)!),
                _BulletHeading(text: AppLocalizations.of(context)!.translate(AppString.Gilgit_Baltistan)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.DHQ)!),
                _BulletHeading(text: AppLocalizations.of(context)!.translate(AppString.Muzaffarabad)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.Muzaffarabad_Medical)!),
                _BulletHeading(text: AppLocalizations.of(context)!.translate(AppString.Others)!),
                _BulletText(text: AppLocalizations.of(context)!.translate(AppString.Mobile_Diagnosti)!),
              ],
            ),
        ],
      ),
    );
  }
}

class _MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 5.0,
      width: 5.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  final String text;

  const _BulletText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppConfig.of(context).appWidth(4),
        left: AppConfig.of(context).appWidth(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _MyBullet()),
          Expanded(
            flex: 9,
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: AppConfig.of(context).appWidth(4)),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletHeading extends StatelessWidget {
  final String text;

  const _BulletHeading({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(fontWeight: FontWeight.w400, color: Colors.black,fontSize: AppConfig.of(context).appWidth(4.2)),
    );
  }
}
