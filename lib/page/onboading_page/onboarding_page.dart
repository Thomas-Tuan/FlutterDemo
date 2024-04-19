import 'package:flutter/material.dart';
import 'package:myapp/auth/login_register.dart';
import 'package:myapp/component/my_background_gradient.dart';
import 'package:myapp/data/static/onboardingdata.dart';
import 'package:myapp/page/onboading_page/onboarding_body.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              children: [
                OnBoardingBodyWidget(
                  title: onBoarding[0].title,
                  subTitle: onBoarding[0].subTitle,
                  image: onBoarding[0].image,
                ),
                OnBoardingBodyWidget(
                  title: onBoarding[1].title,
                  subTitle: onBoarding[1].subTitle,
                  image: onBoarding[1].image,
                ),
                OnBoardingBodyWidget(
                  title: onBoarding[2].title,
                  subTitle: onBoarding[2].subTitle,
                  image: onBoarding[2].image,
                ),
              ],
            ),
            Positioned(
              left: 150,
              bottom: 50,
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: SwapEffect(
                  activeDotColor: Theme.of(context).colorScheme.tertiary,
                  dotColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Positioned(
              right: 30,
              top: 45,
              child: InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginOrRegister(),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Text(
                    "Bỏ qua",
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
