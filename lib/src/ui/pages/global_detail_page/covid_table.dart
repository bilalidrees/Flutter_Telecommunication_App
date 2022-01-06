
import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/model/country_stats.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/String.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';

class GlobalCoronaDataTable extends StatefulWidget {
  final List<CountryStats> countryStats;

  GlobalCoronaDataTable({Key? key, required this.countryStats})
      : super(key: key);

  @override
  State<GlobalCoronaDataTable> createState() => _GlobalCoronaDataTableState();
}

class _GlobalCoronaDataTableState extends State<GlobalCoronaDataTable> {
  var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  ExampleSource? source;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    source =
        ExampleSource(countryStats: widget.countryStats, buildContext: context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AdvancedPaginatedDataTable(
        addEmptyRows: false,
        columnSpacing: AppConfig.of(context).appWidth(3),
        horizontalMargin: AppConfig.of(context).appWidth(3),
        source: source!,
        rowsPerPage: rowsPerPage,
        columns: [
          DataColumn(label: _DataText(AppString.country)),
          DataColumn(label: _DataText(AppString.totalCases)),
          DataColumn(label: _DataText(AppString.newCases)),
          DataColumn(label: _DataText(AppString.totalDeaths)),
          DataColumn(label: _DataText(AppString.newDeaths)),
          DataColumn(label: _DataText(AppString.totalRecovered)),
          DataColumn(label: _DataText(AppString.activeCases)),
          DataColumn(label: _DataText(AppString.critical)),
          DataColumn(label: _DataText(AppString.million)),
          DataColumn(label: _DataText(AppString.DeathsOrPop)),
          DataColumn(label: _DataText(AppString.firstCase)),
        ],
      ),
    );
  }
}

class ExampleSource extends AdvancedDataTableSource<CountryStats> {
  List<CountryStats>? countryStats;
  BuildContext? buildContext;

  ExampleSource({this.countryStats, this.buildContext});

