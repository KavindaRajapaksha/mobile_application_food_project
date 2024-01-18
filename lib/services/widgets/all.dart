import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food/inner_screens/cartitems.dart';
import 'package:food/inner_screens/favourite.dart';
import 'package:food/services/widgets/price_widget.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  final _foodstream = FirebaseFirestore.instance.collection('foods');
  final _quantityTextController = TextEditingController();
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  cartitems cartItems = cartitems();
  favourite favouriteItems = favourite();
  String _searchText = '';

  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: Icon(Icons.menu),
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchTextController,
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search by Category",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Icon(Icons.shopping_cart)
          ],
        ),
      ),
      body: StreamBuilder(
        stream: _searchText.isEmpty
            ? _foodstream.snapshots()
            : _foodstream
                .where('category', isEqualTo: _searchText.toLowerCase())
                .snapshots(),
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
                              style: TextStyle(fontSize: 14),
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
