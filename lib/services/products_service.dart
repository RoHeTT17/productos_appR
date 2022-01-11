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

  //para saber si esta guardando
  bool isSaving = false;

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

  Future saveOrCreateProduct (Product product) async{

    isSaving = true;
    notifyListeners();


     if (product.id == null){
        //Insert
         await createProduct(product);
     }else{
        //si el producto ya tiene un ID, es un update
         await updateProduct(product);
     }
    
    isSaving = false;
    notifyListeners();

  } 
  
  Future<String?> updateProduct (Product product) async{
    //Armar la ruta para la petición
    final url  = Uri.https(_baseURL, 'Products/${product.id}.json');
    //Hacer la petición de actualizar (put).
    final resp = await http.put(url,body: product.toJson());
    //respuesta de la petición
    final decodeData = resp.body;
    
    //Así lo hice yo
    /*products.forEach((element) {
      
      if(element.id == product.id) {
         element.name      = product.name;
         element.price     = product.price;
         element.available = product.available;
      }
    });*/

    //Así se hizo en el curso
    //1. Obtiene el indice en base al ID
    final index = this.products.indexWhere((element) => element.id == product.id);
    //Actualizar el listado
    this.products[index] = product;

    return product.id;

  }

    Future<String?> createProduct (Product product) async{
    //Armar la ruta para la petición
    final url  = Uri.https(_baseURL, 'Products.json');
    //Hacer la petición de crear (post).
    final resp = await http.post(url,body: product.toJson());
    //convertir la respuesta de la petición a un Map
    final decodeData = json.decode( resp.body);
    
    //asignar el ID al producto. La propiedad name, la retorna firebase, es el ID que genera
    product.id = decodeData['name'];

    //agregar a los productos
    products.add(product);

    return product.id;

  }

}