  @override
  DataRow? getRow(int index) {
    final currentRowData = lastDetails!.rows[index];
    return DataRow(cells: [
      DataCell(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: AppConfig.of(buildContext!).appWidth(20),
            child: Text(
              currentRowData.country!,
              style: Theme.of(buildContext!).textTheme.bodyText1!.copyWith(
                  color: AppColors.orangeColor,
                  fontSize: AppConfig.of(buildContext!).appWidth(3.5)),
              maxLines: 2,
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                left: AppConfig.of(buildContext!).appWidth(0),
              ),
              height: AppConfig.of(buildContext!).appWidth(5),
              child: VerticalDivider(color: Colors.black))
        ],
      )),
      DataCell(
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                currentRowData.totalCases!,
                style: Theme.of(buildContext!)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 13, fontWeight: FontWeight.w300),
              ),
              Container(
                  margin: EdgeInsets.only(
                    left: AppConfig.of(buildContext!).appWidth(2),
                  ),
                  height: AppConfig.of(buildContext!).appWidth(5),
                  child: VerticalDivider(color: Colors.black))
            ],
          ),
        ),
      ),
      DataCell(
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                currentRowData.newCases!,
                style: Theme.of(buildContext!)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 13, fontWeight: FontWeight.w300),
              ),
              Container(
                  margin: EdgeInsets.only(
                    left: AppConfig.of(buildContext!).appWidth(2),
                  ),
                  height: AppConfig.of(buildContext!).appWidth(5),
                  child: VerticalDivider(color: Colors.black))
            ],
          ),
        ),
      ),
      DataCell(
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                currentRowData.totalDeaths!,
                style: Theme.of(buildContext!)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 13, fontWeight: FontWeight.w300),
              ),
              Container(
                  margin: EdgeInsets.only(
                    left: AppConfig.of(buildContext!).appWidth(2),
                  ),
                  height: AppConfig.of(buildContext!).appWidth(5),
                  child: VerticalDivider(color: Colors.black))
            ],
          ),
        ),
      ),
      DataCell(
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                currentRowData.newDeaths!,
                style: Theme.of(buildContext!)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 13, fontWeight: FontWeight.w300),
              ),
              Container(
                  margin: EdgeInsets.only(
                    left: AppConfig.of(buildContext!).appWidth(2),
                  ),
                  height: AppConfig.of(buildContext!).appWidth(5),
                  child: VerticalDivider(color: Colors.black))
            ],
          ),
        ),
      ),
      DataCell(
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                currentRowData.totalRecovered!,
                style: Theme.of(buildContext!)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 13, fontWeight: FontWeight.w300),
              ),
              Container(
                  margin: EdgeInsets.only(
                    left: AppConfig.of(buildContext!).appWidth(2),
                  ),
                  height: AppConfig.of(buildContext!).appWidth(5),
                  child: VerticalDivider(color: Colors.black))
            ],
          ),
        ),
      ),
      DataCell(
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                currentRowData.activeCases!,
                style: Theme.of(buildContext!)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 13, fontWeight: FontWeight.w300),
              ),
              Container(
                  margin: EdgeInsets.only(
                    left: AppConfig.of(buildContext!).appWidth(2),
                  ),
                  height: AppConfig.of(buildContext!).appWidth(5),
                  child: VerticalDivider(color: Colors.black))
            ],
          ),
        ),
      ),
      DataCell(
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                currentRowData.seriousCritical!,
                style: Theme.of(buildContext!)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 13, fontWeight: FontWeight.w300),
              ),
              Container(
                  margin: EdgeInsets.only(
                    left: AppConfig.of(buildContext!).appWidth(2),
                  ),
                  height: AppConfig.of(buildContext!).appWidth(5),
                  child: VerticalDivider(color: Colors.black))
            ],
          ),
        ),
      ),
      DataCell(
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                currentRowData.totalCasessOr1MPop!,
                style: Theme.of(buildContext!)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 13, fontWeight: FontWeight.w300),
              ),
              Container(
                  margin: EdgeInsets.only(
                    left: AppConfig.of(buildContext!).appWidth(2),
                  ),
                  height: AppConfig.of(buildContext!).appWidth(5),
                  child: VerticalDivider(color: Colors.black))
            ],
          ),
        ),
      ),
      DataCell(
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                currentRowData.deathsOr1MPop!,
                style: Theme.of(buildContext!)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 13, fontWeight: FontWeight.w300),
              ),
              Container(
                  margin: EdgeInsets.only(
                    left: AppConfig.of(buildContext!).appWidth(2),
                  ),
                  height: AppConfig.of(buildContext!).appWidth(5),
                  child: VerticalDivider(color: Colors.black))
            ],
          ),
        ),
      ),
      DataCell(
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                currentRowData.firstCase!,
                style: Theme.of(buildContext!)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 13, fontWeight: FontWeight.w300),
              ),
              Container(
                  margin: EdgeInsets.only(
                    left: AppConfig.of(buildContext!).appWidth(2),
                  ),
                  height: AppConfig.of(buildContext!).appWidth(5),
                  child: VerticalDivider(color: Colors.black))
            ],
          ),
        ),
      ),
    ]);
  }

  @override
  int get selectedRowCount => 0;

  @override
  Future<RemoteDataSourceDetails<CountryStats>> getNextPage(
      NextPageRequest pageRequest) async {
    return RemoteDataSourceDetails(
      countryStats!.length,
      countryStats!
          .skip(pageRequest.offset)
          .take(pageRequest.pageSize)
          .toList(), //again in a real world example you would only get the right amount of rows
    );
  }
}

class _DataText extends StatelessWidget {
  final String text;

  _DataText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConfig.of(context).appWidth(17),
      child: Text(text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: AppColors.orangeColor,
              fontSize: AppConfig.of(context).appWidth(3.5)),
          maxLines: 2,
          softWrap: true),
    );
  }
}
