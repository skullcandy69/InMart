import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_mart/utils/helper.dart';
import 'package:in_mart/views/Screens/HomeScreen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final RoundedLoadingButtonController _buttonController =
      new RoundedLoadingButtonController();
final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black38, BlendMode.darken))),
        constraints: BoxConstraints.expand(),
        child: Center(
          child: Container(
            height: 300,
            width: 300,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Form(
              key: _formKey,
                child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'WELCOME',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email ID', icon: Icon(Icons.email)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password', icon: Icon(Icons.vpn_key)),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                RoundedLoadingButton(
                  controller: _buttonController,
                  height: 40,
                  width: 200,
                  color: primary,
                  onPressed: () {
                    Timer(
                        Duration(seconds: 5), () => _buttonController.reset());
                    changeScreen(context, HomePage());
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
