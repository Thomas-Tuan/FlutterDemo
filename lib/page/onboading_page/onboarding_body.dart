import 'package:flutter/material.dart';

class OnBoardingBodyWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  const OnBoardingBodyWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 200,
        ),
        const SizedBox(
          height: 15,
        ),
        Divider(
            indent: 50,
            endIndent: 50,
            color: Theme.of(context).colorScheme.tertiary),
        const SizedBox(
          height: 15,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary),
          ),
        ),
      ],
    );
  }
}
