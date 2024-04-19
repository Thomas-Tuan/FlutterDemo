import 'package:flutter/material.dart';
import 'package:myapp/conf/common.dart';
import 'package:myapp/conf/const.dart';
import 'package:myapp/data/model/productmodel.dart';

Widget itemProductView(Product item, BuildContext context) {
  return Container(
    width: 100,
    height: 120,
    margin: const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    child: Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Image.asset(
                urlHomePageImg + item.img!,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image),
              ),
            ),
            Column(
              children: [
                Text(
                  Common.shortText(item.name!, 15),
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                Text(
                  Common.formatMoneyCurrency(item.price.toString()),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    ),
  );
}

Widget itemProductGridView(Product item, BuildContext context) {
  return Column(
    children: [
      Column(
        children: [
          Container(
            width: 170,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.tertiary,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  offset: const Offset(0, 4),
                  blurRadius: 5,
                ),
              ],
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Image.asset(
              urlHomePageImg + item.img!,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            Common.shortText(item.name!, 15),
            softWrap: false,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.inversePrimary),
          ),
        ],
      )
    ],
  );
}
