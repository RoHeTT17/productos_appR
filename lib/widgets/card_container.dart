import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {

  final Widget childCardContainer;

  const CardContainer({Key? key, required this.childCardContainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        width:  double.infinity,
        //height: 300,
        padding: EdgeInsets.all(20), // para que el contenido no quede pegado a los bordes
        decoration: _createCardShape(),
        child: this.childCardContainer,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12, //color o intensidad e la sombra
        blurRadius:  15, // cuando queremos que se expanda
        offset: Offset(0,5) // en donde se unica la sombra
      )
    ]
  );
}
