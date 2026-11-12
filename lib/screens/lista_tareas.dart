import 'package:eduwork/colores.dart';
import 'package:eduwork/models/tarea.dart';
import 'package:eduwork/screens/agregar_tarea.dart';
import 'package:eduwork/widgets/barra_inferior.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListaTareasScreen extends StatefulWidget {
  const ListaTareasScreen({super.key});

  @override
  State<ListaTareasScreen> createState() => _ListaTareasScreenState();
}

class _ListaTareasScreenState extends State<ListaTareasScreen> {
  static const _dias = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];
  static const _opcionesOrden = ['Materias', 'Título', 'Pendientes'];

  final _busquedaController = TextEditingController();
  String _busqueda = '';
  String _orden = 'Materias';

  final List<Tarea> _tareas = [
    Tarea(
      materia: 'Álgebra lineal',
      titulo: 'Estudiar álgebra lineal',
      color: const Color(0xFF3D8BFF),
      icono: Icons.calculate_outlined,
    ),
    Tarea(
      materia: 'Inglés',
      titulo: 'Repasar libro de inglés',
      color: const Color(0xFFFFCC00),
      icono: Icons.translate,
    ),
    Tarea(
      materia: 'Química',
      titulo: 'Terminar ejercicios química',
      color: const Color(0xFF38C95A),
      icono: Icons.science_outlined,
    ),
  ];

  @override
  void dispose() {
    _busquedaController.dispose();
    super.dispose();
  }

  List<Tarea> get _visibles {
    final q = _busqueda.toLowerCase();
    final lista = _tareas
        .where(
          (t) =>
              t.titulo.toLowerCase().contains(q) ||
              t.materia.toLowerCase().contains(q),
        )
        .toList();

    switch (_orden) {
      case 'Materias':
        lista.sort(
          (a, b) => a.materia.toLowerCase().compareTo(b.materia.toLowerCase()),
        );
      case 'Título':
        lista.sort(
          (a, b) => a.titulo.toLowerCase().compareTo(b.titulo.toLowerCase()),
        );
      case 'Pendientes':
        lista.sort(
          (a, b) => (a.completada ? 1 : 0).compareTo(b.completada ? 1 : 0),
        );
    }
    return lista;
  }

  Future<void> _agregar() async {
    final nueva = await AgregarTareaDialog.mostrar(context);
    if (nueva != null) {
      setState(() => _tareas.add(nueva));
    }
  }

  @override
  Widget build(BuildContext context) {
    final hoy = DateTime.now();
    final visibles = _visibles;
    final total = visibles.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'Lista de tareas',
                        style: GoogleFonts.chewy(
                          fontSize: 34,
                          color: Colores.verde,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _buscador(),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _filaOrden(),
                              const SizedBox(height: 14),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '${_dias[hoy.weekday - 1]} ${hoy.day}',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    '$total ${total == 1 ? 'tarea' : 'tareas'}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        _botonAgregar(),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: visibles.isEmpty
                          ? const Center(
                              child: Text(
                                'No hay tareas',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.only(bottom: 24),
                              itemCount: visibles.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 14),
                              itemBuilder: (_, i) {
                                final tarea = visibles[i];
                                return _TarjetaTarea(
                                  tarea: tarea,
                                  onToggle: () => setState(
                                    () => tarea.completada = !tarea.completada,
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
            const BarraInferior(),
          ],
        ),
      ),
    );
  }

  Widget _buscador() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAE4F1),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.black87),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: _busquedaController,
              onChanged: (v) => setState(() => _busqueda = v),
              decoration: const InputDecoration(
                hintText: 'Buscar',
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          const Icon(Icons.search, color: Colors.black87),
        ],
      ),
    );
  }

  Widget _filaOrden() {
    return Row(
      children: [
        const Text(
          'Ordenar por:',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 12),
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _orden,
            isDense: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            items: _opcionesOrden
                .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                .toList(),
            onChanged: (v) {
              if (v != null) setState(() => _orden = v);
            },
          ),
        ),
      ],
    );
  }

  Widget _botonAgregar() {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _agregar,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colores.verde,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
          shape: const StadiumBorder(),
        ),
        child: const Text(
          'Agregar',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _TarjetaTarea extends StatelessWidget {
  final Tarea tarea;
  final VoidCallback onToggle;

  const _TarjetaTarea({required this.tarea, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final completada = tarea.completada;
    final fondo = Color.lerp(tarea.color, Colors.white, 0.45)!;

    return Opacity(
      opacity: completada ? 0.65 : 1,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: fondo,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(tarea.icono, color: Colors.black87, size: 22),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  tarea.titulo,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    decoration: completada ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onToggle,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: completada ? Colores.verde : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.check,
                  size: 24,
                  color: completada ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
