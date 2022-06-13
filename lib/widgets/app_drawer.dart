import 'package:ecomerce_using_state/Screens/order_screen.dart';
import 'package:ecomerce_using_state/Screens/products_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title:const Text("Hello Friends"),
            automaticallyImplyLeading: false,
          ),
         const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title:const Text("Shop"),
            onTap: (){
              Navigator.of(context).pushNamed("/");
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Orders"),
            onTap: () {
              Navigator.of(context).pushNamed(OrderScreen.routename);
            },
          ),
           const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Manage Products"),
            onTap: () {
              Navigator.of(context).pushNamed(UserProducts.routename);
            },
          ),

        ],
      ),
      
    );
  }
}