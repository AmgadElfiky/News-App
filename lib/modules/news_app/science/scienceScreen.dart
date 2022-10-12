import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/layouts/news_app/cubit/cubit.dart';
import 'package:news_app/layouts/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: camel_case_types
class scienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit, newsState>(
      builder: (context, state) {
        var list = newsCubit.get(context).science;
        return ArticleBuilder(list, context);
      },
      listener: (context, state) {},
    );
  }
}
