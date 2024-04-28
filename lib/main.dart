import 'package:flutter/material.dart';
import 'package:myapp/data/provider/cartprovider.dart';
import 'package:myapp/data/provider/categoryprovider.dart';
import 'package:myapp/data/provider/favoriteproductprovider.dart';
import 'package:myapp/data/provider/productprovider.dart';
import 'package:myapp/page/onboading_page/onboarding_page.dart';
import 'package:myapp/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProductProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).themeData,
        home: const OnBoardingPage(),
      ),
    );
  }
}
