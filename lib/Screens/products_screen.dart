// import '../Screens/edit_screen.dart';
import '/Screens/edit_products_screen.dart';
import '../provider/provider_products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class UserProducts extends StatelessWidget {
  const UserProducts({Key? key}) : super(key: key);
static const routename="/prodcuts";
  @override
  Widget build(BuildContext context) {
    final pro=Provider.of<ProviderPD>(context);
        return Scaffold(
      appBar: AppBar(
        title:const Text("Yours Products"),
        actions:  [
           IconButton(icon:const Icon(Icons.add),
        onPressed: (){
            Navigator.of(context).pushNamed(EditProducts.routename);
        },),
        ]
        
      ),
      drawer:const AppDrawer(),
      body: ListView.builder(itemCount:pro.items.length,
        itemBuilder: (context,i)=>Column(children: [UserProductItem(
          imageUrl: pro.items[i].imageUrl,
          title: pro.items[i].title,),const Divider()
          ],) 
        )
        );
    
  }
}