import 'package:flutter/material.dart';
import 'package:myapp/conf/const.dart';
import 'package:myapp/data/model/categorymodel.dart';

Widget itemCateHomePage(Category item, BuildContext context) {
  return InkWell(
    // onTap: () => Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => MyProductList(
    //         objCat: item,
    //       ),
    //     )),
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
            child: Image.asset(
              urlCategoryImg + item.img!,
              fit: BoxFit.cover,
              width: 50,
              height: 50,
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
