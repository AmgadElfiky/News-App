import 'package:flutter/material.dart';
import 'package:news_app/layouts/news_app/cubit/cubit.dart';
import 'package:news_app/layouts/news_app/cubit/states.dart';
import 'package:news_app/modules/news_app/news_searchBar/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/network/remote/DioHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: camel_case_types
class newsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => newsCubit()..getBusiness(),
      child: BlocConsumer<newsCubit, newsState>(
        // ignore: missing_return
        builder: (context, state) {
          var cubit = newsCubit.get(context);

          // ignore: unused_label
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context, searchScreen());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.brightness_4_outlined),
                  onPressed: () {
                    AppCubit.get(context).changeMode();
                  },
                )
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavIndex(index);
              },
              items: cubit.bottomItems,
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
