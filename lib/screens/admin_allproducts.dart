// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food/inner_screens/cartitems.dart';
import 'package:food/inner_screens/favourite.dart';

class AdminProducts extends StatefulWidget {
  const AdminProducts({super.key});

  @override
  State<AdminProducts> createState() => _AdminProductsState();
}

class _AdminProductsState extends State<AdminProducts> {
  final _foodstream =
      FirebaseFirestore.instance.collection('foods').snapshots();
  //for getting only integer inputs for qty
  final _quantityTextController = TextEditingController();
  cartitems cartItems = cartitems();
  favourite favouriteItems = favourite();
  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text("Manage Products"),
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder(
        stream: _foodstream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading');
          }
          var docs = snapshot.data!.docs;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 300 / 360),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  docs[index].data() as Map<String, dynamic>;

              String imgUrl =
                  data.containsKey('imageurl') ? data['imageurl'] : '';
              String title =
                  data.containsKey('foodname') ? data['foodname'] : '';

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).cardColor,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Column(children: [
                      Image.network(
                        imgUrl,
                        height: 80,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: TextStyle(fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: () async {
                                // Get the document ID of the current product
                                String docId = docs[index].id;

                                try {
                                  // Delete the product from Firestore
                                  await FirebaseFirestore.instance
                                      .collection('foods')
                                      .doc(docId)
                                      .delete();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Product deleted successfully'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                } catch (e) {
                                  print('Error deleting product: $e');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Failed to delete product'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              child: Icon(
                                IconlyBold.delete,
                                size: 22,
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
