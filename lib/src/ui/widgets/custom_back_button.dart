import 'package:flutter/material.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/provider/theme_provider.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:provider/provider.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: context.watch<ThemeProvider>().selectedTheme
            ? AppColors.itemBackgroundScreenColor
            : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[600]!,
            offset: Offset(4.0, 4.0),
            blurRadius: 3.0,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-2.0, -2.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
