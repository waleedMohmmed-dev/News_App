import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_practice/core/routing/app_routes.dart';
import 'package:news_app_practice/core/widgets/custom_text_field.dart';

class SerchTextFialdWidget extends StatefulWidget {
  const SerchTextFialdWidget({super.key});

  @override
  State<SerchTextFialdWidget> createState() => _SerchTextFialdWidgetState();
}

class _SerchTextFialdWidgetState extends State<SerchTextFialdWidget> {
  bool isShowTextFormField = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isShowTextFormField
            ? CustomTextField(
                onFieldSubmitted: (value) {
                  GoRouter.of(context).pushNamed(AppRoutes.searchScreen, extra: value);
                },
                hintText: 'search'.tr(),
                width: 200,
              )
            : const SizedBox.shrink(),
        IconButton(
          onPressed: () {
            setState(() {
              isShowTextFormField = !isShowTextFormField;
            });
          },
          icon: const Icon(Icons.search, color: Colors.black),
        ),
      ],
    );
  }
}
