import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app_practice/core/futures/styling/app_styles.dart';
import 'package:news_app_practice/core/screens/home_screen/models/articles_model.dart';
import 'package:news_app_practice/core/widget/spacing_widgets.dart';

class ArticalsDetailsScreen extends StatelessWidget {
  final Articles articles;
  const ArticalsDetailsScreen({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            SizedBox(
              width: 430,
              height: 316,
              child: CachedNetworkImage(
                imageUrl: articles.urlToImage ?? '',
                fit: BoxFit.fill,
              ),
            ),

            Positioned(
              top: 250,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 2,
                        articles.title ?? '',
                        style: AppStyles.blacks14w700,
                      ),
                      HeightSpace(6),
                      Text(
                        '${articles.author}'
                        '${DateFormat('yyyy-MM-dd').format(DateTime.parse(articles.publishedAt ?? ''))}',
                        style: AppStyles.subtitlesStyles.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      HeightSpace(25),
                      Text(
                        articles.description ?? '',
                        style: AppStyles.subtitlesStyles.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//  Text(maxLines: 2, title, style: AppStyles.blacks14w700),
        // HeightSpace(1),
       