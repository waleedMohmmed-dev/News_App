import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app_practice/core/styling/app_styles.dart';
import 'package:news_app_practice/core/widgets/spacing_widgets.dart';
import 'package:news_app_practice/data/models/top_headlines_model.dart';

class ArticalsScreen extends StatelessWidget {
  final String? title;
  final String? authorName;
  final String? date;
  final String? imageUrl;

  const ArticalsScreen({super.key, this.title, this.authorName, this.date, this.imageUrl});

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
                imageUrl:
                    imageUrl ??
                    'https://img.freepik.com/free-photo/blue-paper-texture-background_53876-93711.jpg?w=2000',
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
                        title ?? '',
                        maxLines: 4,
                        style: AppStyles.blacks14w700.copyWith(fontSize: 22),
                      ),
                      HeightSpace(6),
                      // Text(
                      //   '${articles.articles![0].author}'
                      //   '${DateFormat('yyyy-MM-dd').format(DateTime.parse(articles.articles![0].publishedAt!))}',
                      //   style: AppStyles.subtitlesStyles.copyWith(
                      //     fontSize: 12,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                      HeightSpace(25),
                      Text(
                        authorName ?? '',
                        style: AppStyles.subtitlesStyles.copyWith(
                          fontSize: 16,
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
       