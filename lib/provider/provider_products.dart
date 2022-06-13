import 'products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class ProviderPD with ChangeNotifier {
   List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  // var showFavouriteOnly=false;
  List<Product> get items {
    // if(showFavouriteOnly)
    // {
    //   return _items.where((prodid) => prodid.isfavorite).toList();
    // }
    return [..._items];
  }
  final String _token;

  ProviderPD(this._token,this._items);

  List<Product> get favourite {
    return _items.where((prodid) => prodid.isfavorite).toList();
  }

  // ignore: non_constant_identifier_names
  Product findBytilte(String Id) {
    // ignore: avoid_print
    return _items.firstWhere((product) => product.id == Id);
  }

  Future<void> fetchAndSetData() async {
    final url = Uri.parse(
        "https://flutterupdate-1131e-default-rtdb.firebaseio.com/products.json?auth=$_token");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedData = [];
      extractedData.forEach((prodId, prodData) {
        loadedData.add(Product(
            id: prodId,
            title: prodData["title"],
            price: prodData["price"],
            imageUrl: prodData["imageUrl"],
            description: prodData["description"]));
      });
      _items=loadedData;
      // print(json.decode(response.body));
      // // print(json.decode(response.body));
      // print(json.decode(response.body));
      notifyListeners();
      
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        "https://flutterupdate-1131e-default-rtdb.firebaseio.com/products.json");
    try {
      final response = await http.post(url,
          body: json.encode({
            "title": product.title,
            "price": product.price,
            "imageUrl": product.imageUrl,
            "isFavourite": product.isfavorite
          }));

      final newProduct = Product(
          id: json.decode(response.body)["name"],
          title: product.title,
          price: product.price,
          description: product.description,
          imageUrl: product.imageUrl);

      _items.add(newProduct);
      //  _items.add("");
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
