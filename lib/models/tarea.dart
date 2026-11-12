import 'package:flutter/material.dart';

class Tarea {
  final String materia;
  final String titulo;
  final String asunto;
  final Color color;
  final IconData icono;
  bool completada;

  Tarea({
    required this.materia,
    required this.titulo,
    required this.color,
    required this.icono,
    this.asunto = '',
    this.completada = false,
  });
}
