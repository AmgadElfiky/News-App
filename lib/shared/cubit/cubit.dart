import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitailState());

  static AppCubit get(context) => BlocProvider.of(context);
  //Dark Mode
  bool isDark = false;

  void changeMode({bool ModeFromShared}) {
    if (ModeFromShared != null) {
      isDark = ModeFromShared;
      emit(ChangeModeState());
    } else {
      isDark = !isDark;
      cacheHelper.putData(key: 'isDark', value: isDark).then(
            (value) => emit(ChangeModeState()),
          );
    }
  }
}
