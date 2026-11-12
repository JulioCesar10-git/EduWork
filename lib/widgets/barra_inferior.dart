import 'package:eduwork/colores.dart';
import 'package:flutter/material.dart';

class BarraInferior extends StatelessWidget {
  final VoidCallback? onGrupos;
  final VoidCallback? onNotas;
  final VoidCallback? onCalendario;
  final VoidCallback? onTareas;

  const BarraInferior({
    super.key,
    this.onGrupos,
    this.onNotas,
    this.onCalendario,
    this.onTareas,
  });

  @override
  Widget build(BuildContext context) {
    final inset = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: 96 + inset,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 72 + inset,
            child: Container(
              color: Colores.verde,
              padding: EdgeInsets.only(bottom: inset, right: 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ItemBarra(
                    icono: Icons.people_outline,
                    texto: 'Grupos',
                    onTap: onGrupos,
                  ),
                  _ItemBarra(
                    icono: Icons.note_add_outlined,
                    texto: 'Notas',
                    onTap: onNotas,
                  ),
                  _ItemBarra(
                    icono: Icons.calendar_month_outlined,
                    texto: 'Calendario',
                    onTap: onCalendario,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 0,
            child: GestureDetector(
              onTap: onTareas,
              child: Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: Colores.verde,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.checklist_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemBarra extends StatelessWidget {
  final IconData icono;
  final String texto;
  final VoidCallback? onTap;

  const _ItemBarra({required this.icono, required this.texto, this.onTap});

  @override
  Widget build(BuildContext contetx) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icono, color: Colors.white, size: 30),
            const SizedBox(height: 2),
            Text(
              texto,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
