// ignore_for_file: prefer_const_constructors, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food/services/widgets/on_sale_widget.dart';

class OnSaleScreen extends StatelessWidget {
  const OnSaleScreen({super.key});
  static const routeName = "/OnSaleScreen";
  @override
  Widget build(BuildContext context) {
    bool _isEmpty = false;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "On sale products",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          leading: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(IconlyLight.arrowLeft2),
          )),
      body: _isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "No product on sale yet",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 250 / 300,
              children: List.generate(16, (index) {
                return OnSaleWidget();
              }),
            ),
    );
  }
}
