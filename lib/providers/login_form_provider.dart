import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{

  //Se va a utilizar para en lazar este provider al login_screen (Form)
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  //Estos se utilizan para recibir el valor que tienen las cajas.
  String email    = '';
  String password = '';

  bool _isLoading = false;
  bool get getIsLoading => _isLoading;
  set setIsLoadind (bool value){
    _isLoading = value;
    notifyListeners(); //ara redibujar ( va a desactivar el botón)
  }

  bool isValidForm(){

    //Solo tiene el true porque los errores ya se muestran en los texfield por el validator
    //currentState? puede ser que aun no esta asociado al form y sea null, en ese caso regresa false.
    return formKey.currentState?.validate() ?? false;
  }

}