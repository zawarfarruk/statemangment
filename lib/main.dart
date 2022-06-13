// import '/Screens/edit_screen.dart';
// import 'package:ecomerce_using_state/provider/products.dart';

import '../provider/auth.dart';

import '/Screens/edit_products_screen.dart';
import 'Screens/auth_screen.dart';
import '/Screens/products_screen.dart';
import './Screens/order_screen.dart';
import '../Screens/cart_screen.dart';
import '../Screens/products_details.dart';
import 'Screens/products_overveiw_screen.dart';
import '../provider/cart.dart';
import '../provider/orders.dart';
import 'package:flutter/material.dart';
import 'provider/provider_products.dart';
import 'package:provider/provider.dart';
void main(List<String> args) {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(
      value: Auth(),
      ),
       ChangeNotifierProvider(
         create: (context)=>Orders(),
         ),
      ChangeNotifierProxyProvider<Auth,ProviderPD>(
       create:(ctx)=> ProviderPD("",[]),
      // ignore: unnecessary_null_comparison
      update:(context, auth, previousprod) =>  
      ProviderPD(auth.token.toString(),
      previousprod!.items==null?[]:previousprod.items),
      ),
     ChangeNotifierProvider(
       create: (context) => Cart(),
       ),
      
    ],
      child: Consumer<Auth>(
       builder: (ctx,auth ,_)=>
        MaterialApp(
        theme: ThemeData(
          fontFamily: 'Lato', 
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.purple).copyWith(
              secondary: Colors.deepOrange)
        ),
        home:auth.isAuth?const ProductsView():const AuthScreen(),
        //  const ProductsView(),
        routes: {
          ProductDetails.routeName:(context) =>  const ProductDetails(),
          CartScreen.routename:(context) =>  const CartScreen(),
          OrderScreen.routename:(context) => const OrderScreen(),
          UserProducts.routename:(context) =>const UserProducts(),
          EditProducts.routename:(context) => const EditProducts(),
          
        },
      
      ),
       )
     
    );
  }
}

