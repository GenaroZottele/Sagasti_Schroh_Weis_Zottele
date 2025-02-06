import 'package:flutter/material.dart';

class ActorDetailScreen extends StatefulWidget {
  @override
  _ActorDetailScreenState createState() => _ActorDetailScreenState();
}

class _ActorDetailScreenState extends State<ActorDetailScreen> {
  late Map<String, dynamic> actor;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    actor = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _descriptionController.text = actor['description'] ?? '';
  }

  void toggleFavorite() {
    setState(() {
      actor['isFavorite'] = !(actor['isFavorite'] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(actor['name'] ?? 'Sin Nombre')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: actor['profile_path'] != null && actor['profile_path'].startsWith('http')
                  ? NetworkImage(actor['profile_path'])
                  : const AssetImage('assets/actores/default.jpg') as ImageProvider,
            ),
            const SizedBox(height: 20),
            Text(
              actor['name'] ?? 'Sin Nombre',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            IconButton(
              icon: Icon(
                (actor['isFavorite'] ?? false) ? Icons.star : Icons.star_border,
                color: (actor['isFavorite'] ?? false) ? Colors.yellow : null,
              ),
              onPressed: toggleFavorite,
            ),
            const SizedBox(height: 8),
            Text(
              'Departamento: ${actor['category'] ?? "Desconocido"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Popularidad: ${actor['popularity'] ?? "Desconocida"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Películas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            
            Expanded(
              child: ListView.builder(
                itemCount: actor['movies']?.length ?? 0,
                itemBuilder: (context, index) {
                  final movieTitle = actor['movies'][index] != 'Título Desconocido' 
                      ? actor['movies'][index] 
                      : 'Sin título disponible';
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0), 
                    child: Text(
                      '• $movieTitle',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
            const Text(
              'Descripción personal:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'Escribe una descripción...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  actor['description'] = _descriptionController.text;
                  Navigator.pop(context, actor);
                },
                child: const Text('Guardar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
