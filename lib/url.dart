class LoginUrl {
  static String login = "http://10.0.2.2:8000/api/login";
  static String register = "http://10.0.2.2:8000/api/register";
}

class AdminUrl {
  static String add_kurir = "http://10.0.2.2:8000/api/register";
  static String delete_kurir = "http://10.0.2.2:8000/api/deletekurir";
}

class KurirUrl {
  static String show_kurir = "http://10.0.2.2:8000/api/showkurir";
}

class ProductUrl {
  static String add_product = "http://10.0.2.2:8000/api/addproduct";
  static String show_product = "http://10.0.2.2:8000/api/showproduct";
  static String delete_product = "http://10.0.2.2:8000/api/deleteproduct";
  static String newest_product = "http://10.0.2.2:8000/api/newproduct";
  static String product_detail = "http://10.0.2.2:8000/api/product_detail";
  static String showProductCat = "http://10.0.2.2:8000/api/showProductCat";
}

class OrderUrl {
  static String addCart = "http://10.0.2.2:8000/api/addCart";
  static String minusCart = "http://10.0.2.2:8000/api/minusCart";
  static String myCart = "http://10.0.2.2:8000/api/myCart";
  static String quantity = "http://10.0.2.2:8000/api/quantity";
  static String delete_order = "http://10.0.2.2:8000/api/deleteOrder";
  static String orderNow = "http://10.0.2.2:8000/api/orderNow";
}

class CategoryUrl {
  static String show_cat = "http://10.0.2.2:8000/api/showcat";
}

class ImageUrl {
  static String product_img =
      "http://192.168.43.226/laravelapps/BonAppetit/public/api/image/";
}
