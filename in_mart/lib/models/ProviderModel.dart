import 'package:flutter/material.dart';
import 'package:in_mart/models/ProductModel.dart';

class ProductModel extends ChangeNotifier {

  // List<Products> productlist = [];
  Set<Products> favproduct = Set();

  // List<ProductData> getProductList() {
  //   print(productlist.toSet().toList().length.toString() + "hello");
  //   return productlist.toSet().toList();
  // }

  List<Products> getFav() {
    // print(productlist.toSet().toList().length.toString() + "hello");
    return favproduct.toList();
  }

  // Future<void> fetchProducts() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token');
  //   if (token != null) {
  //     var response = await http.get(MYCART, headers: {"Authorization": token});
  //     var fav = await http.get(GETFAV, headers: {"Authorization": token});

  //     MyCart cartItem = MyCart.fromJson(json.decode(response.body));
  //     Products favpro = Products.fromJson(json.decode(fav.body));

  //     productlist.clear();
  //     favproduct.clear();
  //     for (int i = 0; i < favpro.data.length; i++) {
  //       favproduct.add(favpro.data[i]);
  //       notifyListeners();
  //     }
  //     for (int i = 0; i < cartItem.extra.length; i++) {
  //       productlist.add(cartItem.extra[i]);
  //       notifyListeners();
  //     }
  //   } else {
  //     print('No Token');
  //   }
  // }

  // deleteCart() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token');
  //   productlist.clear();
  //   var response =
  //       await http.delete(EMPTYCART, headers: {"Authorization": token});
  //       print(response.body);
  //   notifyListeners();
  // }

  // removeItem(ProductData product) {
  //   productlist.remove(product);
  //   print('removed len' + productlist.length.toString());
  //   notifyListeners();
  // }

  unfavProduct(Products product) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('token');
    favproduct.removeWhere((p) => p == product);
    notifyListeners();
    // var response = await http.put(REMOVEFAV + product.id.toString(),
    //     headers: {"Authorization": token});
    // print(response.body);
  }

  // void removeProduct(ProductData product) {
  //   productlist.removeWhere((p) => p.id == product.id);
  //   notifyListeners();
  // }

  // int getQuanity(int id) => productlist.where((p) => id == p.id).length;
  bool isFav(Products product) => favproduct.contains(product);
  // clearList() {
  //   productlist.clear();
  //   notifyListeners();
  // }

  // dynamic get tprice => totalprice();
  // dynamic get discount => discountamount();
  // dynamic get subtotal => subtotalamount();
  // dynamic totalprice() {
  //   dynamic tprice = 0;
  //   if (productlist.length == 0) {
  //     tprice = 0;
  //   } else {
  //     for (int i = 0; i < productlist.length; i++) {
  //       tprice += productlist[i].sellingPrice;
  //     }
  //   }

  //   return tprice;
  // }

  // dynamic subtotalamount() {
  //   dynamic subtotal = 0;
  //   if (productlist.length == 0) {
  //     subtotal = 0;
  //   } else {
  //     for (int i = 0; i < productlist.length; i++) {
  //       subtotal += productlist[i].mrp;
  //     }
  //   }
  //   return subtotal;
  // }

  // dynamic discountamount() {
  //   dynamic discount = 0;
  //   if (productlist.length == 0) {
  //     discount = 0;
  //   } else {
  //     for (int i = 0; i < productlist.length; i++) {
  //       discount += productlist[i].offAmount;
  //     }
  //   }
  //   return discount;
  // }

  // addTaskInList(ProductData pro) {
  //   productlist.add(pro);
  //   notifyListeners();
  // }

  addToFav(Products pro) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('token');
    favproduct.add(pro);
    notifyListeners();
    // var response = await http
    //     .put(ADDTOFAV + pro.id.toString(), headers: {"Authorization": token});
    // print(response.body);
  }
  }