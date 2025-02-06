import 'package:flutter/material.dart';

class ActorCard extends StatelessWidget {
  final Map<String, dynamic> actor;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const ActorCard({
    Key? key,
    required this.actor,
    required this.onTap,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: actor['profile_path'] != null && actor['profile_path'].startsWith('http')
              ? NetworkImage(actor['profile_path']) // 🔹 Imagen desde API
              : AssetImage('assets/actores/default.jpg') as ImageProvider, // 🔹 Imagen local
          radius: 50,
        ),
        title: Text(actor['name'] ?? 'Sin Nombre'),
        subtitle: Text(
          '${actor['category']}, Popularidad: ${actor['popularity']}',
        ),
        trailing: IconButton(
          icon: Icon(
            (actor['isFavorite'] ?? false) ? Icons.star : Icons.star_border,
            color: (actor['isFavorite'] ?? false) ? Colors.amber : null,
          ),
          onPressed: onFavoriteToggle,
        ),
        onTap: onTap,
      ),
    );
  }
}
