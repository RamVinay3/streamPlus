import 'package:flutter/material.dart';
import 'package:upload_movie/color.dart';

class Category extends StatelessWidget {
  const Category(
      {super.key,
      required this.belongs,
      required this.cat,
      required this.onTap});
  final bool belongs;
  final String cat;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        margin: const EdgeInsets.only(right: 5, bottom: 10),
        decoration: BoxDecoration(
            border: Border.all(color: appColors.category, width: 1),
            color: (belongs) ? appColors.category : Colors.white,
            borderRadius: BorderRadius.circular(12)),
        child: Text(
          cat,
          style: TextStyle(
              fontSize: 18,
              fontWeight: (belongs) ? FontWeight.w600 : FontWeight.w400),
        ),
      ),
    );
  }
}
