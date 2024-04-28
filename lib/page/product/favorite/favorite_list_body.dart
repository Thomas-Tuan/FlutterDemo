import 'package:flutter/material.dart';
import 'package:myapp/conf/common.dart';
import 'package:myapp/data/provider/favoriteproductprovider.dart';

class FavoriteProductList extends StatelessWidget {
  final FavoriteProductProvider favoriteProductProvider;
  const FavoriteProductList({
    Key? key,
    required this.favoriteProductProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return favoriteProductProvider.product.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Chưa có danh sách sản phẩm yêu thích !',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: favoriteProductProvider.product.length,
            itemBuilder: (context, index) {
              final product = favoriteProductProvider.product[index];
              final isFavorite = favoriteProductProvider.isFavorite(product);

              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                child: ListTile(
                  leading: Image.network(product.img!),
                  title: Text(
                    product.name!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    Common.formatMoneyCurrency(product.price.toString()),
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border),
                    color: isFavorite
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      favoriteProductProvider.toggleFavorite(product);
                    },
                  ),
                ),
              );
            },
          );
  }
}
