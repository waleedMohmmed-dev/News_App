import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_practice/core/routing/app_routes.dart';
import 'package:news_app_practice/core/styles/app_text_styles.dart';
import 'package:news_app_practice/core/widgets/spacing_widgets.dart';
import 'package:news_app_practice/features/home_screen/models/top_headlines_model.dart';
import 'package:news_app_practice/features/screens/articals_details/articals_details_screen.dart';

class ArticleCardWidget extends StatelessWidget {
  final String title;
  final String authorName;
  final String? date;
  final String? imageUrl;

  const ArticleCardWidget({
    super.key,

    required this.title,
    required this.authorName,
    this.date,
    this.imageUrl,
  });

  bool _isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    return url.startsWith('http');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // hecx
        GoRouter.of(context).push(
          AppRoutes.articleDetailsScreen,
          extra: ArticalsScreen(
            title: title,
            authorName: authorName,
            date: date,
            imageUrl: imageUrl,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 238.w,
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.titlesStyles.copyWith(
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
                const HeightSpace(8),
                SizedBox(
                  width: 238.w,
                  child: Text("$authorName · $date", style: AppTextStyles.grey14Regular),
                ),
              ],
            ),
            SizedBox(
              width: 112.w,
              height: 80.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl: imageUrl ?? '',
                  // imageUrl: _isValidImageUrl(articalModel.articles![0].urlToImage)
                  //     ? articalModel.articles![0].urlToImage!
                  //     : '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey.shade200,
                    child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey),
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
