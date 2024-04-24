import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/data/model/categorymodel.dart';
import 'package:myapp/page/categories/categorywidget.dart';

Widget itemCateHomePage(Category item, BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CategoryWidget(),
        )),
    child: Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Image.network(
              item.img!,
              fit: BoxFit.contain,
              width: 60,
              height: 60,
            ),
          ),
          Text(
            item.name!,
            style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary),
          ),
        ],
      ),
    ),
  );
}

Widget displayImage(BuildContext context, File? imageUrl, String? srcCateImg) {
  return srcCateImg!.isNotEmpty
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
              srcCateImg,
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
