import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_inventory/Controllers/cart_controller.dart';
import 'package:stock_inventory/Controllers/stock_controller.dart';
import 'package:stock_inventory/cart.dart';

import 'stock_model.dart';

class TillScreen extends StatefulWidget
{
  const TillScreen({Key?key}):super(key: key);

  State<TillScreen> createState()=> _TillScreenState();
}

class _TillScreenState extends State<TillScreen>
{
  StockController _documentController=Get.put(StockController());
  CartController _cartController=Get.put(CartController());
  final TextEditingController titleController=TextEditingController();
  bool isAdded=false;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title:Text('Till Screen'),
      centerTitle: true,
        /*actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Route route = MaterialPageRoute(builder: (_)=>CartPage());
                  // Navigator.push(context, route);
                  Get.to(CartPage());
                },
              ),
            ],
          ),
        ],*/
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top:30),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  children: [
                    TextField(
                      style: TextStyle(color: Colors.black),
                      keyboardType:TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Bar code number",
                          hintStyle:TextStyle(color: Colors.grey.shade500) ,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      controller: titleController,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          padding:MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 10, 50, 10)),
                          elevation: MaterialStateProperty.all(10),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                          backgroundColor: MaterialStateProperty.all(Colors.blue.shade300),
                          //shadowColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSurface)
                        ),
                        onPressed: (){
                            _documentController.documents.forEach((element) {
                              if(element.barCode==titleController.text.trim().toString())
                                {
                                  /*Fluttertoast.showToast(msg: "Added to cart",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );*/
                                  _cartController.add(element);
                                  titleController.clear();
                                  setState(() {
                                    isAdded=true;
                                  });
                                }
                              else
                                {
                                  /*Fluttertoast.showToast(msg: "Barcode is not correct",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );*/
                                }
                            });
                          },
                        child: Text('Add')),
                    SizedBox(
                      height: 30,
                    ),
                    isAdded?ElevatedButton(
                        style: ButtonStyle(
                          padding:MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 10, 50, 10)),
                          elevation: MaterialStateProperty.all(10),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                          backgroundColor: MaterialStateProperty.all(Colors.blue.shade300),
                          //shadowColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSurface)
                        ),
                        onPressed: (){
                          Get.to(CartPage());
                        },
                        child: Text('Go to Cart')):Container() ,
                  ],
                ),
              )
            ],
          ),
        ),
      ) ,
    );
  }
}