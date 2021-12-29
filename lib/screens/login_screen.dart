import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productosapp_as/providers/login_form_provider.dart';
import 'package:productosapp_as/ui/input_decorations.dart';
import 'package:productosapp_as/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        childAuthB: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 170,), //250 para la tablet
              CardContainer(
                childCardContainer: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text('Login',style: Theme.of(context).textTheme.headline4,),
                    const SizedBox(height: 30,),

                     //Solo se declara a este nivel el provider porque solo se usará para el login
                     ChangeNotifierProvider(
                         create: ( _ ) => LoginFormProvider(),
                         child: _LoginForm(),
                     ),
                  ],
                )
              ),
              const SizedBox(height: 25.0,), //50 para la tablet
              const Text('Crear una cuenta',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
              const SizedBox(height: 25.0,),
            ],

          ),
        )
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Primero se declaro el ChangeNotifierProvider donde esta el LoginFormProvider (arriba)
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        //es el que esta el login_form_provider, con esto ya esta asociado para disparar las valdiaciones
        key:loginForm.formKey ,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              //Cambiar el color del border del textfield
              decoration:InputDecorations.authInputDecorations(
                pHintText:   'Ej: jhoin@gmail.com',
                pLabelText:  'Correo electrónico',
                pPrefixIcon: Icons.alternate_email_rounded
              ),
              //Asignar valor a la propiedad de la clase login_form_provider, para que se pueda utilizar en aquella clase
              onChanged: (value) => loginForm.email = value,
              validator: (value) {

                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                RegExp regExp  = new RegExp(pattern);
                
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Formato de correo invalido';

                
              },
            ),
            const SizedBox(height: 30,),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              //Cambiar el color del border del textfield
              decoration:InputDecorations.authInputDecorations(
                  pHintText:   '******',
                  pLabelText:  'Contraseña',
                  pPrefixIcon: Icons.lock_clock_outlined
              ),
              //Asignar valor a la propiedad de la clase login_form_provider, para que se pueda utilizar en aquella clase
              onChanged: (value) => loginForm.password = value,
              validator: (value) {

                if(value!=null && value.length>=6) {
                  return null;
                } else {
                  return 'La contraseña debe ser de 6 caracteres';
                }

              },
            ),
            const SizedBox(height: 30,),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.getIsLoading
                  ? 'Espere'
                  : 'Ingresar',
                  style: TextStyle(color: Colors.white),),
              ),
              //Si es true, pone null para desactivar el botoón, en caso contrario ejecuta el bloque de código.
              onPressed:loginForm.getIsLoading ? null :() async{

                //Ocultar el tecledo
                FocusScope.of(context).unfocus();

                if(loginForm.isValidForm()) {

                  loginForm.setIsLoadind = true;

                  await Future.delayed(const Duration(seconds: 2 ));

                  //TODO: valdiar si los datos son correctos

                  //Regresar a false
                  loginForm.setIsLoadind = false;
                  
                  Navigator.pushReplacementNamed(context, 'home');
                }

              }
            )
          ],
        ),
      ),
    );
  }
}
