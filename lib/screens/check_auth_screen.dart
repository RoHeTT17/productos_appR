import 'package:flutter/material.dart';
import 'package:productosapp_as/screens/screens.dart';
import 'package:productosapp_as/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Este no es necesario que se redibuje, por lo tanto se pone en false para que no "escuche" los cambios.
    final authService = Provider.of<AuthService>(context,listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.existToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            
            //Si no tiene Data
            if(!snapshot.hasData) {
              return const Text('Espere...');
            }

            if( snapshot.data == ''){
              //No hay Token
              Future.microtask((){
                //Navigator.of(context).pushReplacementNamed('home');
                //Agregar una navegación/transición manual
                Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: ( _ , __, ___) => const LoginScreen(),
                transitionDuration: const Duration(seconds: 0)
                ));
              });              
            }else{
              Future.microtask((){
                //Existe Token
                Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: ( _ , __, ___) => const HomeScreen(),
                transitionDuration: const Duration(seconds: 0)
                ));
              });     
            }

             return Container(); 

          },
        ),
      )
      );
  }
}