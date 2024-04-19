import 'package:flutter/material.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/conf/const.dart';
import 'package:myapp/page/users/userinfobody.dart';

class MyAccountWidget extends StatelessWidget {
  const MyAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin cá nhân"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Xin chào',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Đơn hàng',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Lịch sử mua hàng',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.keyboard_arrow_down_rounded),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: itemMenuList(
                            '$urlUserPageImg' 'shopping-bag.png',
                            'Đang giao dịch',
                            context)),
                    Flexible(
                      child: itemMenuList('$urlUserPageImg' 'basket.png',
                          'Chờ lấy hàng', context),
                    ),
                    itemMenuList(
                      '$urlUserPageImg' 'in-transit.png',
                      'Đang giao ',
                      context,
                    ),
                    itemMenuList(
                      '$urlUserPageImg' 'shipped.png',
                      'Đã giao',
                      context,
                    ),
                  ],
                ),
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Image.asset(
                    '$urlUserPageImg' 'banner.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                itemQAList('Hướng dẫn chọn size', context),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                itemQAList('Chính sách khách hàng thân thiết', context),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                itemQAList('Chính sách bảo mật thông tin khách hàng', context),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                itemQAList('Chính sách đổi/trả', context),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                itemQAList('Chính sách giao vận chuyển online', context),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                itemQAList('Chính sách thanh toán', context),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                itemQAList('Giới thiệu', context),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                itemQAList('Liên hệ', context),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                itemQAList('Góp ý, phản hồi', context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
