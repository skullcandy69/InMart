import 'package:flutter/material.dart';
import 'package:in_mart/DataBase/ProductTable.dart';
import 'package:in_mart/models/CategoryModel.dart';
import 'package:in_mart/utils/Api_function.dart';
import 'package:in_mart/utils/helper.dart';
import 'package:in_mart/views/Screens/SearchScreen.dart';
import 'package:in_mart/views/Screens/SubCategory.dart';

class SubCat extends StatefulWidget {
  final ProductsDb database;
  final int id;
  final String title;

  SubCat({Key key, this.database, this.id, this.title}) : super(key: key);

  @override
  _SubCatState createState() => _SubCatState();
}

class _SubCatState extends State<SubCat> {
  Category category;
  fetchCat() async {
    Category c;
    c = await getSubCategory(widget.id);
    setState(() {
      category = c;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCat();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        body: category == null
            ? Container(
                height: size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                height: size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: category.data.length,
                    addRepaintBoundaries: true,
                    physics: ScrollPhysics(),
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: MediaQuery.of(context).orientation ==
                    //           Orientation.landscape
                    //       ? 4
                    //       : 3,
                    // ),
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 5,
                        child: Divider(),
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            changeScreen(
                                context,
                                SubProductsScreen(
                                  database: widget.database,
                                  id: category.data[index].id,
                                  title: category.data[index].title,
                                ));
                          },
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              child: Image.network(
                                category.data[index].imageUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                            title: Text(category.data[index].title),
                            trailing: Icon(Icons.navigate_next),
                          ));
                    },
                  ),
                ),
              ));
  }
}
