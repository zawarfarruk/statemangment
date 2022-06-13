import 'package:ecomerce_using_state/widgets/app_drawer.dart';
import '/Screens/cart_screen.dart';
import 'package:ecomerce_using_state/provider/cart.dart';
import 'package:ecomerce_using_state/widgets/badge.dart';
import 'package:ecomerce_using_state/widgets/grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider_products.dart';

enum Filters {
  // ignore: constant_identifier_names
  Favourite,
  // ignore: constant_identifier_names
  All,
}

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  var _inIt = true;
  var _isLoading = false;
  @override
  void initState() {
    // Provider.of<ProviderPD>(context).fetchData(); Wont not work
    // Future.delayed(Duration.zero).then((_){
    //   Provider.of<ProviderPD>(context).fetchAndSetData();
    //   });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_inIt) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProviderPD>(context).fetchAndSetData().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _inIt = false;
    super.didChangeDependencies();
  }
    Future<void> refreshIn() async{
await Provider.of<ProviderPD>(context).fetchAndSetData();
    }
  var _showOnlyFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyShop"),
        actions: [
          PopupMenuButton(
              onSelected: (Filters selectedValue) {
                setState(() {
                  if (selectedValue == Filters.Favourite) {
                    _showOnlyFav = true;
                  } else {
                    _showOnlyFav = false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: ((context) => [
                    const PopupMenuItem(
                      child: Text("Only Favorites"),
                      value: Filters.Favourite,
                    ),
                    const PopupMenuItem(
                      child: Text("Show All"),
                      value: Filters.All,
                    ),
                  ])),
          Consumer<Cart>(
            builder: (context, cart, ch) => Badge(
              child: ch!,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routename);
              },
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: ()=>refreshIn(),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.amber),
              )
            : GridViewClass(_showOnlyFav),
      ),
    );
  }
}
