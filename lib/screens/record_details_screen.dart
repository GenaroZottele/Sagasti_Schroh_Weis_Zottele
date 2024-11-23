import 'package:flutter/material.dart';

class RecordDetailsScreen extends StatelessWidget {
  const RecordDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final record = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(record['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
                'assets/images/placeholder.png',
                height: 150,
                width: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 50);
                },
                ),
            const SizedBox(height: 16),
            Text(
              record['title'],
              style: Theme.of(context).textTheme.titleLarge, // Cambiado
            ),
            const SizedBox(height: 8),
            Text(record['description']),
            const SizedBox(height: 16),
            const Text('Formulario:'),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              initialValue: record['title'],
            ),
            const SizedBox(height: 16),
            SwitchListTile.adaptive(
              title: const Text('Activo'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Favorito'),
              value: false,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}

