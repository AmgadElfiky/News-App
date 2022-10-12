import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/news_app/web_view/webViewScreen.dart';

//Buttons
Widget defaultButton({
  @required String text,
  @required Function function,
  double width = double.infinity,
  double heigth = 50.0,
  double radius = 10.0,
  Color background = Colors.teal,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      height: heigth,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
    );

Widget defaultLoginForm({
  @required TextEditingController controller,
  @required TextInputType type,
  @required Function validate,
  @required String text,
  @required IconData prefix,
  IconData suffix,
  bool isPassword = false,
  Function onSubmit,
  Function onChange,
  Function onTap,
  Function suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2.0)),
      ),
    );


Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
      child: Container(
        width: double.infinity,
        height: 2.0,
        color: Colors.grey[300],
      ),
    );

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, webViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 150.0,
              height: 150.0,
              child: CachedNetworkImage(
                imageUrl: article['urlToImage'] == null
                    ? 'https://bitsofco.de/content/images/2018/12/broken-1.png'
                    : '${article['urlToImage']}',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),

              // decoration: BoxDecoration(

              //   borderRadius: BorderRadius.circular(10.0),

              //   image: DecorationImage(

              //     image: article['urlToImage'] == null ? 'https://www.pnc.com/content/dam/pnc-com/images/personal/OnlineBanking/inset_photos/inset_olb-mob-tools.jpg' : NetworkImage('${article['urlToImage']}'),

              //     // 'https://www.pnc.com/content/dam/pnc-com/images/personal/OnlineBanking/inset_photos/inset_olb-mob-tools.jpg'

              //     fit: BoxFit.cover,

              //   ),

              // ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Container(
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

// ignore: non_constant_identifier_names
Widget ArticleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length,
      ),
      fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
