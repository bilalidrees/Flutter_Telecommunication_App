import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/route_generator.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/cubit/corona/corona_news/corona_news_cubit.dart';
import 'package:ufone_web/src/cubit/corona/corona_update/corona_cubit.dart';
import 'package:ufone_web/src/model/corona_news.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';

class TrendingSectionWidget extends StatefulWidget {
  bool? isApiToCall;

  TrendingSectionWidget({Key? key, this.isApiToCall}) : super(key: key);

  @override
  _TrendingSectionWidgetState createState() => _TrendingSectionWidgetState();
}

class _TrendingSectionWidgetState extends State<TrendingSectionWidget> {
  int selectedToggle = 1;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.isApiToCall!) {
        BlocProvider.of<CoronaNewsCubit>(context).getCoronaNews();
      } else {
        BlocProvider.of<CoronaNewsCubit>(context).invokeSuccessState();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EnglishToUrduButton(selectedToggleButton: (id) {
            selectedToggle = id;
          }),
          SizedBox(height: AppConfig.of(context).appWidth(1.8)),
          BlocConsumer<CoronaNewsCubit, CoronaNewsState>(
            listener: (context, state) {
              if (state is CoronaErrorState) {
                // Toast.show("${state.message}", context,
                //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              }
            },
            builder: (context, state) {
              if (state is CoronaNewsSuccessState)
                return Directionality(
                    textDirection: selectedToggle == 1
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    child: EnglishToUrduList(
                        coronaUpdate: state.coronaNewsList,
                        isApiToCall: widget.isApiToCall!));
              else
                return Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
            },
          )
        ],
      ),
    );
  }
}

class EnglishToUrduButton extends StatefulWidget {
  final Function? selectedToggleButton;

  EnglishToUrduButton({Key? key, this.selectedToggleButton}) : super(key: key);

  @override
  _EnglishToUrduButtonState createState() => _EnglishToUrduButtonState();
}

class _EnglishToUrduButtonState extends State<EnglishToUrduButton> {
  bool toggle = true;
  int selectedToggle = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 20,
        width: 125,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppColors.greenColor)),
        child: Row(
          children: [
            Expanded(
                child: _container(
                    1, AppString.english.toUpperCase(), true, context, (id) {
              widget.selectedToggleButton!(id);
            })),
            Expanded(
                child: _container(
                    2, AppString.urdu.toUpperCase(), false, context, (id) {
              widget.selectedToggleButton!(id);
            }))
          ],
        ));
  }

  Widget _container(int id, String string, bool toggle, BuildContext context,
      Function selectedToggleButton) {
    return GestureDetector(
      onTap: () {
        selectedToggleButton(id);
        setState(() {
          selectedToggle = id;
          BlocProvider.of<CoronaNewsCubit>(context).change(toggle);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color:
              selectedToggle == id ? AppColors.greenColor : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Text(
          string,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 8.5,
                color: selectedToggle == id ? Colors.white : Colors.black,
                fontWeight: FontWeight.w300,
              ),
        ),
      ),
    );
  }
}

class EnglishToUrduList extends StatelessWidget {
  final List<CoronaNews>? coronaUpdate;
  bool? isApiToCall;

  EnglishToUrduList({Key? key, this.coronaUpdate, this.isApiToCall})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isApiToCall!
          ? AppConfig.of(context).appWidth(70)
          : null,
      width: double.infinity,
      child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.LOCAL_NEWS_DETAIL,
                    arguments: ScreenArguments(
                        buildContext: context, data: coronaUpdate![index]));
              },
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                dense: false,
                leading: Image.network(coronaUpdate![index].image!,
                    height: 90, width: 90),
                subtitle: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: AppConfig.of(context).appWidth(1)),
                        child: Text(coronaUpdate![index].title!,maxLines: 2,overflow: TextOverflow.ellipsis,)),
                    Row(
                      children: [
                        Text(coronaUpdate![index].date!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey, fontSize: 8)),
                        Spacer(),
                        Text(coronaUpdate![index].source!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.red, fontSize: 8)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, value) {
            return const Divider(color: Colors.orange);
          },
          itemCount: isApiToCall! ? 3 : coronaUpdate!.length),
    );
  }
}
