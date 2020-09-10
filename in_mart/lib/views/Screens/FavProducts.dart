import 'package:flutter/material.dart';
import 'package:in_mart/DataBase/ProductTable.dart';
import 'package:in_mart/utils/Api_function.dart';
import 'package:in_mart/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FavProduct extends StatelessWidget {
  final ProductsDb database;
  final VoidCallback fun;

  const FavProduct({Key key, this.database, this.fun}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<FavProducts>(
      builder: (context, fav, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primary,
            elevation: 2,
            primary: true,
            title: Text('WishList'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                child: GestureDetector(
                  onTap: () {
                    fun();
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
                        height: size.height * 0.7,
                        child: ListView.separated(
                          itemCount: fav.getFav().length == 0
                              ? 1
                              : fav.getFav().length,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                          itemBuilder: (BuildContext context, int index) {
                            if (fav.getFav().length == 0) {
                              return Container(
                                height: size.height * 0.7,
                                color: white,
                                child: Center(
                                    child: Image.asset(
                                        'images/emptywishlist.png',
                                        fit: BoxFit.cover)),
                              );
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: GestureDetector(
                                  onTap: () => launch(fav.getFav()[index].link),
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
                                                  image: NetworkImage(fav
                                                      .getFav()[index]
                                                      .imageUrl),
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
                                                        fav.getFav()[index].title,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style:  Theme.of(context).textTheme.subtitle1,
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
                                                          child: fav.isFav(fav
                                                                  .getFav()[
                                                                      index]
                                                                  .productid)
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
                                                            title: fav
                                                                .getFav()[index]
                                                                .title,
                                                            productid: fav
                                                                .getFav()[index]
                                                                .productid,
                                                            price: fav
                                                                    .getFav()[
                                                                        index]
                                                                    .price ??
                                                                0,
                                                            productType: fav
                                                                .getFav()[index]
                                                                .productType,
                                                            company: fav
                                                                .getFav()[index]
                                                                .company,
                                                            link: fav
                                                                .getFav()[index]
                                                                .link,
                                                            description: fav
                                                                .getFav()[index]
                                                                .description,
                                                            imageUrl: fav
                                                                .getFav()[index]
                                                                .imageUrl,
                                                            website: fav
                                                                .getFav()[index]
                                                                .website);
                                                        fav.isFav(fav
                                                                .getFav()[index]
                                                                .productid)
                                                            ? fav.unfavProduct(
                                                                pro, database)
                                                            : fav.addToFav(
                                                                pro, database);
                                                      },
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                    fav
                                                        .getFav()[index]
                                                        .description,
                                                        maxLines: 2,
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
                                                            fav
                                                                .getFav()[index]
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
                                                    fav
                                                        .getFav()[index]
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
                                                        fav
                                                            .getFav()[index]
                                                            .website,
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
      },
    );
  }
}
