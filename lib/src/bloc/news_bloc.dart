import 'package:flutter/material.dart';
import 'package:ufone_web/src/bloc/utility/app_utility.dart';
import 'package:ufone_web/src/model/Category.dart';
import 'package:ufone_web/src/model/NewsFeed.dart';
import 'package:ufone_web/src/model/SourList.dart';
import 'package:ufone_web/src/resource/repository/news_repository.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/String.dart';
import '../../app_localizations.dart';
import 'bloc_provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

class NewsBloc implements BlocBase {
  NewsBloc();

  final newsRepository = NewsRepository();

  List<Category>? categoriesList;
  List<NewsFeed>? newsFeedList;

  final categoryStreamController = BehaviorSubject<List<Category>>();

  Stream<List<Category>> get categoryStream => categoryStreamController.stream;

  final newsFeedStreamController = BehaviorSubject<List<NewsFeed>>();

  Stream<List<NewsFeed>> get newsFeedStream => newsFeedStreamController.stream;

  void getCategories(bool locale) async {
    await newsRepository.getNewsCategories(locale).then((model) {
      categoryStreamController.sink.add(model!);
    }, onError: (exception) {
      categoryStreamController.sink.addError(exception);
    });
  }

  void setFeedState(String resource) async {
    await newsRepository.fetchFeed(resource).then((newsFeed) {
      newsFeedStreamController.sink.add(newsFeed!);
    }, onError: (exception) {
      newsFeedStreamController.sink.addError(exception);
    });
  }

  Future<String> getSourceImages(String resource, BuildContext context) async {
    List<dynamic> responseData = await AppUtility.getRootBundle();
    List<SourList> sourceList =
        (responseData).map((i) => SourList.fromJson(i)).toList();

    final source =
        sourceList.singleWhere((element) => element.name == resource);

    return source.logo;
  }

  Future<Category> saveCategoriesImages(
      Category category, BuildContext context) async {
    if (category.category ==
        AppLocalizations.of(context)!.translate(AppString.NEWS)) {
      List<dynamic> responseData = await AppUtility.getRootBundle();
      List<SourList> sourceList =
          (responseData).map((i) => SourList.fromJson(i)).toList();
      category.item!.forEach((subcategory) async {
        final person = sourceList
            .singleWhere((element) => element.label == subcategory!.label);
        subcategory!.image = person.image;
      });
    } else if (category.category ==
        AppLocalizations.of(context)!.translate(AppString.SPORT)) {
      List<dynamic> responseData = await AppUtility.getRootBundle();
      List<SourList> sourceList =
          (responseData).map((i) => SourList.fromJson(i)).toList();

      category.item!.forEach((subcategory) async {
        final person = sourceList
            .singleWhere((element) => element.label == subcategory!.label);
        subcategory!.image = person.image;
      });
    } else if (category.category ==
        AppLocalizations.of(context)!.translate(AppString.BUSINESS)) {
      List<dynamic> responseData = await AppUtility.getRootBundle();
      List<SourList> sourceList =
          (responseData).map((i) => SourList.fromJson(i)).toList();

      category.item!.forEach((subcategory) async {
        final person = sourceList
            .singleWhere((element) => element.label == subcategory!.label);
        subcategory!.image = person.image;
      });
    } else if (category.category ==
        AppLocalizations.of(context)!.translate(AppString.ENTERTAINMENT)) {
      List<dynamic> responseData = await AppUtility.getRootBundle();
      List<SourList> sourceList =
          (responseData).map((i) => SourList.fromJson(i)).toList();

      category.item!.forEach((subcategory) async {
        final person = sourceList
            .singleWhere((element) => element.label == subcategory!.label);
        subcategory!.image = person.image;
      });
    } else if (category.category ==
        AppLocalizations.of(context)!.translate(AppString.LIFESTYLE)) {
      List<dynamic> responseData = await AppUtility.getRootBundle();
      List<SourList> sourceList =
          (responseData).map((i) => SourList.fromJson(i)).toList();

      category.item!.forEach((subcategory) async {
        final person = sourceList
            .singleWhere((element) => element.label == subcategory!.label);
        subcategory!.image = person.image;
      });
    } else if (category.category == "اردو") {
      List<dynamic> responseData = await AppUtility.getRootBundle();
      List<SourList> sourceList =
          (responseData).map((i) => SourList.fromJson(i)).toList();

      category.item!.forEach((subcategory) async {
        final person = sourceList
            .singleWhere((element) => element.label == subcategory!.label);
        subcategory!.image = person.image;
      });
    } else {
      List<dynamic> responseData = await AppUtility.getRootBundle();
      List<SourList> sourceList =
          (responseData).map((i) => SourList.fromJson(i)).toList();

      category.item!.forEach((subcategory) async {
        final person = sourceList
            .singleWhere((element) => element.label == subcategory!.label);
        subcategory!.image = person.image;
      });
    }
    return category;
  }

  void dispose() {
    categoryStreamController.close();
    newsFeedStreamController.close();
    // TODO: implement dispose
  }
}
