//import 'dart:js_util';
import 'package:flutter/material.dart';

import 'package:food/inner_screens/cartitems.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

cartitems burgercart = cartitems();

List<String> title = burgercart.titlelist();
List<int> price = burgercart.pricelist();
List<String> image = burgercart.imglist();

int total() {
  int x = price.length;
  int totalprice = 0;
  for (int i = 0; i < x; i++) {
    totalprice = totalprice + price[i];
  }
  return totalprice;
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Center(child: Text("cart")),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: Row(
        children: [
          Text(
            "Total Amount",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text('Rs.${total().toString()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
      body: Center(
        child: ListView.builder(
            itemCount: title.length,
            itemBuilder: (context, index) {
              return Container(
                color: Color.fromARGB(255, 244, 244, 244),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            title[index],
                            style: TextStyle(
                                color: Color.fromARGB(255, 1, 27, 7),
                                fontSize: 20),
                          ),
                          Image.network(
                            image[index],
                            width: 80,
                            height: 80,
                          ),
                          Text(price[index].toString())
                        ],
                      ),
                    ),
                    Spacer(
                      flex: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          price.remove(price[index]);
                          title.remove(title[index]);
                          image.remove(image[index]);
                        });
                      },
                      icon: Icon(Icons.delete_forever_rounded),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
