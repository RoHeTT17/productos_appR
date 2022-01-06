import 'package:flutter/material.dart';
import 'package:productosapp_as/models/models.dart';

class ProductFormProvider extends ChangeNotifier{

  //para validar el estado del formulario
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  //crear una instancia del objeto Product
  Product product;

  //Constructor de la clase. Debe recibir un objeto de ti Product. 
  //El objeto que se recibe dene ser una copia, para romper el paso por referencia.
  ProductFormProvider (this.product);


  updateAvailability(bool value){
    this.product.available = value;
    notifyListeners();
  }


  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

}