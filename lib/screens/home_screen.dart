import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productosapp_as/models/models.dart';
import 'package:productosapp_as/screens/screens.dart';

import 'package:productosapp_as/services/services.dart';
import 'package:productosapp_as/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Solo se lee el products service porque ya esta declarado el provider de forma global
    final productsService = Provider.of<ProductsService>(context);

    //Service para la autentificación 
    final authService = Provider.of<AuthService>(context, listen: false);

    //Si esta cargando mostrar un un circularprogress en toda la pantalla
    if(productsService.isLoading) {
        return const LoadingScreen();
    } else {
        //una vez que termina de cargar se muestra esto
        return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Productos'),
          actions: [IconButton(
            icon: const Icon(Icons.login_outlined),
            onPressed: (){
               authService.logout(); 
               Navigator.pushReplacementNamed(context, 'login');
          },
          )],
        ),
        body: ListView.builder(
          itemCount: productsService.products.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            child: ProductCard(
              product: productsService.products[index],
              
            ),
            onTap: (){
              //Romper el paso por referencia del objeto, para eso se crea una copia del mismo, y los cambios
              // se hagan en la copia.
              productsService.selectedProduct = productsService.products[index].copy();
              Navigator.pushNamed(context, 'product');
            } 
            ),
          ),
        floatingActionButton: FloatingActionButton(
          
          child: const Icon(Icons.add),
          onPressed: () {  

            productsService.selectedProduct = new Product(available: false, name: '', price: 0.0);

            Navigator.pushNamed(context, 'product');
          },
          
        ),  
      );
    }
  }
}