import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productosapp_as/screens/screens.dart';
import 'package:productosapp_as/services/services.dart';


void main() => runApp(const AppState());


class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( context ) => AuthService()),
        ChangeNotifierProvider(create: ( context ) => ProductsService()),
    ],
    child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'login',//'login',
      routes: {
        'login'    : ( _ ) => const LoginScreen(),
        'home'     : ( _ ) => const HomeScreen(),
        'product'  : ( _ ) => const ProductScreen(),
        'register'  : ( _ ) => const RegisterScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        //Modificar Appbar de manera global
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo
        ),
        //Modificar de forma global el FloatingActionButton
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0
        )
      ),
    );
  }
}