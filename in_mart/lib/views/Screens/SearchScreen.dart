import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:in_mart/DataBase/ProductTable.dart';
import 'package:in_mart/models/ProductModel.dart';
import 'package:in_mart/utils/Api_function.dart';
import 'package:in_mart/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:url_launcher/url_launcher.dart';

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>[
    'electonics',
    'mobile',
    'cloths',
    'momos',
    'shopping',
    'cloths'
  ],
  contentUrl: 'https://amazon.com',
  childDirected: false,
  testDevices: <String>[], // Android emulators are considered test devices
);
String appunitid = 'ca-app-pub-9800396717606741/1693626636';
BannerAd myBanner = BannerAd(
  adUnitId: appunitid,
  size: AdSize.banner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
    if (event == MobileAdEvent.loaded) {
      myBanner..show();
    }
  },
);

class SearchScreen extends StatefulWidget {
  final ProductsDb database;
  SearchScreen({Key key, this.database}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  CircularBottomNavigationController _navigationController;
  int selectedPos = 0;
  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
    myBanner.dispose();
    // myBanner=null;
  }

  @override
  void initState() {
    super.initState();
    _navigationController = new CircularBottomNavigationController(selectedPos);
    myBanner
      ..load()
      ..show(
        anchorOffset: 50.0,
        horizontalCenterOffset: 00.0,
        anchorType: AnchorType.bottom,
      );
  }

  List<ProductData> products = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<FavProducts>(builder: (context, fav, child) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  StickyHeader(
                    content: Padding(
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
                                child: Center(
                                    child: Image.asset('images/noresult.gif',
                                        fit: BoxFit.cover)),
                              );
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
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
                                                      width: size.width*0.5,
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
                                                                            2,
                                                                            2),
                                                                    blurRadius:
                                                                        3)
                                                              ]),
                                                          alignment:
                                                              Alignment.center,
                                                          child: fav.isFav(
                                                                  products[
                                                                          index]
                                                                      .id)
                                                              ? Icon(
                                                                  Icons
                                                                      .favorite,
                                                                  color: red,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .favorite_border,
                                                                  color: red,
                                                                )),
                                                      onTap: () {
                                                        final pro = ProductDbData(
                                                            title: products[index]
                                                                .title,
                                                            productid: products[index]
                                                                .id,
                                                            price: products[
                                                                        index]
                                                                    .price ??
                                                                0,
                                                            productType:
                                                                products[index]
                                                                    .productType,
                                                            company: products[
                                                                    index]
                                                                .company,
                                                            link: products[
                                                                    index]
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
                                                        fav.isFav(
                                                                products[index]
                                                                    .id)
                                                            ? fav.unfavProduct(
                                                                pro,
                                                                widget.database)
                                                            : fav.addToFav(
                                                                pro,
                                                                widget
                                                                    .database);
                                                      },
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                    products[index].description,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                                .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2),
                                                  ],
                                                ),
                                                Text(
                                                    products[index]
                                                        .productType
                                                        .split('_')
                                                        .join(' '),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2),
                                                Text(
                                                    "Seller: " +
                                                        products[index].website,
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
                    header: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(color: white, boxShadow: [
                          BoxShadow(
                              color: grey, offset: Offset(1, 2), blurRadius: 10)
                        ]),
                        child: ListTile(
                          leading: Icon(
                            Icons.search,
                            color: red,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.filter_list,
                              color: red,
                            ),
                            onPressed: () {
                              // myBanner.dispose();
                            },
                          ),
                          title: TextField(
                            autofocus: true,
                            onChanged: (val) async {
                              List<ProductData> p = await searchProduct(val);
                              setState(() {
                                products = p;
                              });
                            },
                            decoration: InputDecoration(
                                hintText: 'Find Indian Products',
                                border: InputBorder.none),
                          ),
                        ),
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
