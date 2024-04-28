import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myapp/conf/const.dart';

class ProductDetailCarouselSlider extends StatefulWidget {
  const ProductDetailCarouselSlider({
    super.key,
  });

  @override
  State<ProductDetailCarouselSlider> createState() =>
      _ProductDetailCarouselSliderState();
}

class _ProductDetailCarouselSliderState
    extends State<ProductDetailCarouselSlider> {
  late CarouselController carouselController;
  int innerCurrentPage = 0;
  List<String> lstImg = [
    '$urlProductImg' 'image 85.png',
    '$urlProductImg' 'image 86.png',
    '$urlProductImg' 'image 87.png',
    '$urlProductImg' 'image 88.png',
  ];

  @override
  void initState() {
    carouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    offset: const Offset(3, 4),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: CarouselSlider(
                carouselController: carouselController,
                items: lstImg.map((item) {
                  return Builder(builder: (BuildContext context) {
                    return SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        item,
                        fit: BoxFit.contain,
                      ),
                    );
                  });
                }).toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      innerCurrentPage = index;
                    });
                  },
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 100,
              child: CircleAvatar(
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .inversePrimary
                    .withOpacity(0.2),
                child: IconButton(
                  onPressed: () {
                    carouselController.animateToPage(innerCurrentPage - 1);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 100,
              child: CircleAvatar(
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .inversePrimary
                    .withOpacity(0.2),
                child: IconButton(
                  onPressed: () {
                    carouselController.animateToPage(innerCurrentPage + 1);
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(lstImg.length, (index) {
            bool isSelected = innerCurrentPage == index;
            return GestureDetector(
              onTap: () {
                carouselController.animateToPage(index);
              },
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.tertiary
                      : Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(200),
                ),
                duration: const Duration(
                  milliseconds: 300,
                ),
                curve: Curves.ease,
                width: isSelected ? 40 : 30,
                margin: EdgeInsets.symmetric(
                  horizontal: isSelected ? 6 : 3,
                ),
                height: 10,
              ),
            );
          }),
        ),
      ],
    );
  }
}
