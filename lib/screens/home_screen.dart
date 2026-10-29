import 'package:flutter/material.dart';

import '../models/receta.dart';
import '../services/recipe_service.dart';
import '../widgets/receta_card.dart';
import 'detalle_receta_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RecipeService _recipeService = RecipeService();
  late Future<List<Receta>> _recetasFuture;

  @override
  void initState() {
    super.initState();
    _recetasFuture = _recipeService.fetchRecetas();
  }

  void _reloadRecetas() {
    setState(() {
      _recetasFuture = _recipeService.fetchRecetas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<List<Receta>>(
        future: _recetasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off, size: 48),
                    const SizedBox(height: 12),
                    const Text(
                      'No se pudieron cargar las recetas. Revisa tu conexión '
                      'a internet e inténtalo de nuevo.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: _reloadRecetas,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            );
          }

          final recetas = snapshot.data ?? const <Receta>[];
          if (recetas.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No hay recetas disponibles.'),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: _reloadRecetas,
                    child: const Text('Volver a cargar'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: recetas.length,
            itemBuilder: (context, index) {
              final receta = recetas[index];
              return RecetaCard(
                receta: receta,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) =>
                          DetalleRecetaScreen(receta: receta),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
