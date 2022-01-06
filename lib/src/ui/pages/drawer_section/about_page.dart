import 'package:flutter/material.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/ui/ui_constants/resolvers/image_assets_resolver.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';
import 'package:ufone_web/src/ui/widgets/web_app_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);
  final SizedBox _sizedBox = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: WebAppBar(
            appBarMessage:AppString.ABOUT),
      ),
      body: Center(
        child: Column(

          children: [
            _sizedBox,
            _sizedBox,
            Image.asset(ImageAssetsResolver.ITGN_PLACEHOLDER_ICON),
            Spacer(),
            _AboutText(text: 'Version 1.0.6'),
            Spacer(flex: 1),
            _AboutText(text: 'build 17ce52c0bec',fontSize:8,fontWeight: FontWeight.w300),
            Spacer(flex: 2),
            _AboutText(text: 'Copyright'),
            Spacer(flex: 1),
            _AboutText(text: 'All rights reserved',fontSize:12,fontWeight: FontWeight.w300),
            Spacer(flex: 12),
            Divider(thickness: 1),
            _AboutText(text: 'CopyRight \u00a9 2019 Ufone',fontSize:12),
            _sizedBox,
          ],
        ),
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  final FontWeight fontWeight;
  final String text;
  final double fontSize;

  const _AboutText(
      {Key? key,
      this.text = '',
      this.fontWeight = FontWeight.w300,
      this.fontSize = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontWeight: fontWeight,fontSize: fontSize));
  }
}
