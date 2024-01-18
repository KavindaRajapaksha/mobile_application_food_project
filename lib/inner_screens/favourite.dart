class favourite {
  static final favourite _instance = favourite._internal();

  factory favourite() {
    return _instance;
  }

  favourite._internal();
  List<String> favouriteItemTitle = [];
  List<int> favouriteItemPrice = [];
  List<String> favouriteItemImg = [];

  void returntitle(String title) {
    favouriteItemTitle.add(title);
  }

  void returnPrice(int price) {
    favouriteItemPrice.add(price);
  }

  void returnImg(String imgurl) {
    favouriteItemImg.add(imgurl);
  }

  dynamic titlelist() {
    return favouriteItemTitle;
  }

  dynamic pricelist() {
    return favouriteItemPrice;
  }

  dynamic imglist() {
    return favouriteItemImg;
  }
}
