import 'package:ecomerce_using_state/provider/provider_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductDetails extends StatelessWidget {
  const ProductDetails({ Key? key }) : super(key: key);
static const routeName="/Products-Details";
  @override
  Widget build(BuildContext context) {
   final  productId =
    ModalRoute.of(context)!.settings.arguments as String;
  final  loaded= Provider.of<ProviderPD>(
    context,listen: false,
    ).findBytilte(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loaded.title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             ClipRRect(
               borderRadius: BorderRadius.circular(8),
               child: SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(loaded.imageUrl!,fit: BoxFit.cover,),
                         ),
             ),
            const SizedBox(height: 10,),
            Text("\$${loaded.price}",style:const  TextStyle(color: Colors.grey),),
           const  SizedBox(height: 10),
            Text("${loaded.description}"),
            
          ],
        ),
      ),
      
    );
  }
}