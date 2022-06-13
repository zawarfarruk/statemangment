import 'package:ecomerce_using_state/provider/provider_products.dart';
import 'package:flutter/material.dart';
import '../provider/products.dart';
import 'package:provider/provider.dart';

class EditProducts extends StatefulWidget {
  const EditProducts({Key? key}) : super(key: key);
  static const routename = "/edit-screen";
  @override
  State<EditProducts> createState() => _EditProductsState();
}

final _priceFocusNode = FocusNode();
final _descriptionFocusNode = FocusNode();
final _imageUrlFocusNode = FocusNode();
final _imageController = TextEditingController();
var _isLoading = false;
final _formkey = GlobalKey<FormState>();
var _editProducts =
    Product(id: null, title: " ", price: 0, imageUrl: " ", description: " ");

class _EditProductsState extends State<EditProducts> {
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateUrl);
    // _priceFocusNode.dispose();
    // _descriptionFocusNode.dispose();
    // _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateUrl() {
    if (_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveform() async {
    final isValidate = _formkey.currentState?.validate();
    if (!isValidate!) {
      return;
    }
    _formkey.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<ProviderPD>(context, listen: false)
          .addProduct(_editProducts);
    } catch (error) {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Error Occured!"),
                content: const Text("SOmething went wrong!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ok"),
                  )
                ],
              ));
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }

    // print(_editProducts.id);
    // print(_editProducts.title);
    // print(_editProducts.price);
    // print(_editProducts.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yours Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveform,
          )
        ],
      ),
      body: Form(
        key: _formkey,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.amber,
              ))
            : Padding(
                padding: const EdgeInsets.all(18),
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(label: Text("title")),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the title";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editProducts = Product(
                            id: _editProducts.id,
                            title: value!,
                            price: _editProducts.price,
                            imageUrl: _editProducts.imageUrl,
                            description: _editProducts.description);
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(label: Text("Price")),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) {
                        _editProducts = Product(
                            id: _editProducts.id,
                            description: _editProducts.description,
                            title: _editProducts.title,
                            price: double.parse(value!),
                            imageUrl: _editProducts.imageUrl);
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(label: Text("Description")),
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.name,
                      maxLines: 3,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                      },
                      onSaved: (value) {
                        _editProducts = Product(
                            id: _editProducts.id,
                            description: value!,
                            title: _editProducts.title,
                            price: _editProducts.price,
                            imageUrl: _editProducts.imageUrl);
                      },
                    ),
                    // Image.network(
                    //   'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
                    // ),

                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: _imageController.text.isEmpty
                                ? const Text("Enter Url")
                                : FittedBox(
                                    child: Image(
                                      image: NetworkImage(
                                        _imageController.text,
                                      ),
                                    ),
                                  )),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration:
                                const InputDecoration(label: Text("Enter Url")),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.url,
                            controller: _imageController,
                            onEditingComplete: () {
                              setState(() {});
                            },
                            onSaved: (value) {
                              _editProducts = Product(
                                  id: _editProducts.id,
                                  description: _editProducts.description,
                                  title: _editProducts.title,
                                  price: _editProducts.price,
                                  imageUrl: value!);
                            },
                            // focusNode: _imageUrlFocusNode,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
