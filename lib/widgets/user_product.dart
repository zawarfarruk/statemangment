// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
class UserProductItem extends StatelessWidget {
  const UserProductItem({this.title,this.imageUrl});
final String? title;
final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title!),
      leading: CircleAvatar(backgroundImage:NetworkImage(imageUrl!) ),
      trailing: SizedBox(
        width: 100,
        child: Row(
        children: [
           IconButton(onPressed: null, icon:const Icon(Icons.edit),
           color: Theme.of(context).primaryColor,
           ),
           IconButton(onPressed: null, 
           color: Theme.of(context).errorColor,
           icon:const Icon(Icons.delete),
           
           )
        ],
      )
      ),
      
    );
  }
}