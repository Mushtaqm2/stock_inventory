import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel
{
  String? orderId;
  late String id;
  late String name;
  late String quantity;

  OrderModel.fromOrderSnapshot({required DocumentSnapshot documentSnapshot}) {
    orderId = documentSnapshot.id;
    id = documentSnapshot["id"];
    name = documentSnapshot["name"];
    quantity=documentSnapshot["quantity"];
  }
}