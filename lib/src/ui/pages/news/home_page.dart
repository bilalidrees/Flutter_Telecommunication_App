import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ufone_web/app_localizations.dart';
import 'package:ufone_web/src/app.dart';
import 'package:ufone_web/src/bloc/news_bloc.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/bloc/utility/app_utility.dart';
import 'package:ufone_web/src/model/NewsFeed.dart';
import 'package:ufone_web/src/provider/domestic_to_internation.dart';
import 'package:ufone_web/src/provider/theme_provider.dart';
import 'package:ufone_web/src/ui/pages/home_page/main_page.dart';
import 'package:ufone_web/src/ui/pages/news/sub_category_page.dart';
import 'package:ufone_web/src/ui/ui_constants/resolvers/image_assets_resolver.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/String.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/style.dart';
import 'package:ufone_web/src/ui/widgets/custom_category.dart';
import 'package:ufone_web/src/ui/widgets/custom_exception.dart';
import 'package:ufone_web/src/ui/widgets/custom_loader.dart';
import 'package:ufone_web/src/ui/widgets/custom_news_widget.dart';
import 'package:ufone_web/src/ui/widgets/custom_shimmer_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../../route_generator.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  bool isDataFetching = true;
  NewsBloc? newsBloc;

  List<NewsFeed>? newsFeeds;
  String? currentSelectedSubCategorySource,
      currentSelectedSubCategorySourceLogo =
          "https://i.tribune.com.pk/media/images/889544-EVMsEVMelectronicVotingMachineEXPRESS-1432138417/889544-EVMsEVMelectronicVotingMachineEXPRESS-1432138417.jpg";

  initState() {
    Future.delayed(Duration(seconds: 5)).then((value) {
      setState(() {
        isDataFetching = false;
      });
    });

    newsBloc = NewsBloc();
    AppUtility.checkApiBaseUrl().then((value) {
      newsBloc!
          .getCategories(context.read<DomesticToInternation>().localeState);
    });

    newsBloc!.categoryStream.listen((modelList) {
      newsBloc!.categoriesList = modelList;
      currentSelectedSubCategorySource =
          newsBloc!.categoriesList!.first.item!.first!.name;
      newsBloc!.setFeedState(newsBloc!.categoriesList!.first.item!.first!.name);
    });
    newsBloc!.newsFeedStream.listen((newsFeedList) {
      // newsFeeds = newsFeedList;
      // updateLoadingStatus(isloading: false);
      AppUtility.getPublishTime(newsFeedList).then((list) {
        newsFeeds = list;
        newsBloc!
            .getSourceImages(currentSelectedSubCategorySource!, context)
            .then((value) {
          currentSelectedSubCategorySourceLogo = value;
          updateLoadingStatus(isloading: false);
        });
      });
    });
    super.initState();
  }

  void updateLoadingStatus({bool? isloading}) {
    setState(() {
      isLoading = isloading!;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return ScreenTypeLayout(
        mobile: Container(
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
                    height: AppConfig.of(context).appWidth(1),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppConfig.of(context).appWidth(1)),
                    child: featuredRestaurantListWidget(context),
                  ),
                  MainPage(),
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
        desktop: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: AppConfig.of(context).appWidth(1),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppConfig.of(context).appWidth(1)),
                    child: featuredRestaurantListWidget(context),
                  ),
                  MainPage(),
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

  Widget featuredRestaurantListWidget(BuildContext context) {
    return Container(
      height: AppConfig.of(context).appWidth(50),
      child: ListView.separated(
        //  shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return CustomCategory(
              onPressed: () {
                FirebaseAnalyticsObservers.firebaseObserver.analytics.logEvent(
                    name:
                        "category_event${newsBloc!.categoriesList![index].category}");
                Navigator.of(context).pushNamed(RouteNames.MAINPAGE,
                    arguments: ScreenArguments(
                        currentPage: SubCategoryPage(
                            category: newsBloc!.categoriesList![index]),
                        message: AppLocalizations.of(context)!
                            .translate(AppString.CATEGORIES)));
              },
              title: newsBloc!.categoriesList![index].category,
              imageUrl: getImage(newsBloc!.categoriesList![index].category));
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: AppConfig.of(context).appWidth(0),
          );
        },
        itemCount: newsBloc!.categoriesList!.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget showHeadlines() {
    if (newsFeeds!.isNotEmpty) {
      return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
        var news = newsFeeds![index];
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: CustomNewsWidget(
                onPressed: () {
                  FirebaseAnalyticsObservers.firebaseObserver.analytics
                      .logEvent(
                          name: "news_event${news.title}");
                  Navigator.of(context).pushNamed(RouteNames.NEWS_DETAILS,
                      arguments: ScreenArguments(
                          data: news,
                          message: currentSelectedSubCategorySourceLogo));
                },
                newsFeed: news,
                logoUrl: currentSelectedSubCategorySourceLogo!,
              ),
            ),
          ),
        );
      }, childCount: newsFeeds!.length));
    } else {
      return SliverToBoxAdapter(child: CustomException());
    }
  }

  String getImage(String name) {
    if (name == AppLocalizations.of(context)!.translate(AppString.NEWS)) {
      return ImageAssetsResolver.NEWS_LOGO;
    } else if (name ==
        AppLocalizations.of(context)!.translate(AppString.SPORT)) {
      return ImageAssetsResolver.SPORTS_LOGO;
    } else if (name ==
        AppLocalizations.of(context)!.translate(AppString.BUSINESS)) {
      return ImageAssetsResolver.BUSINESS_LOGO;
    } else if (name ==
        AppLocalizations.of(context)!.translate(AppString.ENTERTAINMENT)) {
      return ImageAssetsResolver.ENTERTAINMENT_LOGO;
    } else if (name ==
        AppLocalizations.of(context)!.translate(AppString.LIFESTYLE)) {
      return ImageAssetsResolver.LIFESTYLE_LOGO;
    } else if (name == "اردو") {
      return ImageAssetsResolver.NEWS_LOGO;
    } else {
      return ImageAssetsResolver.TECH_LOGO;
    }
  }
}
