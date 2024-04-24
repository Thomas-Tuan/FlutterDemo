import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/conf/common.dart';
import 'package:myapp/data/model/productmodel.dart';
import 'package:myapp/page/product/detail/product_detail_widget.dart';

Widget itemProductView(Product item, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailWidget(
                    objPro: item,
                  )));
    },
    child: Container(
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
                child: Image.network(
                  item.img!,
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
    ),
  );
}

Widget itemProductGridView(Product item, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailWidget(
                    objPro: item,
                  )));
    },
    child: Column(
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
              child: Image.network(
                item.img!,
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
    ),
  );
}

Widget displayImage(BuildContext context, File? imageUrl, String? srcProImg) {
  return srcProImg!.isNotEmpty
      ? Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.primary,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.inversePrimary,
                offset: const Offset(0, 4),
                blurRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              srcProImg,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.broken_image,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    size: 50,
                  ),
                );
              },
            ),
          ))
      : Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.secondary,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.inversePrimary,
                offset: const Offset(0, 4),
                blurRadius: 5,
              ),
            ],
          ),
          child: imageUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.file(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          size: 50,
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: Icon(
                    Icons.camera_alt,
                    size: 50,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
        );
}
