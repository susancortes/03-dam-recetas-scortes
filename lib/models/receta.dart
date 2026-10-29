class Receta {
  const Receta({
    required this.id,
    required this.nombre,
    required this.ingredientes,
    required this.instrucciones,
    required this.tiempoPreparacion,
    required this.tiempoCoccion,
    required this.porciones,
    required this.calorias,
    required this.imagenUrl,
    required this.calificacion,
    required this.cocina,
    required this.dificultad,
  });

  factory Receta.fromJson(Map<String, dynamic> json) {
    return Receta(
      id: json['id'] as int,
      nombre: (json['name'] ?? json['nombre']) as String,
      ingredientes: List<String>.from(json['ingredients'] as List),
      instrucciones: List<String>.from(json['instructions'] as List),
      tiempoPreparacion:
          (json['prepTimeMinutes'] ?? json['tiempoPreparacion']) as int,
      tiempoCoccion:
          (json['cookTimeMinutes'] ??
                  json['cookMinutes'] ??
                  json['tiempoCoccion'])
              as int,
      porciones: (json['servings'] ?? json['porciones']) as int,
      calorias: (json['caloriesPerServing'] ?? json['calorias']) as int,
      imagenUrl: (json['image'] ?? json['imagenUrl']) as String,
      calificacion: (json['rating'] as num).toDouble(),
      cocina: (json['cuisine'] ?? json['cocina']) as String,
      dificultad: (json['difficulty'] ?? json['dificultad']) as String,
    );
  }

  final int id;
  final String nombre;
  final List<String> ingredientes;
  final List<String> instrucciones;
  final int tiempoPreparacion;
  final int tiempoCoccion;
  final int porciones;
  final int calorias;
  final String imagenUrl;
  final double calificacion;
  final String cocina;
  final String dificultad;

  int get tiempoTotal => tiempoPreparacion + tiempoCoccion;
}
