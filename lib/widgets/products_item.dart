// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:ecomerce_using_state/provider/cart.dart';
import 'package:ecomerce_using_state/provider/products.dart';

import '../Screens/products_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsItem extends StatelessWidget {
  // const ProductsItem(this.id, this.title, this.imageUrl);
  // final String id;
  // final String title;
  // final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetails.routeName, arguments: item.id);
        },
        child: GridTile(
          child: Image.network(
            item.imageUrl.toString(),
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              item.title.toString(),
              textAlign: TextAlign.center,
            ),
            leading: Consumer<Product>(
              builder: (context, value, child) => IconButton(
                icon: Icon(
                  item.isfavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () {
                  item.tooggleFavouriteStatus();
                },
                color: Colors.amber,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(item.id.toString(), item.price as double,
                    item.title.toString());
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Added Item to Cart"),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                        label: "Undo",
                        onPressed: () {
                          cart.removeSingle(item.id);
                        }),
                  ),
                );
              },
              color: Colors.amber,
            ),
          ),
        ),
      ),
    );
  }
}
