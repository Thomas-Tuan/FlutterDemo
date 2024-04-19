import 'package:flutter/material.dart';
import 'package:myapp/conf/const.dart';

class MyInfoShop extends StatelessWidget {
  const MyInfoShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 25,
            right: 25,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: itemShopInfoView("120+", "Cửa hàng",
                          '$urlShopPageImg' 'banner-2.png', context),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: itemShopInfoView("2", "Nhà máy",
                          '$urlShopPageImg' 'banner-3.png', context),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: itemShopInfoView("48", "Tỉnh thành",
                          '$urlShopPageImg' 'banner-5.png', context),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: itemShopInfoView("4000", "Nhân sự",
                          '$urlShopPageImg' 'banner-4.png', context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget itemShopInfoView(
  String text1,
  String text2,
  String imageUrl,
  BuildContext context,
) {
  var myTextStyle = TextStyle(
    color: Theme.of(context).colorScheme.inversePrimary,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text1, style: myTextStyle),
            Text(text2, style: myTextStyle),
          ],
        ),
        const SizedBox(
          width: 5,
        ),
        Image.asset(
          imageUrl,
          fit: BoxFit.cover,
          width: 50,
          height: 80,
        ),
      ],
    ),
  );
}
