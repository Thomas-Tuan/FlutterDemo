import 'package:flutter/material.dart';

Widget itemMenuList(String imageUrl, String text, BuildContext context) {
  return Column(
    children: [
      Image.asset(
        imageUrl,
        width: 50,
        color: Theme.of(context).colorScheme.tertiary,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}

Widget itemQAList(String text, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      const Icon(Icons.keyboard_arrow_down_rounded),
    ],
  );
}
