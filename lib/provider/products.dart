import "package:flutter/material.dart";
class Product with ChangeNotifier{
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  bool isfavorite;
   Product({
   @required this.id,
   @required this.title,
   @required this.price,
   @required this.imageUrl,
   @required this.description,
   this.isfavorite=false 
   });
   
   void tooggleFavouriteStatus(){
     isfavorite =! isfavorite;
     notifyListeners();
   }
}