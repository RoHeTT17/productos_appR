import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {

  final String? urlImage;

  const ProductImage({Key? key, this.urlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: _buildBoxDecoration(),
        child: Opacity(
          opacity: 0.9,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topRight: Radius.circular(45),topLeft: Radius.circular(45)),
            child: urlImage == null
                  ? const Image(
                    image: AssetImage('assets/no-image.png'),
                    fit: BoxFit.cover,
                    )
                  : FadeInImage(
                      placeholder: const AssetImage('assets/jar-loading.gif'),
                      //image: NetworkImage('https://via.placeholder.com/400x300/green'),
                      image: NetworkImage(urlImage!),
                      fit: BoxFit.cover,
                    ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.black26,
    borderRadius: const BorderRadius.only(topRight: Radius.circular(45),topLeft: Radius.circular(45)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0,5),
      )
    ]
  );
}