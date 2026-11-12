//import 'package:eduwork/screens/inicio_sesion.dart';
import 'package:eduwork/screens/lista_tareas.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proyecto 1',
      home: ListaTareasScreen(),
    );
  }
}
