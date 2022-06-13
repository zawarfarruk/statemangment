import 'package:flutter/material.dart';
import '../provider/orders.dart' show OrderItem;
import  "package:intl/intl.dart";
class OrdersItem extends StatelessWidget {
 // ignore: use_key_in_widget_constructors
 const OrdersItem(this.item);
  final OrderItem item;

  @override
  Widget build(BuildContext context) {
    return  Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("\$${item.amount}"),
            subtitle: Text(
              DateFormat("dd/mm/yyyy/hh:mm").format(item.dateTime as DateTime)),
              trailing: IconButton(icon:const Icon(Icons.expand_more),onPressed: (){},),
          )
        ],
      ),
      );
      
    
  }
}