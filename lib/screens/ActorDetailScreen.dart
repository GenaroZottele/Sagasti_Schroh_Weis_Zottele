import 'package:flutter/material.dart';

class ActorDetailScreen extends StatefulWidget {
  const ActorDetailScreen({Key? key}) : super(key: key);

  @override
  State<ActorDetailScreen> createState() => _ActorDetailScreenState();
}

class _ActorDetailScreenState extends State<ActorDetailScreen> {
  late Map<String, dynamic> actor;
  late TextEditingController descriptionController;
  late bool isFavorite; // Estado temporal del switch

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    actor = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    descriptionController = TextEditingController(text: actor['description']);
    isFavorite = actor['isFavorite']; // Inicializamos con el estado actual del actor
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(actor['name'] ?? 'Sin Nombre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(actor['image'] ?? 'assets/images/default.png'),
                radius: 50,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Descripción del Actor',
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Favorito'),
              value: isFavorite, // Usamos la variable local
              onChanged: (value) {
                setState(() {
                  isFavorite = value; // Cambiamos el valor temporal
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  actor['description'] = descriptionController.text;
                  actor['isFavorite'] = isFavorite; // Actualizamos el actor solo al guardar
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cambios guardados')),
                );
                Navigator.pop(context, actor); // Devuelve el actor actualizado
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }
}
