import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_mart/DataBase/ProductTable.dart';
import 'package:in_mart/utils/Api_function.dart';
import 'package:in_mart/views/Screens/HomeScreen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    Provider<ProductsDb>(
      create: (context) => ProductsDb(),
      // child: MyApp(),
      dispose: (context, db) => db.close(),
    ),
    ChangeNotifierProvider.value(value: FavProducts()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<ProductsDb>(context);
    Provider.of<FavProducts>(context, listen: false).initialAdd(database);
    return MaterialApp(
      title: 'India Mart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.solwayTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(
        database: database,
      ),
    );
  }
}

// class SController extends StatefulWidget {

//   @override
//   _SControllerState createState() => _SControllerState();
// }

// class _SControllerState extends State<SController> {
//   String p;
//   isLoggedin() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     var token = pref.getString('token');
//     print(token);
//     if (token == null) {
//       setState(() {
//         p = 'login';
//       });
//     } else {
//       setState(() {
//         p = 'home';
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     isLoggedin();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final database = Provider.of<TokenDB>(context);
//     switch (p) {
//       case 'login':
//         return LoginPage();
//       case 'home':
//         return Appointments(database:database);
//       default:
//         return LoginPage();
//     }
//   }
// }
