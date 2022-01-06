import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/app.dart';
import 'package:ufone_web/src/bloc/news_bloc.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/bloc/utility/app_utility.dart';
import 'package:ufone_web/src/model/Category.dart';
import 'package:ufone_web/src/model/SubCategory.dart';
import 'package:ufone_web/src/provider/theme_provider.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/String.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/style.dart';
import 'package:ufone_web/src/ui/widgets/custom_exception.dart';
import 'package:ufone_web/src/ui/widgets/custom_loader.dart';
import 'package:ufone_web/src/ui/widgets/custom_news_widget.dart';
import 'package:ufone_web/src/ui/widgets/custom_selection_widget.dart';
import 'package:ufone_web/src/ui/widgets/custom_shimmer_view.dart';
import 'package:ufone_web/src/ui/widgets/customt_title_widget.dart';
import '../../../../route_generator.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class SubCategoryPage extends StatefulWidget {
  Category category;

  SubCategoryPage({required this.category});

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  int selectedValue = 0;
  bool isDataFetching = true;
  NewsBloc? newsBloc;
  bool isLoading = true;
  String? currentSelectedSubCategorySource,
      currentSelectedSubCategorySourceLogo;

  @override
  void initState() {
    newsBloc = NewsBloc();
    Future.delayed(Duration.zero, () {
      newsBloc!
          .saveCategoriesImages(widget.category, context)
          .then((updatedCategory) {
        widget.category = updatedCategory;
        currentSelectedSubCategorySource = widget.category.item!.first!.name;
        newsBloc!.setFeedState(widget.category.item!.first!.name);
        newsBloc!.newsFeedStream.listen((newsFeedList) {
          AppUtility.getPublishTime(newsFeedList).then((list) {
            newsBloc!.newsFeedList = list;
            newsBloc!
                .getSourceImages(currentSelectedSubCategorySource!, context)
                .then((value) {
              currentSelectedSubCategorySourceLogo = value;
              setState(() {
                isDataFetching = false;
                isLoading = false;
              });
            });
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().selectedTheme
                ? AppColors.darkBackgroundScreenColor
                : Colors.grey[200],
          ),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: AppConfig.of(context).appWidth(1.8),
                  ),
                  Padding(
                      padding: Styles.getScreenPadding(context),
                      child: CustomTitleWidget(
                          context: context,
                          title:
                              "${widget.category.category} ${AppLocalizations.of(context)!.translate(AppString.TOP_CATEGORIES)}")),
                  SizedBox(
                    height: AppConfig.of(context).appWidth(5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppConfig.of(context).appWidth(7.4)),
                    child: categoriesWidget(context),
                  ),
                  SizedBox(
                    height: AppConfig.of(context).appWidth(1),
                  ),
                ]),
              ),
              isDataFetching
                  ? SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(height: AppConfig.of(context).appWidth(5)),
                        Container(
                            height: AppConfig.of(context).appWidth(120),
                            child: Center(child: CustomShimmerView()))
                      ]),
                    )
                  : showHeadlines()
            ],
          ),
        ),
      );
    } else {
      return CustomLoader();
    }
  }

  Widget showHeadlines() {
    if (newsBloc!.newsFeedList!.isNotEmpty) {
      return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
        var newsFeed = newsBloc!.newsFeedList![index];
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 200),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: CustomNewsWidget(
                onPressed: () {
                  FirebaseAnalyticsObservers.firebaseObserver.analytics
                      .logEvent(name: "news_event${newsFeed.title}");
                  Navigator.of(context).pushNamed(RouteNames.NEWS_DETAILS,
                      arguments: ScreenArguments(
                          data: newsFeed,
                          message: currentSelectedSubCategorySourceLogo));
                },
                newsFeed: newsFeed,
                logoUrl: currentSelectedSubCategorySourceLogo!,
              ),
            ),
          ),
        );
      }, childCount: newsBloc!.newsFeedList!.length));
    } else {
      return SliverToBoxAdapter(child: CustomException());
    }
  }

  Container categoriesWidget(BuildContext context) {
    return Container(
      height: AppConfig.of(context).appWidth(39),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          SubCategory subCategory = widget.category.item![index]!;
          return GestureDetector(
            onTap: () {
              FirebaseAnalyticsObservers.firebaseObserver.analytics
                  .logEvent(name: "sub_category_event${subCategory.name}");
              currentSelectedSubCategorySource = subCategory.name;
              newsBloc!.setFeedState(subCategory.name);
              setState(() {
                selectedValue = index;
                isDataFetching = true;
              });
            },
            child: CustomSelectionWidget(
                subCategory: subCategory,
                value: index,
                selectedValue: selectedValue),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: AppConfig.of(context).appWidth(2.66),
          );
        },
        itemCount: widget.category.item!.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
