//import 'dart:js_util';
import 'package:flutter/material.dart';

import 'package:food/inner_screens/favourite.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

favourite favourites = favourite();

List<String> title = favourites.titlelist();
List<int> price = favourites.pricelist();
List<String> image = favourites.imglist();

int total() {
  int x = price.length;
  int totalprice = 0;
  for (int i = 0; i < x; i++) {
    totalprice = totalprice + price[i];
  }
  return totalprice;
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Whish List"),
        backgroundColor: Color.fromARGB(255, 175, 76, 162),
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
