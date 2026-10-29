import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/receta.dart';

class RecipeService {
  static final Uri _recipesUri = Uri.parse('https://dummyjson.com/recipes');

  Future<List<Receta>> fetchRecetas() async {
    final response = await http.get(_recipesUri);
    if (response.statusCode != 200) {
      throw Exception(
        'El servidor respondió con el código ${response.statusCode}.',
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final recipes = data['recipes'] as List<dynamic>;
    return recipes
        .map((recipe) => Receta.fromJson(recipe as Map<String, dynamic>))
        .toList();
  }
}
