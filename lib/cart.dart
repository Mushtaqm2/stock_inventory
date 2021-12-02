import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_inventory/Constants/constant.dart';
import 'package:stock_inventory/Controllers/cart_controller.dart';
import 'package:stock_inventory/stock_model.dart';
import '../main.dart';
import 'Controllers/stock_controller.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late double totalAmount;
  CartController controller=CartController();
  @override
  void initState() {
    super.initState();
    totalAmount = 0;
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
        builder:(value)=>Scaffold(
          appBar: AppBar(title:const Text('Cart',),
          centerTitle: true,
         ),
         body:Column(
           children: [
             Expanded(child:ListView.builder(
               itemCount: value.model.length,
               itemBuilder:(BuildContext context,int index)
               {
                 totalAmount=totalAmount+double.parse(value.model[index].retailPrice);
                 return InkWell(
                     child:Padding(
                       padding: EdgeInsets.all(10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             children: [
                               Text(value.model[index].name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                             ],
                           ),
                           SizedBox(height: 10,),
                           Column(
                             children: [
                               Text(value.model[index].retailPrice+'£',style: TextStyle(color: Colors.grey.shade600,fontSize: 16),),
                             ],
                           ),
                           SizedBox(height: 10,),
                         ],
                       ),
                     )
                 );
               },
             )),

                Padding(
                    padding: EdgeInsets.all(20),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Text('Total',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                     Text(totalAmount.toString()+'£',style: TextStyle(fontSize: 16),),
                    ],
                  )
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
                   updateData(value.model);
                 },
                 child: Text('Check Out')),
             SizedBox(height: 50,),
           ],
         )
     )
    );
  }

 updateData(List<DocumentModel> p)
 {
   EasyLoading.show();
   p.forEach((element) {
     int q=int.parse(element.quantity)-1;
     firebaseFirestore.collection('Stocks')
         .doc(element.documentId)
         .update({
       'quantity':q.toString()
     });
     controller.remove(element);
   });
   EasyLoading.dismiss();
   Get.back();
 }

}
