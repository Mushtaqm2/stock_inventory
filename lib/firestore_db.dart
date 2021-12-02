import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:stock_inventory/stock_model.dart';
import 'package:stock_inventory/order_model.dart';
import 'Constants/constant.dart';

class FirestoreDb
{
  static Stream<List<DocumentModel>> documentStream() {
   // EasyLoading.show();
     return firebaseFirestore
        .collection('Stocks')
        .snapshots()
        .map((QuerySnapshot query) {
      List<DocumentModel> todos = [];
      for (var todo in query.docs) {
        final documentModel =
        DocumentModel.fromDocumentSnapshot(documentSnapshot: todo);
            todos.add(documentModel);
       // EasyLoading.dismiss();
      }
      return todos;
    });

  }

  static Stream<List<OrderModel>> orderStream() {
    // EasyLoading.show();
    return firebaseFirestore
        .collection('Orders')
        .snapshots()
        .map((QuerySnapshot query) {
      List<OrderModel> todos = [];
      for (var todo in query.docs) {
        final orderModel =
        OrderModel.fromOrderSnapshot(documentSnapshot: todo);
        todos.add(orderModel);
        // EasyLoading.dismiss();
      }
      return todos;
    });

  }
}