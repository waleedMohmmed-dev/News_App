import 'package:flutter/material.dart';

class CostomCategotyItemWidget extends StatelessWidget {
  final String title;
  final Function() onTap;
  const CostomCategotyItemWidget({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            overlayColor: Colors.blue,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            side: const BorderSide(color: Color(0xffE9EEFA), width: 2),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(55),
            ),
          ),

          child: Text(title),
        ),
      ),
    );
  }
}
