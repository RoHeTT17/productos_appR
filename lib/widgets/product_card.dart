import 'package:flutter/material.dart';
import 'package:productosapp_as/models/models.dart';

class ProductCard extends StatelessWidget {

  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20.0),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width:  double.infinity,
        height: 400.0,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children:  [
            _BackgroundImage( urlImage: product.picture,),
            _ProductDetails(idProduct: product.id, nameProduc: product.name,),
            Positioned(child: _PriceTag(priceProduct: product.price,),top: 0,right: 0,),
           
            if (product.available)
               Positioned(child: _NotAvailable(productDisponible: product.available,),top: 0,left: 0,),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color:  Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const[
       BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0,7)
      )
    ]  
  );
}

class _BackgroundImage extends StatelessWidget {
  
  final String ?urlImage;
  const _BackgroundImage({
    Key? key, this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width:  double.infinity,
        height: 400.0,
        child: urlImage == null
               ? const Image(
                    image: AssetImage('assets/no-image.png'),
                    fit: BoxFit.cover,
                 )
               : FadeInImage(
                  placeholder: const AssetImage('assets/jar-loading.gif'),
                  //image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
                  image: NetworkImage(urlImage!),
                  fit: BoxFit.cover,
                ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {

  final String nameProduc;
    final String ?idProduct;

  const _ProductDetails({ Key? key, required this.nameProduc, this.idProduct,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        width:   double.infinity,
        height:  70.0,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.nameProduc,
               style: const TextStyle( fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
               maxLines: 1,
               overflow: TextOverflow.ellipsis,
              ),
            Text(
              this.idProduct ?? '',
               style: const TextStyle( fontSize: 15, color: Colors.white,),
               maxLines: 1,
               overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
        color:   Colors.indigo,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
  );
}

class _PriceTag extends StatelessWidget {

  final double priceProduct;

  const _PriceTag({Key? key, required this.priceProduct,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      child:  FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('\$ $priceProduct', style: const TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),

      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25),bottomLeft: Radius.circular(25))
      ),
    );
  }
}

class _NotAvailable extends StatelessWidget {

  final bool productDisponible;

  const _NotAvailable({ Key? key, required this.productDisponible,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      child:  FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            
            productDisponible 
            ? 'Disponible'
            : 'No disponible', 
            style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
        ),
      ),

      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25),bottomRight: Radius.circular(25))
      ),
    );
  }
}

