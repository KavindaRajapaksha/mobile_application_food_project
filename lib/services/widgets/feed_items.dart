// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food/inner_screens/cartitems.dart';
import 'package:food/inner_screens/favourite.dart';
import 'package:food/services/widgets/price_widget.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({super.key});

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
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
              int price = data.containsKey('price')
                  ? int.tryParse(data['price'].toString()) ?? 0
                  : 0;
              int discountprice = data.containsKey('discountprice')
                  ? int.tryParse(data['discountprice'].toString()) ?? 0
                  : 0;

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
                              style: TextStyle(fontSize: 13),
                            ),
                            GestureDetector(
                                onTap: () {
                                  favouriteItems.returntitle(title);
                                  favouriteItems.returnPrice(discountprice);
                                  favouriteItems.returnImg(imgUrl);
                                },
                                child: Icon(
                                  IconlyLight.heart,
                                  size: 22,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PriceWidget(
                              isOnSale: true,
                              price: price,
                              salePrice: discountprice,
                              textPrice: _quantityTextController.text,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            cartItems.returntitle(title);
                            cartItems.returnPrice(discountprice);
                            cartItems.returnImg(imgUrl);
                          },
                          child: Text(
                            "Add to cart",
                            maxLines: 1,
                            style: TextStyle(fontSize: 15),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).cardColor),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(12.0),
                                          bottomRight:
                                              Radius.circular(12.0))))),
                        ),
                      )
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
