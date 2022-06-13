import '../widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/orders.dart' show Orders;
import '../widgets/order_item.dart';
class OrderScreen extends StatelessWidget {
  const OrderScreen({ Key? key }) : super(key: key);
static const routename="/order";
  @override
  Widget build(BuildContext context) {
   final orderData= Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title:const Text("Your Orders"),
      ),
      drawer:const AppDrawer(),
      body: ListView.builder(
        itemCount:orderData.orders.length,
        itemBuilder:(context,i)=>OrdersItem(orderData.orders[i])
         ),
      
    );
  }
}