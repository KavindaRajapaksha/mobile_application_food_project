import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget(
      {super.key,
      required this.catText,
      required this.imgPath,
      required this.color});
  final String catText, imgPath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double _screenwidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Container(
        //height: _screenwidth * 0.5,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.7), width: 2),
        ),
        child: Column(children: [
          Container(
            height: _screenwidth * 0.3,
            width: _screenwidth * 0.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgPath), fit: BoxFit.fill)),
          ),
          Text(
            catText,
            style: TextStyle(fontSize: 20),
          )
        ]),
      ),
    );
  }
}
