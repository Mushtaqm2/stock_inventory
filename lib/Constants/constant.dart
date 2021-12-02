import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stock_inventory/Controllers/auth_controller.dart';
import 'package:stock_inventory/Controllers/stock_controller.dart';

AuthController authController = AuthController.instance;
StockController documentController=StockController.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;