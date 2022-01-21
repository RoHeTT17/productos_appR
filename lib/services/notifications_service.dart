import 'package:flutter/material.dart';

class NotificationsService{
 //Esta no lleva changeNotifier porque no necesita redibujar nada.
 //ScaffoldMessengerState Se utiliza para mantener la referencia con el MaterialApp
 static  GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();

 static showSnackBar(String message){

   final snackBar = new SnackBar(
     content: Text(message,style: const TextStyle(color: Colors.white, fontSize: 20),)
     );

   messengerKey.currentState!.showSnackBar(snackBar);

 }


}