import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_inventory/add_stock.dart';
import 'package:stock_inventory/received.dart';
import 'package:stock_inventory/restock.dart';
import 'package:stock_inventory/till_screen.dart';
import 'Constants/constant.dart';
import 'Controllers/stock_controller.dart';

class Home extends StatefulWidget
{
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
{
  StockController documentController=Get.put(StockController());
  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(title:const Text('Stocks',),
           centerTitle: true,
          ),
          drawer:Drawer(
            child:ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                 DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child:Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(auth.currentUser!.email.toString()),
                  ),
                ),
                ListTile(
                  title: const Text('Logout'),
                  onTap: () {
                    authController.signOut();
                  },
                ),
                ListTile(
                  title: const Text('Add Stock Item'),
                  onTap: () {
                    Get.back();
                    Get.to(AddStock());
                  },
                ),
                ListTile(
                  title: const Text('ReStock'),
                  onTap: () {
                    Get.back();
                    Get.to(Restock());
                  },
                ),
                ListTile(
                  title: const Text('Received Stock'),
                  onTap: () {
                    Get.back();
                    Get.to(ReceivedStock());
                  },
                ),
                ListTile(
                  title: const Text('Till'),
                  onTap: () {
                    Get.back();
                    Get.to(TillScreen());
                  },
                ),
              ],
            ),
          ),
          body:GetX<StockController>(
            init: Get.put<StockController>(StockController()),
            builder: (StockController docController)
            {
              return ListView.builder(
                  itemCount: docController.documents.length,
                  itemBuilder:(BuildContext context,int index)
                  {
                    return Card(
                        child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              print('Card tapped.');
                            },
                            child:Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(docController.documents[index].name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Wholesale Price:  ',style: TextStyle(color: Colors.grey.shade800,fontSize: 15),),
                                      Text(docController.documents[index].wholePrice+'£',style: TextStyle(color: Colors.grey.shade600,fontSize: 16),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Retail Price:        ',style: TextStyle(color: Colors.grey.shade800,fontSize: 15),),
                                      Text(docController.documents[index].retailPrice+'£',style: TextStyle(color: Colors.grey.shade600,fontSize: 16),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Quantity:            ',style: TextStyle(color: Colors.grey.shade800,fontSize: 15),),
                                      Text(docController.documents[index].quantity,style: TextStyle(color: Colors.grey.shade600,fontSize: 16),),
                                    ],
                                  ),
                                ],
                              ),
                            )
                        ));
                  }
              );
            },
          ),
        );
  }


}