import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String iconSrc;
  final String title;
  final Color bgColor;

  const TitleWidget({
    Key? key,
    required this.iconSrc,
    required this.title,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, right: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconSrc.isNotEmpty)
            Image.asset(
              iconSrc,
              height: 24,
              fit: BoxFit.contain,
              color: bgColor,
            ),
          if (iconSrc.isNotEmpty) const SizedBox(width: 15),
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(),
          ),
        ],
      ),
    );
  }
}
