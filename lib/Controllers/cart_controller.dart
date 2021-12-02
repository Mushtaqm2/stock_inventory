import 'package:get/get.dart';
import 'package:stock_inventory/stock_model.dart';

class CartController extends GetxController
{
  List<DocumentModel> model=<DocumentModel>[];

  add(DocumentModel m)
  {
    model.add(m);
    update();
  }

  remove(DocumentModel m)
  {
    model.remove(m);
    update();
  }
}