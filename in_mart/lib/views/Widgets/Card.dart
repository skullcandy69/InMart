import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:in_mart/utils/helper.dart';

class Cardwidget extends StatefulWidget {
  @override
  _CardwidgetState createState() => _CardwidgetState();
}

class _CardwidgetState extends State<Cardwidget> {
  List<String> list = [
    "https://image.shutterstock.com/image-vector/todays-deal-shopping-sale-vector-260nw-1293210970.jpg",
    "https://i2.wp.com/www.crewfetch.com/wp-content/uploads/2019/12/capture-20191215-144209u.png?resize=388%2C220&ssl=1",
    "https://static.langimg.com/thumb/msid-74507102,width-630,height-472,resizemode-75/pic.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSg6d9sSeX8KbJYaP4aGVONaUXfXuS1NM9F_ypnweb8X8lF0DXL&usqp=CAU",
    "https://ip.bitcointalk.org/?u=http%3A%2F%2Fg-ecx.images-amazon.com%2Fimages%2FG%2F31%2Fimg16%2FGateway%2F600x428_todays_deals._CB527352642_.png&t=613&c=ChEAH-kd8U17zw"
  ];
  // bool isLoading = true;
  // getCoverImages() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token');

  //   var response = await http.get(GETIMAGES, headers: {"Authorization": token});
  //   if (response.statusCode == 200) {
  //     CoverImages coverImages =
  //         CoverImages.fromJson(json.decode(response.body));
  //     setState(() {
  //       list = coverImages.data;
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // getCoverImages();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        height: 200,
        enlargeCenterPage: true,
        pauseAutoPlayOnTouch: Duration(seconds: 5),
        itemCount: list.length,
        autoPlay: true,
        itemBuilder: (context, index) {
          if ( list.length==0) {
            return Card(
              child: Container(
                height: 200,
                child: Center(
                  child: Icon(Icons.error_outline,size: 50,color: blue,)
                ),
              ),
            );
          } else {
          return _buildListItem(context, list[index]);
          }
        });
  }
}

_buildListItem(BuildContext context, String document) {
  return Card(
    elevation: 10,
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: document == null
          ? Container(child: Center(child: CircularProgressIndicator()))
          : Image.network(
              document,
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
            ),
    ),
  );
}
