
import 'package:ecomerce_using_state/provider/provider_products.dart';
import 'package:flutter/material.dart';
import '../widgets/products_item.dart';
import 'package:provider/provider.dart';

class GridViewClass extends StatelessWidget {
 // ignore: use_key_in_widget_constructors
 const GridViewClass(this.showFav);
  final bool showFav;
  @override
  Widget build(BuildContext context) {
    

  final productData=  Provider.of<ProviderPD>(context);
  final products=showFav?productData.favourite:productData.items;
    return GridView.builder(
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          childAspectRatio: 1.25,
          ), itemBuilder: (context,index)=>ChangeNotifierProvider.value(
            // create:(context)=>products[index],
            value: products[index],
            child:ProductsItem(
            // (products[index].id).toString(),
            // (products[index].title). toString(),
            // (products[index].imageUrl). toString()
            ), 
            ),
                  
           itemCount: products.length,);
  }
}