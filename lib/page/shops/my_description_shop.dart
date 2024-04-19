import 'package:flutter/material.dart';
import 'package:myapp/conf/common.dart';

class MyShopDes extends StatelessWidget {
  const MyShopDes({super.key});

  @override
  Widget build(BuildContext context) {
    var myPrimaryTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
      fontSize: 18,
    );
    var mySecondaryTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 10,
      ),
      child: Column(
        children: [
          Text(
            'Gibi Sư Vạn Hạnh, HCM',
            style: myPrimaryTextStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Địa chỉ',
                style: myPrimaryTextStyle,
              ),
              Text(
                '828 Sư Vạn Hạnh',
                style: mySecondaryTextStyle,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Điện thoại',
                style: myPrimaryTextStyle,
              ),
              Text(
                Common.formatPhoneNumber('0387011360'),
                style: mySecondaryTextStyle,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Giờ làm việc',
                style: myPrimaryTextStyle,
              ),
              Text(
                '08:00 - 22:00',
                style: mySecondaryTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
