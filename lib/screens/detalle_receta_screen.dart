import 'package:flutter/material.dart';

import '../models/receta.dart';

class DetalleRecetaScreen extends StatefulWidget {
  final Receta receta;

  const DetalleRecetaScreen({super.key, required this.receta});


  @override
  State<DetalleRecetaScreen> createState() => _DetalleRecetaScreenState();
}

class _DetalleRecetaScreenState extends State<DetalleRecetaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _comentarioController = TextEditingController();
  final List<_Resena> _resenas = [];
  int _calificacionSeleccionada = 0;

  @override
  void dispose() {
    _nombreController.dispose();
    _comentarioController.dispose();
    super.dispose();
  }

  void _agregarResena() {
    if (!_formKey.currentState!.validate()) return;

    if (_calificacionSeleccionada == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona una calificación.')),
      );
      return;
    }

    setState(() {
      _resenas.insert(
        0,
        _Resena(
          nombre: _nombreController.text.trim(),
          comentario: _comentarioController.text.trim(),
          calificacion: _calificacionSeleccionada,
        ),
      );
      _nombreController.clear();
      _comentarioController.clear();
      _calificacionSeleccionada = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final receta = widget.receta;
    return Scaffold(
      appBar: AppBar(title: Text("Detalle de la receta")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(14),
            child: Image.network(
              receta.imagenUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) => Image.asset(
                'assets/images/placeholder.png',
                height: 200,
                fit: BoxFit.cover,
                ),
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 10,
            children: [
              Chip(label: Text('${receta.tiempoTotal} min')),
              Chip(label: Text(receta.dificultad)),
              Chip(label: Text(receta.cocina)),
              Chip(label: Text('${receta.calorias} kcal')),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Ingredientes: ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...receta.ingredientes.map(
            (ingrediente) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 6,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(height: 8,),
                  Expanded(child: Text(ingrediente)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Preparación', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          const SizedBox(height: 8),
          ...receta.instrucciones.asMap().entries.map(
            (entrada) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      '${entrada.key + 1}',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(entrada.value)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Reseñas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tu calificación'),
                Row(
                  children: List.generate(
                    5,
                    (index) => IconButton(
                      tooltip: '${index + 1} estrellas',
                      onPressed: () {
                        setState(() => _calificacionSeleccionada = index + 1);
                      },
                      icon: Icon(
                        index < _calificacionSeleccionada
                            ? Icons.star
                            : Icons.star_border,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Tu nombre',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Escribe tu nombre.'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _comentarioController,
                  decoration: const InputDecoration(
                    labelText: 'Escribe tu reseña',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Escribe un comentario.'
                      : null,
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: _agregarResena,
                  icon: const Icon(Icons.send),
                  label: const Text('Agregar reseña'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (_resenas.isEmpty)
            const Text('Aún no hay reseñas. ¡Sé la primera persona en opinar!')
          else
            ..._resenas.map(
              (resena) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resena.nombre,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < resena.calificacion
                                ? Icons.star
                                : Icons.star_border,
                            color: Theme.of(context).colorScheme.tertiary,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(resena.comentario),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Resena {
  const _Resena({
    required this.nombre,
    required this.comentario,
    required this.calificacion,
  });

  final String nombre;
  final String comentario;
  final int calificacion;
}