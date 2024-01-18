import 'package:flutter/material.dart';

class GlobalMethods {
  static navigateTo({required ctx, required String routeName}) {
    Navigator.pushNamed(ctx, routeName);
  }
}
