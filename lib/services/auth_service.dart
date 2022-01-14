import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier{

//https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA4S8vqCdp6JoIIQjTwr3tc3YaWzjuvl84

  final String _baseURL = 'identitytoolkit.googleapis.com';

 //Es el token de acceso al API de Firebase, no el del USuario
  final String _firebaseToken = 'AIzaSyA4S8vqCdp6JoIIQjTwr3tc3YaWzjuvl84';

  //para grabar el token en el secureStorage
  final storage = new FlutterSecureStorage();

  //Si regresa null significa que todo esta bien. Sino regresa el mensaje del error
  Future<String?> createUser ( String email, String password) async{

    //Para mandar información en un POST debe ser con MAP
    final Map<String, dynamic> authData = {
      //Son los datos como los pide el API de firebase
      'email' : email,
      'password' : password,
    };

    //crear petición
    final url = Uri.https(_baseURL, '/v1/accounts:signUp', {
      //Parámetros del header
      'key': _firebaseToken  
    });

    //Mandar la petición. Convierte el MAP a un JsonString
    final resp = await http.post(url,body: json.encode(authData));

    //Recibe la respuesta. Convierte en JsonString a un MAP
    final Map<String,dynamic> decodeRespuesta = json.decode(resp.body);

    if(decodeRespuesta.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodeRespuesta['idToken']);
      return null;
    } else {
      return decodeRespuesta['error']['message'];
    } 
  }

  //Si regresa null significa que todo esta bien. Sino regresa el mensaje del error
  Future<String?> login ( String email, String password) async{

    //Para mandar información en un POST debe ser con MAP
    final Map<String, dynamic> authData = {
      //Son los datos como los pide el API de firebase
      'email' : email,
      'password' : password,
    };

    //crear petición
    final url = Uri.https(_baseURL, '/v1/accounts:signInWithPassword', {
      //Parámetros del header
      'key': _firebaseToken  
    });

    //Mandar la petición. Convierte el MAP a un JsonString
    final resp = await http.post(url,body: json.encode(authData));

    //Recibe la respuesta. Convierte en JsonString a un MAP
    final Map<String,dynamic> decodeRespuesta = json.decode(resp.body);

     /*print(decodeRespuesta);

     return 'error';*/ 
    if(decodeRespuesta.containsKey('idToken')) {
      //Guardar el idToken en el SecureStorage
       await storage.write(key: 'token', value: decodeRespuesta['idToken']);
       return null;
    } else {
       return decodeRespuesta['error']['message'];
    }

  }

   Future logout() async{
     await storage.delete(key: 'token');
     return;
   } 

}