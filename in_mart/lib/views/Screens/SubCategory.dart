import 'package:flutter/material.dart';
import 'package:in_mart/DataBase/ProductTable.dart';
import 'package:in_mart/models/ProductModel.dart';
import 'package:in_mart/utils/Api_function.dart';
import 'package:in_mart/utils/helper.dart';
import 'package:in_mart/views/Screens/SearchScreen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SubProductsScreen extends StatefulWidget {
  final ProductsDb database;
  final int id;
  final String title;
  SubProductsScreen({Key key, this.database, this.id, this.title})
      : super(key: key);

  @override
  _SubProductsScreenState createState() => _SubProductsScreenState();
}

class _SubProductsScreenState extends State<SubProductsScreen> {
  List<ProductData> products = [];
  fetchProducts() async {
    List<ProductData> p = await getSubProducts(widget.id);
    setState(() {
      products = p;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<FavProducts>(builder: (context, fav, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          elevation: 2,
          primary: true,
          title: Text(widget.title),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              alignment: Alignment.center,
              height: 50,
              child: GestureDetector(
                onTap: () {
                  changeScreen(
                      context,
                      SearchScreen(
                        database: widget.database,
                      ));
                },
                child: Container(
                  height: 45,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextField(
                    decoration: InputDecoration(
                        enabled: false,
                        icon: Icon(
                          Icons.search,
                          color: grey,
                        ),
                        hintText: 'Search for Products',
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width,
                      height: size.height * 0.75,
                      child: ListView.separated(
                        itemCount: products.length == 0 ? 1 : products.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          if (products.length == 0) {
                            return Container(
                              height: size.height * 0.8,
                              color: white,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: GestureDetector(
                                onTap: () => launch(products[index].link),
                                child: Container(
                                  height: 130,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: grey,
                                            offset: Offset(2, 2),
                                            blurRadius: 3)
                                      ]),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 130,
                                        width: 120,
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    products[index].imageUrl),
                                                fit: BoxFit.contain)),
                                      ),
                                      Container(
                                          height: 120,
                                          width: size.width * .6,
                                          margin: EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    width: size.width*.5,
                                                    child: Text(
                                                      products[index].title,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: white,
                                                                boxShadow: [
                                                              BoxShadow(
                                                                  color: grey,
                                                                  offset:
                                                                      Offset(
                                                                          2, 2),
                                                                  blurRadius: 3)
                                                            ]),
                                                        alignment:
                                                            Alignment.center,
                                                        child: fav.isFav(
                                                                products[index]
                                                                    .id)
                                                            ? Icon(
                                                                Icons.favorite,
                                                                color: red,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .favorite_border,
                                                                color: red,
                                                              )),
                                                    onTap: () {
                                                      final pro = ProductDbData(
                                                          title:
                                                              products[index]
                                                                  .title,
                                                          productid:
                                                              products[index]
                                                                  .id,
                                                          price:
                                                              products[
                                                                          index]
                                                                      .price ??
                                                                  0,
                                                          productType:
                                                              products[
                                                                      index]
                                                                  .productType,
                                                          company: products[index]
                                                              .company,
                                                          link:
                                                              products[index]
                                                                  .link,
                                                          description:
                                                              products[index]
                                                                  .description,
                                                          imageUrl:
                                                              products[index]
                                                                  .imageUrl,
                                                          website:
                                                              products[index]
                                                                  .website);
                                                      fav.isFav(products[index]
                                                              .id)
                                                          ? fav.unfavProduct(
                                                              pro,
                                                              widget.database)
                                                          : fav.addToFav(pro,
                                                              widget.database);
                                                    },
                                                  )
                                                ],
                                              ),
                                              Text(products[index].description??' ',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                      "₹ " +
                                                          products[index]
                                                              .price
                                                              .toString()??" ",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2),
                                                ],
                                              ),
                                              Text(products[index].productType.split('_').join(' ')??' ',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2),
                                              Text(
                                                  "Seller: " +
                                                      products[index].website??" ",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  // Container(
                  //   // constraints: BoxConstraints.expand(),
                  //   color: black,
                  //   height: MediaQuery.of(context).size.height,
                  // )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
