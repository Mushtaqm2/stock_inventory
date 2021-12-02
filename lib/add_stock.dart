import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_inventory/Controllers/stock_controller.dart';

class AddStock extends StatefulWidget
{
  const AddStock({Key?key}):super(key: key);

  State<AddStock> createState()=> _AddStockState();
}

class _AddStockState extends State<AddStock>
{
  StockController _documentController=Get.put(StockController());
  final TextEditingController titleController=TextEditingController();
  final TextEditingController descController=TextEditingController();
  double wPrice=1;
  double rPrice=1;
  double quantity=1;



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Add Stock'),),),
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
                    TextField(
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Product name",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      controller: descController,
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text('Wholesale Price:'),
                        Slider(
                          min: 1,
                          max: 30,
                          value: wPrice,
                          divisions: 30,
                          label: (wPrice).round().toString()+'£',
                          onChanged: (value) {
                            setState(() {
                              wPrice = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text('Retail Price:        '),
                        Slider(
                          min: 1,
                          max: 30,
                          value: rPrice,
                          divisions: 30,
                          label: (rPrice).round().toString()+'£',
                          onChanged: (value) {
                            setState(() {
                              rPrice = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text('Quantity:             '),
                        Slider(
                          min: 1,
                          max: 100,
                          value: quantity,
                          divisions: 100,
                          label: (quantity).round().toString(),
                          onChanged: (value) {
                            setState(() {
                              quantity = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
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
                          _documentController.getPdfFile();
                        },
                        child: Text('choose photo')),
                    SizedBox(height: 20,),
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
                          _documentController.uploadFile(titleController.text.trim(),descController.text.trim(),wPrice.round().toString(),rPrice.round().toString(),quantity.round().toString());
                          titleController.clear();
                          descController.clear();
                        },
                        child: Text('Add')),
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