import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_inventory/add_stock.dart';
import 'Constants/constant.dart';
import 'Controllers/stock_controller.dart';

class Restock extends StatefulWidget
{
  const Restock({Key? key}) : super(key: key);

  @override
  State<Restock> createState() => _RestockState();
}

class _RestockState extends State<Restock>
{
  StockController documentController=Get.put(StockController());
  double orderQuantity=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('ReStock',),
        centerTitle: true,
      ),
      body:GetX<StockController>(
        init: Get.put<StockController>(StockController()),
        builder: (StockController docController)
        {
          return ListView.builder(
              itemCount: docController.documents.length,
              itemBuilder:(BuildContext context,int index)
              {
                return int.parse(docController.documents[index].quantity)<=5?Card(
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
                              SizedBox(height: 20,),
                              Slider(
                                min: 0,
                                max: 100,
                                value: orderQuantity,
                                divisions: 100,
                                label: (orderQuantity).round().toString(),
                                onChanged: (value) {
                                  setState(() {
                                    orderQuantity = value;
                                  });
                                },
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
                                  onPressed: ()  {
                                    documentController.placeOrder(docController.documents[index].documentId.toString(),docController.documents[index].name, orderQuantity.round().toString());
                                  },
                                  child: Text('Place Order')),
                            ],
                          ),
                        )
                    )):Text('');
              }
          );
        },
      ),
    );
  }


}