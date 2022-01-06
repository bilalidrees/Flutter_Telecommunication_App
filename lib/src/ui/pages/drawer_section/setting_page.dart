import 'package:flutter/material.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/model/home_card_status.dart';
import 'package:ufone_web/src/provider/theme_provider.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';
import 'package:ufone_web/src/ui/widgets/web_app_bar.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  final void Function(int, bool)? homeCardsOptionCallback;

  const SettingPage({Key? key, required this.homeCardsOptionCallback})
      : super(key: key);
  final _sizeBox = const SizedBox(height: 25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: WebAppBar(
            centerTitle: true,
            appBarMessage:AppString.SETTINGS),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            _sizeBox,
            _sizeBox,
            _DropdownSetting(
              AppString.myLocation,
              data: [AppString.Karachi, AppString.Islamabad, AppString.Gilgit_Baltistan],
            ),
            _sizeBox,
            _ToggleSetting(AppString.Notification, false, callback: (value) {}),
            _sizeBox,
            _Checkbox(
              AppString.home_card,
              data: HomeCardStatus.getList(),
              onChange: (index, value) {
                homeCardsOptionCallback!(index, value);
              },
            ),
            _sizeBox,
            // _ToggleSetting('Application Tour', false, callback: (value) {}),
            _ToggleSetting(
                AppString.darkMode, context.watch<ThemeProvider>().selectedTheme,
                callback: (value) {
              context.read<ThemeProvider>().setTheme(value);
            }),
          ],
        ),
      ),
    );
  }
}

class _Checkbox extends StatelessWidget {
  final String text;
  final List<HomeCardStatus> data;
  final void Function(int, bool)? onChange;

  const _Checkbox(this.text,
      {Key? key, required this.data, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (BuildContext context,
                  StateSetter bottomSheetSetState /*You can rename this!*/) {
                return AlertDialog(
                  title: Center(
                      child: Column(
                        children: [
                          _SettingText(AppString.home_card,
                              color: AppColors.greenColor),
                          Divider(thickness: 1),
                        ],
                      )),
                  content: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                          activeColor: AppColors.orangeColor,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: _SettingText(data[index].text),
                          value: data[index].value,
                          onChanged: (value) {
                            if (data.contains(data[index])) {
                              ///updating hashmap to save status
                              HomeCardStatus.homeCardMap[index] = value!;

                              ///updating ui
                              bottomSheetSetState(() {
                                data[index].value = value;
                              });
                            }
                            onChange!(index, value!);
                          });
                    },
                  ),
                  actions: [
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.greenColor),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('ok',
                              style: Theme.of(context).textTheme.bodyText1)),
                    ),
                  ],
                );
              });
            });
      },
      child: Row(
        children: [
          _SettingText(text),
          Spacer(),
          Row(
            children: [
              _SettingText(data[0].text),
              SizedBox(width: 5),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ],
      ),
    );
  }
}

class _DropdownSetting extends StatelessWidget {
  final String text;
  final List<String> data;

  const _DropdownSetting(this.text, {Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SettingText(text),
        Spacer(),
        DropdownButton<String>(
          dropdownColor: Colors.white,
          items: data.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: _SettingText(value),
            );
          }).toList(),
          onChanged: (value) {},
        )
      ],
    );
  }
}

class _ToggleSetting extends StatelessWidget {
  final String text;
  final bool isSelected;
  final void Function(bool)? callback;

  const _ToggleSetting(this.text, this.isSelected, {Key? key, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SettingText(text),
        Spacer(),
        Consumer<ThemeProvider>(
          builder: (context, select, child) {
            return Switch(
              value: isSelected,
              onChanged: (value) {
                callback!(value);
              },
              activeTrackColor: AppColors.greenColor,
              activeColor: Colors.white,
            );
          },
        ),
      ],
    );
  }
}

class _SettingText extends StatelessWidget {
  final String text;
  final Color? color;

  const _SettingText(this.text, {Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.of(context)!.translate(text),
      style: color != null
          ? Theme.of(context).textTheme.bodyText1!.copyWith(color: color)
          : Theme.of(context).textTheme.bodyText1,
    );
  }
}

enum HomeCardEnum {
  corona,
  prayer,
  weather,
  exchange,
}
