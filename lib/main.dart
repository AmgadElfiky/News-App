import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layouts/news_app/cubit/cubit.dart';
import 'package:news_app/layouts/news_app/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/DioHelper.dart';

void main() async {
  //used when we write async after main
  WidgetsFlutterBinding.ensureInitialized();

  // ignore: deprecated_member_use
  BlocOverrides.runZoned(
    () async {
      DioHelper.init();
      await cacheHelper.init();
      bool isDark = cacheHelper.getData(key: 'isDark');
      runApp(MyApp(isDark));
    },
    blocObserver: MyBlocObserver(),
  );
}

// ignore: camel_case_types
class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
//create: (BuildContext context) => newsCubit()..getBusiness(),
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //news_app
        BlocProvider(
          create: (BuildContext context) => newsCubit()..getBusiness(),
        ),
        //theme
        BlocProvider(
          create: (context) => AppCubit()
            ..changeMode(
              ModeFromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.teal,
              scaffoldBackgroundColor: Colors.white,
              primaryColor: Colors.teal,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                backgroundColor: Colors.white,
                elevation: 0.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(color: Colors.grey[600]),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.teal,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.teal,
                elevation: 10.0,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('#181818'),
              primarySwatch: Colors.teal,
              primaryColor: Colors.teal,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                backgroundColor: HexColor('#181818'),
                elevation: 10.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('#181818'),
                  statusBarIconBrightness: Brightness.light,
                ),
                titleTextStyle: TextStyle(
                    color: Colors.teal,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
                iconTheme: IconThemeData(color: Colors.tealAccent),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.teal,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.teal,
                elevation: 10.0,
                backgroundColor: HexColor('#181818'),
                unselectedItemColor: Colors.white,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: newsLayout(),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}