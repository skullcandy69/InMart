import 'package:flutter/material.dart';

Color primary = Colors.amber;
Color white = Colors.white;
Color black = Colors.black;
Color blue = Colors.blue;
Color red = Colors.red;
Color green = Colors.green;
Color grey = Colors.grey;
void changeScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void changeScreenRepacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

// const BASEURL = 'https://aatmanirbhar.herokuapp.com';
const BASEURL='http://ec2-65-0-0-99.ap-south-1.compute.amazonaws.com:3000';
const CATEGORY = BASEURL + '/categories';
const SUBCATEGORGY = BASEURL + '/sub-categories/';
const PRODUCTS = BASEURL + "/products/";
const SEARCH = BASEURL + "/products?query=";
const TRENDING = BASEURL + "/products/trending";
const DOD = BASEURL + "/products/deal-of-the-day";
const FREQUENTLYBOUGHT = BASEURL + "/products/frequently-bought";
