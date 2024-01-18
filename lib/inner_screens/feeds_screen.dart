// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food/services/widgets/all.dart';
import 'package:food/services/widgets/feed_items.dart';

class FeedScreen extends StatefulWidget {
  static const routeName = "/FeedcreenState";
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.green,
            title: Text(
              "All products",
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 1,
                childAspectRatio: 250 / 300,
                children: List.generate(1, (index) {
                  return All();
                }),
              )
            ],
          ),
        ));
  }
}
