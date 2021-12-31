import 'package:flutter/material.dart';
import 'package:productosapp_as/ui/input_decorations.dart';
import 'package:productosapp_as/widgets/widgets.dart';


class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                const ProductImage(),
                Positioned(child: 
                            IconButton(icon: const Icon(Icons.arrow_back_ios_new, size: 40, color: Colors.white,),
                            onPressed: ()=> Navigator.of(context).pop(),),
                            top: 60,left: 20,),
                Positioned(child: 
                            IconButton(icon: const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white,),
                            onPressed: (){
                              //TODO: Camara o galería
                            }),
                            top: 60,right: 20,),                            
              ],
            ),
            const _ProductForm(),
            const SizedBox(height: 100,)
          ],
        ),
      ),
     floatingActionButton: FloatingActionButton(
       child: const Icon(Icons.save_outlined),
       onPressed: (){},
     ), 
     floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
   );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({  Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        //height: 200,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecorations.authInputDecorations(
                  pHintText:  'Nombre del producto', 
                  pLabelText: 'Nombre:'),

              ),
              const SizedBox(height: 30,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecorations(
                  pHintText:  '\$150', 
                  pLabelText: 'Precio:'),

              ),              
              const SizedBox(height: 30,),
              SwitchListTile.adaptive(
                title: const Text('Disponible'),
                activeColor: Colors.indigo,
                value: true, 
                onChanged: (value){

                }),

              const SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0,5),
        blurRadius: 5
      )
    ]
  );
}