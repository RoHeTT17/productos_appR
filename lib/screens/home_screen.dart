import 'package:flutter/material.dart';
import 'package:productosapp_as/screens/screens.dart';
import 'package:provider/provider.dart';

import 'package:productosapp_as/services/services.dart';
import 'package:productosapp_as/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Solo se lee el products service porque ya esta declarado el provider de forma global
    final productsService = Provider.of<ProductsService>(context);

    //Si esta cargando mostrar un un circularprogress en toda la pantalla
    if(productsService.isLoading) {
        return LoadingScreen();
    } else {
        //una vez que termina de cargar se muestra esto
        return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Productos'),
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
          onPressed: () {  },
          
        ),  
      );
    }
  }
}