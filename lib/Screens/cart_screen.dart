import 'package:ecomerce_using_state/provider/orders.dart';
import 'package:ecomerce_using_state/widgets/cart_item.dart';

import '/provider/cart.dart' show Cart;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routename = "/cart";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Chip(
                      label: Text(
                        "\$${cart.totalAmount}",
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<Orders>(context,listen: false).addOrder(
                            cart.items.values.toList(), 
                            cart.totalAmount
                            );
                        cart.clear();
                      },
                      child: const Text("Order Now"),
                    )
                  ]),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (ctx, i) => CartEntry(
                cart.items.values.toList()[i].id!,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].title!,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].price!),
          ))
        ],
      ),
    );
  }
}
