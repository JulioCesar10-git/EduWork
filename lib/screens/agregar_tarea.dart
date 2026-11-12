import 'package:eduwork/colores.dart';
import 'package:eduwork/models/tarea.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const List<Color> _paleta = [
  Color(0xFFFF3B3B),
  Color(0xFFFF8A2B),
  Color(0xFFFFCC00),
  Color(0xFF00CBB0),
  Color(0xFF00C2D1),
  Color(0xFF00C0E8),
  Color(0xFF6554F5),
  Color(0xFFC932E0),
  Color(0xFFFF2D55),
];

const List<IconData> _iconos = [
  Icons.calculate_outlined,
  Icons.translate,
  Icons.science_outlined,
  Icons.menu_book_outlined,
  Icons.public,
  Icons.computer,
  Icons.palette_outlined,
  Icons.music_note_outlined,
  Icons.sports_soccer_outlined,
  Icons.history_edu_outlined,
  Icons.biotech_outlined,
  Icons.functions,
];

/// Uso: final tarea = await AgregarTareaDialog.mostrar(context);
class AgregarTareaDialog extends StatefulWidget {
  const AgregarTareaDialog({super.key});

  static Future<Tarea?> mostrar(BuildContext context) {
    return showDialog<Tarea>(
      context: context,
      builder: (_) => const AgregarTareaDialog(),
    );
  }

  @override
  State<AgregarTareaDialog> createState() => _AgregarTareaDialogState();
}

class _AgregarTareaDialogState extends State<AgregarTareaDialog> {
  final _materiaController = TextEditingController();
  final _tituloController = TextEditingController();
  final _asuntoController = TextEditingController();

  Color _color = _paleta[0];
  IconData _icono = Icons.menu_book_outlined;

  @override
  void dispose() {
    _materiaController.dispose();
    _tituloController.dispose();
    _asuntoController.dispose();
    super.dispose();
  }

  void _agregar() {
    final materia = _materiaController.text.trim();
    final titulo = _tituloController.text.trim();

    if (materia.isEmpty || titulo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escribe la materia y el título')),
      );
      return;
    }

    Navigator.pop(
      context,
      Tarea(
        materia: materia,
        titulo: titulo,
        asunto: _asuntoController.text.trim(),
        color: _color,
        icono: _icono,
      ),
    );
  }

  Future<void> _elegirColorYSimbolo() {
    return showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialog) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            insetPadding: const EdgeInsets.symmetric(horizontal: 48),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Elección de color y símbolo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          children: _paleta.map((c) {
                            final seleccionado = c == _color;
                            return GestureDetector(
                              onTap: () {
                                setState(() => _color = c);
                                setDialog(() {});
                              },
                              child: Center(
                                child: Container(
                                  width: 46,
                                  height: 46,
                                  decoration: BoxDecoration(
                                    color: c,
                                    shape: BoxShape.circle,
                                    border: seleccionado
                                        ? Border.all(
                                            color: Colors.blue,
                                            width: 3,
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 14),
                        ElevatedButton(
                          onPressed: _elegirSimbolo,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            elevation: 3,
                            shape: const StadiumBorder(),
                            side: const BorderSide(color: Colors.black12),
                          ),
                          child: const Text(
                            'Escoger símbolo o emoji',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _elegirSimbolo() {
    return showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: _iconos.map((i) {
              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  setState(() => _icono = i);
                  Navigator.pop(ctx);
                },
                child: Icon(i, size: 30, color: Colores.verdeOscuro),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colores.verde,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 6,
                offset: const Offset(3, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    'Agregar tarea',
                    style: GoogleFonts.chewy(fontSize: 26, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _campo('Materia:', _materiaController),
                    const SizedBox(height: 16),
                    _campo('Titulo:', _tituloController),
                    const SizedBox(height: 16),
                    const Text(
                      'Asunto:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 200,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colores.gris,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextField(
                        controller: _asuntoController,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: _elegirColorYSimbolo,
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: _color,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(_icono, color: Colors.white, size: 22),
                    ),
                  ),
                  const SizedBox(width: 14),
                  ElevatedButton(
                    onPressed: _agregar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 4,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: const StadiumBorder(),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Agregar',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.add, size: 22),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _campo(String etiqueta, TextEditingController controller) {
    const linea = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          etiqueta,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            border: linea,
            enabledBorder: linea,
            focusedBorder: linea,
          ),
        ),
      ],
    );
  }
}
