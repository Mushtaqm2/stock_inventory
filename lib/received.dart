import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controllers/stock_controller.dart';

class ReceivedStock extends StatefulWidget
{
  const ReceivedStock({Key? key}) : super(key: key);

  @override
  State<ReceivedStock> createState() => _ReceivedStockState();
}

class _ReceivedStockState extends State<ReceivedStock>
{
  StockController documentController=Get.put(StockController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Received Stocks',),
        centerTitle: true,
      ),
      body:GetX<StockController>(
        init: Get.put<StockController>(StockController()),
        builder: (StockController docController)
        {
          return ListView.builder(
              itemCount: docController.orders.length,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(docController.orders[index].name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Quantity: ',style: TextStyle(color: Colors.grey.shade800,fontSize: 15),),
                                      Text(docController.orders[index].quantity,style: TextStyle(color: Colors.grey.shade600,fontSize: 16),),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        padding:MaterialStateProperty.all(EdgeInsets.fromLTRB(30, 10, 30, 10)),
                                        elevation: MaterialStateProperty.all(10),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                        backgroundColor: MaterialStateProperty.all(Colors.blue.shade300),
                                        //shadowColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSurface)
                                      ),
                                      onPressed: ()  {
                                        documentController.updateStock(docController.orders[index].orderId.toString(), docController.orders[index].id, docController.orders[index].quantity);
                                      },
                                      child: Text('Received')),
                                ],
                              )

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