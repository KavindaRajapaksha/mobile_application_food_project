class cartitems {
  static final cartitems _instance = cartitems._internal();

  factory cartitems() {
    return _instance;
  }

  cartitems._internal();
  List<String> cartItemTitle = [];
  List<int> cartItemPrice = [];
  List<String> cartItemImg = [];

  void returntitle(String title) {
    cartItemTitle.add(title);
  }

  void returnPrice(int price) {
    cartItemPrice.add(price);
  }

  void returnImg(String imgurl) {
    cartItemImg.add(imgurl);
  }

  dynamic titlelist() {
    return cartItemTitle;
  }

  dynamic pricelist() {
    return cartItemPrice;
  }

  dynamic imglist() {
    return cartItemImg;
  }

  void printt() {
    print(cartItemTitle.length);
  }
}
