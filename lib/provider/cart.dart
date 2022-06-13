import 'package:flutter/cupertino.dart';

class CartItem {
  final String? id;
  final String? title;
  final int? quantity;
  final double? price;
  CartItem({this.id, this.price, this.quantity, this.title});
}

class Cart with ChangeNotifier {
   Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += (cartItem.price! * cartItem.quantity!);
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (exixtingCartitem) => CartItem(
                id: exixtingCartitem.id,
                price: exixtingCartitem.price,
                quantity: exixtingCartitem.quantity! + 1,
                title: exixtingCartitem.title,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String? productId) {
    _items.remove(productId!);
    notifyListeners();
  }
  void removeSingle(String? productId){
    if(!_items.containsKey(productId)){
      return;
    }
    if(_items[productId]!.quantity!=null && _items[productId]!.quantity!>1){
      _items.update(productId!, (existing) => CartItem(
        id: existing.id,
        price: existing.price,
       quantity: existing.quantity!-1
         ),);
    }else{
       _items.remove(productId);
    }
    notifyListeners();

  }
  void clear(){
    _items ={};
  notifyListeners();
  }
}
