import 'package:ecomerce_using_state/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartEntry extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CartEntry(this.id,this.productId,this.title, this.qunatity, this.price);
  final String id;
  final String productId;
  final String? title;
  final int? qunatity;
  final double? price;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Container(
          color: Theme.of(context).errorColor,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 35,
          ),
          margin:const EdgeInsets.only(right: 20),
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
        return showDialog(context: context, builder:(context)=> AlertDialog(
          title:const Text("Are You Sure"),
          content:const Text("Do you want to remove the item from cart"),
          actions: [
            TextButton(onPressed:(){
              Navigator.of(context).pop(false);
            } ,
            child:const Text("No")
            ),
            TextButton(onPressed: (){
              Navigator.of(context).pop(true);
            }, child:const Text("Yes"))

        ],
        ),
        );
      },
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(productId);

      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: FittedBox(child: Text("\$$price")),
                ),
              ),
              title: Text(title!),
              // ignore: unnecessary_null_comparison
              subtitle: Text("Total${price! * qunatity!}"),
              trailing: Text("$qunatity"),
            )),
      ),
    );
  }
}
