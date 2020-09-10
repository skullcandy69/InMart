import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:in_mart/DataBase/ProductTable.dart';
import 'package:in_mart/views/Screens/Home.dart';
import 'package:in_mart/views/Screens/SearchScreen.dart';
import 'FavProducts.dart';
MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['electonics', 'mobile','cloths','momos','shopping','cloths'],
  contentUrl: 'https://amazon.com',
  childDirected: false,
  testDevices: <String>[], // Android emulators are considered test devices
);
String appunitid='ca-app-pub-9800396717606741/1693626636';
BannerAd myBanner = BannerAd(
  adUnitId:appunitid,
  size: AdSize.banner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
     if (event == MobileAdEvent.loaded) {
            myBanner..show();
          }
  },
);
class HomePage extends StatefulWidget {
  final ProductsDb database;

  const HomePage({Key key, this.database}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPos = 0;

  double bottomNavBarHeight = 50;

  List<TabItem> tabItems = List.of([
    new TabItem(Icons.home, "Home", Colors.blue,
        labelStyle: TextStyle(fontWeight: FontWeight.normal)),
    new TabItem(Icons.search, "Search", Colors.orange,
        labelStyle: TextStyle(fontWeight: FontWeight.normal)),
    new TabItem(Icons.favorite, "Favorite", Colors.cyan,
        labelStyle: TextStyle(fontWeight: FontWeight.normal))
  ]);

  CircularBottomNavigationController _navigationController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNav(),
      body: bodyContainer(),
    );
  }

  Widget bodyContainer() {
    switch (selectedPos) {
      case 0:
        
        return Home(fun: search,database:widget.database);
        break;
      case 1:
        return SearchScreen(database:widget.database);
        break;
      default:
        return FavProduct(database:widget.database,fun: search);
        break;
    }
  }

  void search() {
    setState(() {
      selectedPos = 1;
    });
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int selectedPos) {
        setState(() {
          this.selectedPos = selectedPos;
          
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
     myBanner.dispose();
    // myBanner=null;
  }
}
