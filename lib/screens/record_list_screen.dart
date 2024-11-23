import 'package:flutter/material.dart';

class RecordListScreen extends StatelessWidget {
  const RecordListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final List<Map<String, dynamic>> records = List.generate(
      20,
      (index) => {
        'id': index,
        'title': 'Registro $index',
        'description': 'Descripción del registro $index',
        'image': 'https://via.placeholder.com/150',
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Registros'),
      ),
      body: ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          final record = records[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'record_details', arguments: record);
            },
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Image.asset(
                    'images/placeholder.png',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 50);
                    },
                    ),
                title: Text(record['title']),
                subtitle: Text(record['description']),
              ),
            ),
          );
        },
      ),
    );
  }
}
