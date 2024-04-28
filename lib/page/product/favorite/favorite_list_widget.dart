import 'package:flutter/material.dart';
import 'package:myapp/data/provider/favoriteproductprovider.dart';
import 'package:myapp/page/product/favorite/favorite_list_body.dart';
import 'package:provider/provider.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Yêu thích",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: FavoriteProductList(favoriteProductProvider: favoriteProvider),
    );
  }
}
