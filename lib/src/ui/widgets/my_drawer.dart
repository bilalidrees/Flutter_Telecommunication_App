import 'package:flutter/material.dart';

import 'package:ufone_web/src/bloc/authentication_bloc.dart';

import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/bloc/utility/shared_pref.dart';
import 'package:ufone_web/src/model/User.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/String.dart';

import '../../../app_localizations.dart';
import '../../../route_generator.dart';

class MyDrawer extends StatefulWidget {
  //AnimationController _animationController;
  AuthenticationBloc authenticationBloc;

  MyDrawer({Key? key, required this.authenticationBloc}) : super(key: key);

  @override
  MyDrawerState createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  int currentSelectedDrawerItem = 0;
  User? user;


  @override
  void initState() {

    super.initState();
    print("open");
    //widget._animationController.forward();
  }

  @override
  void dispose() {
    print("close");
    super.dispose();
    //widget._animationController.reverse();
  }

  void refreshDrawer() async {
    user = await SharedPref.createInstance().getCurrentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              const Color(0xFFc01010),
              const Color(0xFFc01010),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          drawerHeader(context),
          drawerBody(context),
        ],
      ),
    );
  }

  Container drawerBody(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          addDrawerItem(Icons.home_filled, 2,
              AppLocalizations.of(context)!.translate(AppString.HOME)!, () {
            widget.authenticationBloc.loginDrawerStreamController.sink.add({});
          }),
          // SizedBox(height: AppConfig.of(context).appWidth(3)),
          // addDrawerItem(Icons.perm_device_information, 3,
          //     AppLocalizations.of(context)!.translate(Strings.ABOUT)!, () {
          //       Navigator.of(context).pushNamed(RouteNames.MAINPAGE,
          //           arguments: ScreenArguments(
          //               currentPage: About(),
          //               message: AppLocalizations.of(context)!
          //                   .translate(Strings.ABOUTS)));
          //       widget.authenticationBloc.loginDrawerStreamController.sink.add({});
          //     }),
          SizedBox(height: AppConfig.of(context).appWidth(3)),
          if (user != null) SizedBox(height: AppConfig.of(context).appWidth(3)),
          if (user != null)
            addDrawerItem(Icons.perm_identity, 5,
                AppLocalizations.of(context)!.translate(AppString.PROFILE)!, () {
              Navigator.of(context).pushNamed(RouteNames.PROFILE);
              widget.authenticationBloc.loginDrawerStreamController.sink
                  .add({});
            }),
          SizedBox(height: AppConfig.of(context).appWidth(3)),
          user != null
              ? addDrawerItem(Icons.logout, 5,
                  AppLocalizations.of(context)!.translate(AppString.LOGOUT)!,
                  () async {
                 // await widget.authenticationBloc.socialSignOut();
                  widget.authenticationBloc.loginDrawerStreamController.sink
                      .add({});
                })
              : addDrawerItem(Icons.login, 5,
                  AppLocalizations.of(context)!.translate(AppString.LOGIN)!, () {
                  Navigator.of(context).pushNamed(RouteNames.LOGIN);
                  widget.authenticationBloc.loginDrawerStreamController.sink
                      .add({});
                }),
        ],
      ),
    );
  }

  Container drawerHeader(BuildContext context) {
    if (user != null)
      return Container(
        margin: EdgeInsets.only(
            left: AppConfig.of(context).appWidth(2),
            top: AppConfig.of(context).appWidth(6),
            bottom: AppConfig.of(context).appWidth(35)),
        child: Row(
          children: [
            if (user!.picture != null)
              CircleAvatar(backgroundImage: NetworkImage(user!.picture)),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   user!.fullname ?? user!.email,
                //   style: Theme.of(context).textTheme.headline1,
                // ),
              ],
            )
          ],
        ),
      );
    else
      return Container(
        margin: EdgeInsets.only(
            left: AppConfig.of(context).appWidth(2),
            top: AppConfig.of(context).appWidth(6),
            bottom: AppConfig.of(context).appWidth(35)),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate(AppString.WELCOME)!,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            )
          ],
        ),
      );
  }

  addDrawerItem(
      IconData icon, int id, String itemName, GestureTapCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: IconButton(
                  icon: Icon(icon),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            Container(
              width: AppConfig.of(context).appWidth(35),
              child: Text(
                itemName,
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.start,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
