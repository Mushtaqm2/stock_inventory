import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stock_inventory/Constants/constant.dart';
import 'package:stock_inventory/firestore_db.dart';
import 'package:stock_inventory/order_model.dart';

import '../stock_model.dart';

class StockController extends GetxController
{
  static StockController instance = Get.find();
  late File file;
  Rx<List<DocumentModel>> documentList = Rx<List<DocumentModel>>([]);
  List<DocumentModel> get documents => documentList.value;

  Rx<List<OrderModel>> orderList = Rx<List<OrderModel>>([]);
  List<OrderModel> get orders => orderList.value;

  @override
  void onReady() {
    documentList.bindStream(FirestoreDb.documentStream());
    orderList.bindStream(FirestoreDb.orderStream());
  }

  Future getPdfFile()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['jpg','png']);

    if (result != null) {
      file = File(result.files.single.path.toString());
    }
  }

  Future uploadFile(String barCode,name,wPrice,rPrice,quantity) async
  {
    if(barCode.isEmpty)
      {
        Get.snackbar(
          "Error",
          "please enter barcode ",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    else if(name.isEmpty)
      {
        Get.snackbar(
          "Error",
          "please enter product name",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    else if(file.path.isEmpty)
      {
        Get.snackbar(
          "Error",
          "please choose a file to upload",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    else{
      EasyLoading.show();
      await FirebaseStorage.instance.ref('Stocks/$name').putFile(file)
          .then((taskSnapshot) {
        if (taskSnapshot.state == TaskState.success) {
          FirebaseStorage.instance
              .ref('Stocks/$name')
              .getDownloadURL()
              .then((url) {
            firebaseFirestore
                .collection('Stocks')
                .add({
              'code':barCode,
              'name': name,
              'wholePrice':wPrice,
              'retailPrice':rPrice,
              'quantity':quantity,
              'url':url,
            });
          }).catchError((onError) {
            print("Got Error $onError");
            Get.snackbar(
              "Error",
              onError.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          });
        }
      });
      EasyLoading.dismiss();
    }
  }
  Future placeOrder(String id,name,quantity) async
  {
    EasyLoading.show();
    await firebaseFirestore
        .collection('Orders')
        .add({
      'id':id,
      'name':name,
      'quantity': quantity,
    }).whenComplete(() => Get.snackbar('', 'Order Placed',snackPosition: SnackPosition.BOTTOM)).catchError((onError) {
      print("Got Error $onError");
      Get.snackbar(
        "Error",
        onError.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    });
    EasyLoading.dismiss();
  }

  Future updateStock(String orderId, id,q) async
  {
    firebaseFirestore.collection('Stocks')
        .doc(id)
        .update({
      'quantity':q
    }).whenComplete(() => {
      firebaseFirestore.collection('Orders')
      .doc(orderId)
      .delete(),
      Get.snackbar('', 'Stock Updated',
          snackPosition: SnackPosition.BOTTOM)
    }
    ).onError((error, stackTrace) => {
      Get.snackbar('Error!', error.toString(),
      snackPosition: SnackPosition.BOTTOM)
    });
  }

}