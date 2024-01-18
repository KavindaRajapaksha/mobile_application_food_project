// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {super.key,
      required this.salePrice,
      required this.price,
      required this.textPrice,
      required this.isOnSale});
  final int salePrice, price;
  final String textPrice;
  final bool isOnSale;

  @override
  Widget build(BuildContext context) {
    int userPrice = isOnSale ? salePrice : price;
    return Row(
      children: [
        Text(
          "Rs${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}",
          style: TextStyle(fontSize: 15, color: Colors.green),
        ),
        const SizedBox(
          width: 5,
        ),
        Visibility(
          visible: salePrice != price ? true : false,
          child: Text(
            "Rs${(price * int.parse(textPrice)).toStringAsFixed(2)}",
            style:
                TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough),
          ),
        )
      ],
    );
  }
}
