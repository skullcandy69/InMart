import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:in_mart/DataBase/ProductTable.dart';
import 'package:in_mart/models/CategoryModel.dart';
import 'package:in_mart/models/ProductModel.dart';
import 'package:in_mart/utils/Api_function.dart';
import 'package:in_mart/utils/helper.dart';
import 'package:in_mart/views/Screens/SubCat.dart';
import 'package:in_mart/views/Widgets/Card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  final VoidCallback fun;
  final ProductsDb database;

  const Home({Key key, this.fun, this.database}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const _adUnitID = "ca-app-pub-9800396717606741/1622308599";

  final _nativeAdController = NativeAdmobController();
  double _height = 0;

  StreamSubscription _subscription;

  @override
  void initState() {
    getElements();

    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _nativeAdController.dispose();
    super.dispose();
  }

  void _onStateChanged(AdLoadState state) {
    switch (state) {
      case AdLoadState.loading:
        setState(() {
          _height = 0;
        });
        break;

      case AdLoadState.loadCompleted:
        setState(() {
          _height = 200;
        });
        break;

      default:
        break;
    }
  }

  Category category;
  getElements() async {
    Category c = await getCategory();
    Products p = await getTrending();
    Products f = await getFrequently();
    Products d = await getDod();
    setState(() {
      category = c;
      products = p.data;
      freq = f.data;
      dod = d.data;
    });
  }

  List<ProductData> products = [];
  List<ProductData> freq = [];
  List<ProductData> dod = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<FavProducts>(
      builder: (context, fav, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primary,
            elevation: 2,
            primary: true,
            title: Text(' InMart'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                child: GestureDetector(
                  onTap: () {
                    widget.fun();
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
          body: Container(
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Todays Deal',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Cardwidget(),
                ),
                Stack(children: [
                  Container(
                    height: 45,
                    width: double.infinity,
                    color: Colors.deepPurple[200],
                    child: Center(
                        child: Text(
                      'Shop by Category',
                      style: TextStyle(color: white, fontSize: 20),
                    )),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: white),
                        child: Icon(
                          Icons.add_shopping_cart,
                          size: 40,
                        ),
                      ),
                    ),
                  )
                ]),
                category == null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100],
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.landscape
                                            ? 4
                                            : 3,
                                  ),
                                  itemBuilder: (_, __) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: 80.0,
                                                height: 80.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                              Container(
                                                width: 80,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2.0),
                                              ),
                                              Container(
                                                width: 60,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2.0),
                                              ),
                                              Container(
                                                width: 40.0,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  itemCount: 6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        itemCount: category.data.length,
                        addRepaintBoundaries: true,
                        physics: ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? 4
                              : 3,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              changeScreen(
                                  context,
                                  SubCat(
                                    database: widget.database,
                                    id: category.data[index].id,
                                    title: category.data[index].title,
                                  ));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        category.data[index].imageUrl,
                                        fit: BoxFit.fill,
                                        height: 80,
                                        width: 80,
                                      )),
                                  Text(category.data[index].title)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                Stack(children: [
                  Container(
                    height: 45,
                    width: double.infinity,
                    color: Colors.green[200],
                    child: Center(
                        child: Text(
                      'Trending',
                      style: TextStyle(color: white, fontSize: 20),
                    )),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: white),
                          child: Icon(
                            Icons.trending_up,
                            size: 50,
                          )),
                    ),
                  )
                ]),
                Container(
                  height: 250,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: products.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 220,
                          child: Card(
                            elevation: 20,
                            child: Container(
                              height: 250,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          height: 100,
                                          width: 170,
                                          decoration: BoxDecoration(
                                            // shape: BoxShape.circle,
                                            color: white,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  products[index].imageUrl,
                                                ),
                                                fit: BoxFit.contain),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //       color: Colors.grey,
                                            //       blurRadius: 5.0,
                                            //       offset: Offset(5, 8)),
                                            // ])
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 5,
                                            right: 10,
                                            child: InkWell(
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: grey,
                                                            offset:
                                                                Offset(2, 2),
                                                            blurRadius: 3)
                                                      ]),
                                                  alignment: Alignment.center,
                                                  child: fav.isFav(
                                                          products[index].id)
                                                      ? Icon(
                                                          Icons.favorite,
                                                          color: red,
                                                        )
                                                      : Icon(
                                                          Icons.favorite_border,
                                                          color: red,
                                                        )),
                                              onTap: () {
                                                final pro = ProductDbData(
                                                    title:
                                                        products[index].title,
                                                    productid:
                                                        products[index].id,
                                                    price:
                                                        products[index].price ??
                                                            0,
                                                    productType: products[index]
                                                        .productType,
                                                    company:
                                                        products[index].company,
                                                    link: products[index].link,
                                                    description: products[index]
                                                        .description,
                                                    imageUrl: products[index]
                                                        .imageUrl,
                                                    website: products[index]
                                                        .website);
                                                fav.isFav(products[index].id)
                                                    ? fav.unfavProduct(
                                                        pro, widget.database)
                                                    : fav.addToFav(
                                                        pro, widget.database);
                                              },
                                            ))
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      products[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      products[index]
                                          .productType
                                          .split('_')
                                          .join(' '),
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                      maxLines: 3,
                                    ),
                                    Text(
                                      products[index].description,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                      maxLines: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        FlatButton(
                                            visualDensity:
                                                VisualDensity.comfortable,
                                            padding: EdgeInsets.zero,
                                            color: green,
                                            onPressed: () async {
                                              try {
                                                await launch(
                                                    products[index].link);
                                              } catch (e) {
                                                print('error:' + e.toString());
                                              }
                                            },
                                            textColor: white,
                                            child: Text('buy')),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: _height,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: NativeAdmob(
                    adUnitID: _adUnitID,
                    controller: _nativeAdController,
                    loading: CircularProgressIndicator(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(children: [
                  Container(
                    height: 45,
                    width: double.infinity,
                    color: Colors.red[200],
                    child: Center(
                        child: Text(
                      'Frequently Bought',
                      style: TextStyle(color: white, fontSize: 20),
                    )),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: white),
                          child: Icon(
                            Icons.trending_up,
                            size: 50,
                          )),
                    ),
                  )
                ]),
                Container(
                  height: 250,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: freq.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 250,
                          child: Card(
                            elevation: 20,
                            child: Container(
                              height: 250,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          height: 100,
                                          width: 170,
                                          decoration: BoxDecoration(
                                            // shape: BoxShape.circle,
                                            color: white,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  freq[index].imageUrl,
                                                ),
                                                fit: BoxFit.contain),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //       color: Colors.grey,
                                            //       blurRadius: 5.0,
                                            //       offset: Offset(5, 8)),
                                            // ])
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 5,
                                            right: 10,
                                            child: InkWell(
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: white,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: fav
                                                          .isFav(freq[index].id)
                                                      ? Icon(
                                                          Icons.favorite,
                                                          color: red,
                                                        )
                                                      : Icon(
                                                          Icons.favorite_border,
                                                          color: red,
                                                        )),
                                              onTap: () {
                                                print(freq[index].id);
                                                final pro = ProductDbData(
                                                    title: freq[index].title,
                                                    productid: freq[index].id,
                                                    price:
                                                        freq[index].price ?? 0,
                                                    productType:
                                                        freq[index].productType,
                                                    company:
                                                        freq[index].company,
                                                    link: freq[index].link,
                                                    description:
                                                        freq[index].description,
                                                    imageUrl:
                                                        freq[index].imageUrl,
                                                    website:
                                                        freq[index].website);
                                                fav.isFav(freq[index].id)
                                                    ? fav.unfavProduct(
                                                        pro, widget.database)
                                                    : fav.addToFav(
                                                        pro, widget.database);
                                              },
                                            ))
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      freq[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      freq[index]
                                          .productType
                                          .split('_')
                                          .join(' '),
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                      maxLines: 3,
                                    ),
                                    Text(
                                      freq[index].description,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                      maxLines: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        FlatButton(
                                            visualDensity:
                                                VisualDensity.comfortable,
                                            padding: EdgeInsets.zero,
                                            color: green,
                                            onPressed: () async {
                                              try {
                                                await launch(freq[index].link);
                                              } catch (e) {
                                                print('error:' + e.toString());
                                              }
                                            },
                                            textColor: white,
                                            child: Text('buy')),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: _height,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: NativeAdmob(
                    adUnitID: "ca-app-pub-9800396717606741/5583688612",
                    controller: _nativeAdController,
                    loading: CircularProgressIndicator(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(children: [
                  Container(
                    height: 45,
                    width: double.infinity,
                    color: Colors.blue[200],
                    child: Center(
                        child: Text(
                      'Deal of the Day',
                      style: TextStyle(color: white, fontSize: 20),
                    )),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: white),
                          child: Icon(
                            Icons.trending_up,
                            size: 50,
                          )),
                    ),
                  )
                ]),
                Container(
                  height: 250,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: dod.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 250,
                          child: Card(
                            elevation: 20,
                            child: Container(
                              height: 250,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          height: 100,
                                          width: 170,
                                          decoration: BoxDecoration(
                                            // shape: BoxShape.circle,
                                            color: white,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  dod[index].imageUrl,
                                                ),
                                                fit: BoxFit.contain),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //       color: Colors.grey,
                                            //       blurRadius: 5.0,
                                            //       offset: Offset(5, 8)),
                                            // ])
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 5,
                                            right: 10,
                                            child: InkWell(
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: white,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: fav
                                                          .isFav(dod[index].id)
                                                      ? Icon(
                                                          Icons.favorite,
                                                          color: red,
                                                        )
                                                      : Icon(
                                                          Icons.favorite_border,
                                                          color: red,
                                                        )),
                                              onTap: () {
                                                final pro = ProductDbData(
                                                    title: dod[index].title,
                                                    productid: dod[index].id,
                                                    price:
                                                        dod[index].price ?? 0,
                                                    productType:
                                                        dod[index].productType,
                                                    company: dod[index].company,
                                                    link: dod[index].link,
                                                    description:
                                                        dod[index].description,
                                                    imageUrl:
                                                        dod[index].imageUrl,
                                                    website:
                                                        dod[index].website);
                                                fav.isFav(dod[index].id)
                                                    ? fav.unfavProduct(
                                                        pro, widget.database)
                                                    : fav.addToFav(
                                                        pro, widget.database);
                                              },
                                            ))
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      dod[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      dod[index]
                                          .productType
                                          .split('_')
                                          .join(' '),
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                      maxLines: 3,
                                    ),
                                    Text(
                                      dod[index].description,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                      maxLines: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        FlatButton(
                                            visualDensity:
                                                VisualDensity.comfortable,
                                            padding: EdgeInsets.zero,
                                            color: green,
                                            onPressed: () async {
                                              try {
                                                await launch(dod[index].link);
                                              } catch (e) {
                                                print('error:' + e.toString());
                                              }
                                            },
                                            textColor: white,
                                            child: Text('buy')),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            )),
          ),
        );
      },
    );
  }
}
