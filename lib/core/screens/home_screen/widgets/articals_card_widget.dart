import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_practice/core/futures/routing/app_routes.dart'
    show AppRoutes;
import 'package:news_app_practice/core/futures/styling/app_styles.dart';
import 'package:news_app_practice/core/screens/home_screen/models/articles_model.dart';
import 'package:news_app_practice/core/widget/spacing_widgets.dart';

class ArticalsCardWidget extends StatelessWidget {
  final Articles articles;

  const ArticalsCardWidget({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(
          context,
        ).pushNamed(AppRoutes.articalDetailsScreen, extra: articles);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpace(8),
                  Text(
                    articles.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.blacks14w700,
                  ),
                  const HeightSpace(8),
                  Text(
                    '${articles.author ?? ''} . ${articles.publishedAt ?? ''}',
                    style: AppStyles.subtitlesStyles.copyWith(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 112,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: CachedNetworkImage(
                  imageUrl: articles.urlToImage ?? '',
                  fit: BoxFit.fill,
                  height: 210,
                ),
              ),
            ),

            // // Image section (if available)
            // if (imageUrl != null && imageUrl!.isNotEmpty)
            //   ClipRRect(
            //     borderRadius: BorderRadius.circular(8),
            //     child: Image.network(
            //       imageUrl!,
            //       height: 80,
            //       width: 80,
            //       fit: BoxFit.cover,
            //       errorBuilder: (context, error, stackTrace) =>
            //           const Icon(Icons.image_not_supported, size: 40),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
