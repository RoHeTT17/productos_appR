import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productosapp_as/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier{

  //Base de la URL, debe ir sin http (lo agrega en automático). 
  final String _baseURL = 'flutter-varios-6d280-default-rtdb.firebaseio.com';

  //Listado de todos los productos. Este final, porque no se quiere destruir el objeto, solo cambiar sus valores internos
  final List<Product> products = [];

  //Para saber si esta cargando o no. NO ES final, porque va estar cambiando entre true y false.
  bool isLoading = true;

  //El producto seleccionado
  late Product selectedProduct;

  ProductsService(){

    this.loadProducts();

  }

  Future<List<Product>> loadProducts() async{

     //indicar que se esta cargando. si el valor ya era true no redibuja
     this.isLoading = true;
     notifyListeners(); 

    //Armar la ruta para la petición
    final url  = Uri.https(_baseURL, 'Products.json');
    //Hacer la petición.
    final resp = await http.get(url);
    //La respuesta que regresa viene como un String (el body de la respuesta). Se debe convertir la respuesta.body en
    //un mapa de nuestros productos.

    //json.decode viene del paquete dart:convert y nos ayuda a convetir la respuesta json en un Map
    final Map<String, dynamic> productsMap = json.decode(resp.body);
    
    //Agregar al listado products
    productsMap.forEach((key, value) {
      //En este caso el key -> es el prouctoid y el value son las propiedades available,name, picture, price
      //recibe un map y lo convierte en un objeto de Product
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct); //agregar al listado

    });

     //termino de cargar por lo tanto cambiar a false 
     this.isLoading = false;
     notifyListeners(); 

    return this.products;

  } 
  
}