import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app_practice/core/futures/styling/app_styles.dart';
import 'package:news_app_practice/core/widget/spacing_widgets.dart';

class TopHeadlinesItemWidget extends StatelessWidget {
  final String title;
  final String date;
  final String? imageUrl;
  final String autherName;

  const TopHeadlinesItemWidget({
    super.key,
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.autherName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: imageUrl ?? '',
              height: 210,
              fit: BoxFit.fill,
            ),
          ),
        ),
        HeightSpace(16),
        Text(maxLines: 2, title, style: AppStyles.blacks14w700),
        HeightSpace(1),
        Text(
          '$autherName.$date',
          style: AppStyles.subtitlesStyles.copyWith(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
