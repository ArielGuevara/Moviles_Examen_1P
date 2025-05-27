import 'package:examenp1/views/resumen_cliente_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examenp1/views/detalle_cliente_view.dart';
import 'package:examenp1/controller/bancoController.dart';
import 'package:examenp1/views/welcome.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BancoController(),
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      routes: {
        '/welcome': (context) => WelcomePage()
      }
    );
  }
}
