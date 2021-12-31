import 'package:flutter/material.dart';
import 'package:productosapp_as/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: const ProductCard(),
          onTap: () => Navigator.pushNamed(context, 'product'),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        
        child: const Icon(Icons.add),
        onPressed: () {  },
        
      ),  
    );
  }
}