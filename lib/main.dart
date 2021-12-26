// @dart=2.9

import 'package:first_flutter/core/store.dart';
import 'package:first_flutter/pages/cart_page.dart';
import 'package:first_flutter/pages/home_page.dart';
import 'package:first_flutter/pages/login_page.dart';
import 'package:first_flutter/utils/routs.dart';
import 'package:first_flutter/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(
      VxState(
        child: MyApp(),
        store: MyStore(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bringVegetables(thaila: true);
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: MyRouts.homeRoute,
      routes: {
        "/" : (context) => LoginPage(),
        MyRouts.homeRoute : (context) => HomePage(),
        MyRouts.loginRoute : (context) => LoginPage(),
        MyRouts.cartRoute : (context) => CartPage(),
      },
    );
  }

  bringVegetables({@required bool thaila, int rupees = 100}) {}
}
