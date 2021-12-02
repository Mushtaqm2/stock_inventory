import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentModel
{
  String? documentId;
  late String barCode;
  late String name;
  late String url;
  late String wholePrice;
  late String retailPrice;
  late String quantity;

  //DocumentModel({required this.title,required this.description,required this.category});

  DocumentModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.id;
    barCode = documentSnapshot["code"];
    name = documentSnapshot["name"];
    url = documentSnapshot["url"];
    wholePrice = documentSnapshot["wholePrice"];
    retailPrice=documentSnapshot["retailPrice"];
    quantity=documentSnapshot["quantity"];
  }

  //constructor that convert json to object instance
  DocumentModel.fromJson(Map<String, dynamic> json)
      :barCode=json['code'],
        name = json['name'],
        url = json['url'],
        wholePrice = json["wholePrice"],
        retailPrice=json["retailPrice"],
        quantity=json["quantity"];
  //a method that convert object to json
  Map<String, dynamic> toJson() => {
    'name': name,
    'code': barCode,
    'url':url,
    'wholePrice':wholePrice,
    'retailPrice':retailPrice,
    'quantity':quantity
  };
}