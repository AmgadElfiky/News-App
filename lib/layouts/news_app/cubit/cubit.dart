import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/layouts/news_app/cubit/states.dart';
import 'package:news_app/modules/news_app/buisness/buisnessScreen.dart';
import 'package:news_app/modules/news_app/science/scienceScreen.dart';
import 'package:news_app/modules/news_app/sports/sportsScreen.dart';
import 'package:news_app/shared/network/remote/DioHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: camel_case_types
class newsCubit extends Cubit<newsState> {
  //newsCubit() : super(newsCubitInitialState());
  newsCubit() : super(newsInitailState());

  static newsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business_center,
      ),
      label: 'Buisness',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    buisnessScreen(),
    sportsScreen(),
    scienceScreen(),
  ];

  void changeBottomNavIndex(index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getscience();
    emit(newsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(newsLoadingState());
    if (business.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': '7df12094aee14bbf936ef08a7aec4e99',
        },
      ).then((value) {
        business = value.data['articles'];
        print(business[0]['title']);
        emit(newsGetBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(newsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(newsGetBusinessSuccessState());
    }
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(newsSprotsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '7df12094aee14bbf936ef08a7aec4e99',
        },
      ).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(newsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(newsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(newsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getscience() {
    emit(newsSprotsLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '7df12094aee14bbf936ef08a7aec4e99',
        },
      ).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(newsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(newsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(newsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(newsSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '7df12094aee14bbf936ef08a7aec4e99',
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(newsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(newsGetSearchErrorState(error.toString()));
    });
    emit(newsGetSearchSuccessState());
  }
}
