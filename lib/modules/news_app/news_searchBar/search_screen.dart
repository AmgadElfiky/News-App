import 'package:flutter/material.dart';
import 'package:news_app/layouts/news_app/cubit/cubit.dart';
import 'package:news_app/layouts/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: camel_case_types
class searchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit, newsState>(
      builder: (context, state) {
        var list = newsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(
            title: Text('Search Screen'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultLoginForm(
                  controller: searchController,
                  prefix: Icons.search,
                  text: 'Search',
                  type: TextInputType.text,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Search Must Not Be Empty';
                    }
                    return null;
                  },
                  onChange: (String value) {
                    newsCubit.get(context).getSearch(value);
                  },
                ),
                Expanded(child: ArticleBuilder(list, context, isSearch: true))
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
