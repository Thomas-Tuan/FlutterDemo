import 'package:flutter/material.dart';
import 'package:myapp/component/my_app_bar.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/component/my_drawer.dart';
import 'package:myapp/conf/const.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    var myTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
    return Scaffold(
      appBar: MyAppBar(),
      drawer: const MyDrawer(),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      offset: const Offset(0, 4),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    '$urlNewsPageImg' 'image-16.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      "TIN MỚI NHẤT",
                      style: myTextStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          offset: const Offset(0, 4),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Image.asset(
                        '$urlNewsPageImg' 'image-17.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      "GỢI Ý TOP 10 MẪU ÁO NAM ĐỘC ĐÁO, HÓT HÒN HỌT",
                      style: myTextStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              offset: const Offset(0, 4),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          '$urlNewsPageImg' 'image-18.png',
                          fit: BoxFit.cover,
                          width: 200,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              offset: const Offset(0, 4),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          '$urlNewsPageImg' 'image-19.png',
                          fit: BoxFit.cover,
                          width: 200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
