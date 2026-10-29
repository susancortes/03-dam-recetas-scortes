import 'package:flutter/material.dart';

import '../models/receta.dart';

class DetalleRecetaScreen extends StatelessWidget {
  const DetalleRecetaScreen({super.key, required this.receta});

  final Receta receta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receta.nombre)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              receta.imagenUrl,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 220,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.restaurant, size: 64),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            receta.nombre,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            '${receta.cocina} · ${receta.dificultad} · '
            '${receta.tiempoTotal} min · ${receta.calificacion} ★',
          ),
          const SizedBox(height: 20),
          Text('Ingredientes', style: Theme.of(context).textTheme.titleLarge),
          ...receta.ingredientes.map(
            (ingrediente) => ListTile(
              dense: true,
              leading: const Icon(Icons.check_circle_outline),
              title: Text(ingrediente),
            ),
          ),
          const SizedBox(height: 8),
          Text('Preparación', style: Theme.of(context).textTheme.titleLarge),
          ...receta.instrucciones.asMap().entries.map(
            (entry) => ListTile(
              leading: CircleAvatar(child: Text('${entry.key + 1}')),
              title: Text(entry.value),
            ),
          ),
        ],
      ),
    );
  }
}