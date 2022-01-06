import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/String.dart';
import 'package:ufone_web/src/ui/widgets/symptoms_widget.dart';
import '../../../../app_localizations.dart';
import '../../../cubit/corona/corona_update/corona_cubit.dart';
import 'package:ufone_web/src/model/corona_update.dart';
import 'package:ufone_web/src/ui/pages/local_detail_page/local_detail_page_container.dart';
import 'package:ufone_web/src/ui/widgets/web_app_bar.dart';

class LocalDetailPage extends StatefulWidget {
  final CoronaUpdate? coronaUpdate;
  final String? appBarMessage;

  const LocalDetailPage({Key? key, this.coronaUpdate, this.appBarMessage})
      : super(key: key);

  @override
  _LocalDetailPageState createState() => _LocalDetailPageState();
}

class _LocalDetailPageState extends State<LocalDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: WebAppBar(appBarMessage: AppString.coronavirus),
        ),
        body: CustomScrollView(
        //  physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                LocalDetailPageContainer(coronaUpdate: widget.coronaUpdate),
                SizedBox(height: AppConfig.of(context).appWidth(2)),
                SymptomsWidget(),
              ]),
            ),
          ],
        ));
  }
}
