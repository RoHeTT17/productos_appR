import 'package:flutter/material.dart';
import 'package:productosapp_as/models/models.dart';

class ProductsService extends ChangeNotifier{

  //Base de la URL, debe ir sin http. 
  final String _baseURL = 'flutter-varios-6d280-default-rtdb.firebaseio.com';

  //Listado de todos los productos
  final List<Product> products = [];


  
}