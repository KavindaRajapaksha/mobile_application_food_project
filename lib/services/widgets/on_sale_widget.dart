// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food/services/widgets/heart_btn.dart';
import 'package:food/services/widgets/price_widget.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({super.key});

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  final _feedstream =
      FirebaseFirestore.instance.collection('foods').snapshots();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/burger.png',
                        height: 80,
                        fit: BoxFit.fill,
                      ),
                      Column(
                        children: [
                          Text(
                            "Large",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  IconlyBold.bag,
                                  size: 22,
                                ),
                              ),
                              HeartBTN(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  PriceWidget(
                    isOnSale: true,
                    price: 5,
                    salePrice: 2,
                    textPrice: "1",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Product title",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
