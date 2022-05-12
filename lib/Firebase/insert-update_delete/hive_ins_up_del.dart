import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Box<String>? cart;
  @override
  void initState() {
    cart = Hive.box<String>('addCart');
    super.initState();
  }

  final _name = TextEditingController();
  final _price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Column(
                  children: [
                    TextFormField(
                      controller: _name,
                      decoration: InputDecoration(hintText: 'Name'),
                    ),
                    TextFormField(
                      controller: _price,
                      decoration: InputDecoration(hintText: 'Price'),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      cart?.put('${Random().nextInt(1000)}',
                          _name.text + '\n' + 'Price : ${_price.text}');
                      Get.back();
                      _name.clear();
                      _price.clear();
                    },
                    icon: Text('OK'),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Text('Cancel'),
                  )
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: cart!.listenable(),
        builder: (context, Box<String> value, _) {
          return ListView.builder(
            itemCount: cart?.keys.length,
            itemBuilder: (context, int index) {
              var key = cart?.keys.toList()[index];
              var value1 = cart?.get(key);
              return ListTile(
                leading: Text(value1!),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Column(
                                  children: [
                                    TextFormField(
                                      controller: _name,
                                      decoration:
                                          InputDecoration(hintText: 'Name'),
                                    ),
                                    TextFormField(
                                      controller: _price,
                                      decoration:
                                          InputDecoration(hintText: 'Price'),
                                    ),
                                  ],
                                ),
                                actions: [
                                  IconButton(
                                    onPressed: () {
                                      cart?.put(
                                          key,
                                          _name.text +
                                              '\n' +
                                              'Price : ${_price.text}');
                                      Get.back();
                                    },
                                    icon: Text('OK'),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Text('Cancel'),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(Icons.edit)),
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Column(
                                  children: [
                                    Text('Do You Have Delete This Data ?')
                                  ],
                                ),
                                actions: [
                                  IconButton(
                                    onPressed: () {
                                      cart?.delete(key);
                                      Get.back();
                                    },
                                    icon: Text('yes'),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Text('No'),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(Icons.delete)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
