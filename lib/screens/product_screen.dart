import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productosapp_as/providers/product_form_provider.dart';
import 'package:provider/provider.dart';

import 'package:productosapp_as/services/services.dart';
import 'package:productosapp_as/ui/input_decorations.dart';
import 'package:productosapp_as/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductsService>(context);

    /*El ChangeNotifierProvider, se declara a este nivel, proque realmente solo interesa que exista en esta pantalla,
      ya que solo aquí se utiliza. Y a este nivel porque también se usará el evento del botón de la camara y esta fuera
      del _ProductForm (que también utiliza el provider).
      Se pone el productService.selectedProduct, ya que el onTap del HomeScreen es donde se hace la copía. Esta 
      garantizado que siempre tendra un valor*/
    return ChangeNotifierProvider(
      //se manda como parámetro el objeto copia del Product
      create: (context) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService),
      );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({Key? key,    required this.productService,}) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {


    //crear refrerencia al provider, para poder utilizarlo en el botón de guardar
    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [

                //En el momento del onTap (en home screen), se creo la copía por eso se puede utilizar aquí.
                ProductImage( urlImage: productService.selectedProduct.picture, ),
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
       onPressed: ()async{
         if(!productForm.isValidForm()) {
           return;
         } else {
           await productService.saveOrCreateProduct(productForm.product);
         }
       },
     ), 
     floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
   );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({  Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    //obtener la instancia del provider
    final productFormProvider = Provider.of<ProductFormProvider>(context);
    //Obtener los datos del objeto (son los de la copia)
    //para que sea la copia se mando el parámetro al instanciar el ProductFormProvider en scope del ChangeNotifierProvider
    final productData = productFormProvider.product;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        //height: 200,
        decoration: _buildBoxDecoration(),
        child: Form(
          //Asociar el key para poder validar el estado del formulario
          key: productFormProvider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10,),
              TextFormField(
                initialValue: productData.name,
                decoration: InputDecorations.authInputDecorations(
                  pHintText:  'Nombre del producto', 
                  pLabelText: 'Nombre:'),
                //cambiar la propiedad name del producData
                //value es lo que esta colocando el usuario
                onChanged: (value) => productData.name = value,
                //Validar el campo
                validator: (value){
                  if (value == null || value.length<1) {
                    return 'El nombre es obligatorio';
                  }
                },

              ),
              const SizedBox(height: 30,),
              TextFormField(
                //$productData.price -- así muestra que es una instancia de de un producto.
                initialValue: '${productData.price}',
                inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecorations(
                  pHintText:  '\$150', 
                  pLabelText: 'Precio:'),
                //cambiar la propiedad price del producData
                onChanged: (value) {
                  //intentar parsear el valor
                  if(double.tryParse(value) ==null){
                    //no se puede parsear
                    productData.price = 0;
                  }else {
                    productData.price = double.parse(value);
                  }
                }             
              ), 
              const SizedBox(height: 30,),

              SwitchListTile.adaptive(
                
                title: const Text('Disponible'),
                activeColor: Colors.indigo,
                value: productData.available, 
                onChanged: productFormProvider.updateAvailability,
                /*onChanged: (value){
                      productFormProvider.updateAvailability(value);
                }*/
                ),

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