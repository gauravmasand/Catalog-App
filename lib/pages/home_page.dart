import 'dart:ui';

import 'package:first_flutter/core/store.dart';
import 'package:first_flutter/models/cart.dart';
import 'package:first_flutter/utils/routs.dart';
import 'package:first_flutter/widgets/drawer.dart';
import 'package:first_flutter/models/catelog.dart';
import 'package:first_flutter/widgets/home_widgets/catalog_header.dart';
import 'package:first_flutter/widgets/home_widgets/catalog_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final url = "https://firebasestorage.googleapis.com/v0/b/billing-app-da5ba.appspot.com/o/json%2Fcatalog.json?alt=media&token=de48f056-9c5b-43f6-ba3f-2b371c128dd2";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    // final catalogJson =
    //     await rootBundle.loadString("assets/files/catalog.json");

    final response = await http.get(Uri.parse(url));
    final catalogJson = response.body;

    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatalogModel.items = List.from(productsData).map<Item>((item) => Item.fromMap(item)).toList();

    setState(() { });

  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold (
      backgroundColor: context.canvasColor,
      floatingActionButton: VxBuilder(
        mutations: {AddMutation, RemoveMutation},
        builder: (ctx, _) => FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, MyRouts.cartRoute),
          child: Icon(CupertinoIcons.cart, color: Colors.white,),
          backgroundColor: context.theme.buttonColor,
        ).badge(color: Vx.red500, size: 22, count: _cart.items!.length, textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                CatalogList().py16().expand()
              else
                CircularProgressIndicator().centered().expand()
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

