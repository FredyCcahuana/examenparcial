   import 'package:examenparcial/pages/deatilPay_page.dart';
import 'package:examenparcial/pages/list_page.dart';
import 'package:examenparcial/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/':  (BuildContext context) => LoginPage(),
          '/list': (BuildContext context) => ListPage(title: 'Flutter Demo Home Page')
        },
      );
  }
}


