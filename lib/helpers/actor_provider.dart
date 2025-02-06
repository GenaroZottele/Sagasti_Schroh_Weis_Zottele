import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ActorProvider with ChangeNotifier {
  List<Map<String, dynamic>> _actores = [];

  List<Map<String, dynamic>> get actores => _actores;

  Future<void> cargarActores() async {
    const String apiKey = "dec7662b257ce2fef06238a60917a4da";
    const String baseUrl = "https://api.themoviedb.org/3/person/popular?api_key=$apiKey";

    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _actores = (data["results"] as List).map((actor) {
          final movies = actor['known_for'] != null
              ? (actor['known_for'] as List)
                  .map((movie) => movie['original_title'] ?? 'Título Desconocido')
                  .toList()
              : ['Sin información']; // 🔹 Evita null en movies

          return {
            'id': actor['id'] ?? 0,
            'name': actor['name'] ?? 'Sin Nombre',
            'profile_path': actor['profile_path'] != null
                ? 'https://image.tmdb.org/t/p/w500${actor['profile_path']}'
                : 'assets/actores/default.jpg',
            'popularity': actor['popularity'] != null
                ? double.tryParse(actor['popularity'].toString())?.toStringAsFixed(1) ?? 'Desconocida'
                : 'Desconocida',
            'category': actor['known_for_department'] ?? 'Desconocido',
            'isFavorite': false,
            'movies': movies,
          };
        }).toList();

        notifyListeners();
      } else {
        throw Exception('Error al cargar actores desde TMDB: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error al cargar actores: $error');
    }
  }

  void updateActor(int index, Map<String, dynamic> updatedActor) {
    _actores[index] = updatedActor;
    notifyListeners();
  }

  void toggleFavorite(int index) {
    _actores[index]['isFavorite'] = !_actores[index]['isFavorite'];
    notifyListeners();
  }
}
