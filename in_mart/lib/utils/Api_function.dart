import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:in_mart/DataBase/ProductTable.dart';
import 'package:in_mart/models/CategoryModel.dart';
import 'package:http/http.dart' as http;
import 'package:in_mart/models/ProductModel.dart';
import 'package:in_mart/utils/helper.dart';

Future<Category> getCategory() async {
  var response = await http.get(CATEGORY);
  print(response.body);
  if (response.statusCode == 200) {
    return Category.fromJson(json.decode(response.body));
  } else {
    return null;
  }
}

Future<Category> getSubCategory(int id) async {
  var response = await http.get(SUBCATEGORGY + id.toString());
  print(response.body);
  if (response.statusCode == 200) {
    return Category.fromJson(json.decode(response.body));
  } else {
    return null;
  }
}
Future<List<ProductData>> getSubProducts(int id) async {
  var response = await http.get(PRODUCTS + id.toString());
  print(response.body);
  if (response.statusCode == 200) {
    Products prod=Products.fromJson(json.decode(response.body));
    return prod.data ;
  } else {
    return null;
  }
}

Future<Products> getTrending() async {
  var response = await http.get(TRENDING);
  // print(response.body);
  if (response.statusCode == 200) {
    return Products.fromJson(json.decode(response.body));
  } else {
    return null;
  }
}

Future<Products> getDod() async {
  var response = await http.get(DOD);
  // print(response.body);
  if (response.statusCode == 200) {
    return Products.fromJson(json.decode(response.body));
  } else {
    return null;
  }
}

Future<Products> getFrequently() async {
  var response = await http.get(FREQUENTLYBOUGHT);
  // print(response.body);
  if (response.statusCode == 200) {
    return Products.fromJson(json.decode(response.body));
  } else {
    return null;
  }
}

Future<List<ProductData>> searchProduct(String q) async {
  var response = await http.get(SEARCH + q);
  print(response.body);
  if (response.statusCode == 200) {
    Products prod = Products.fromJson(json.decode(response.body));
    return prod.data;
  } else {
    return null;
  }
}

class FavProducts extends ChangeNotifier {
  Set<ProductDbData> favproduct = Set();

  List<ProductDbData> getFav()=>favproduct.toList();

  unfavProduct(ProductDbData product, ProductsDb db) async {
    db.deleteProduct(product);
    favproduct.removeWhere((p) => p== product);
    notifyListeners();
  }

  bool isFav(int id) => favproduct.any((element) => element.productid==id);
  
  initialAdd(ProductsDb db) async {
    List<ProductDbData> p =await db.watchAllTasks();
    for(var i in p){
      favproduct.add(i);
    }
  }
  addToFav(ProductDbData product, ProductsDb db) async {
    db.insertProduct(product);
    favproduct.add(product);
    notifyListeners();
  }
}

// addToFav(ProductDbData product, ProductsDb db) {
//   db.insertProduct(product);
// }

// removeFav(ProductDbData product, ProductsDb db) {
//   db.deleteProduct(product);
// }
