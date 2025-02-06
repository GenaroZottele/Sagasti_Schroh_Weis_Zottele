import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_base/helpers/actor_provider.dart';
import 'package:flutter_application_base/widgets/actor_card.dart';

class ActoresListScreen extends StatelessWidget {
  const ActoresListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final actorProvider = Provider.of<ActorProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Actores'),
      ),
      body: FutureBuilder(
        future: actorProvider.cargarActores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar actores'));
          } else {
            return Consumer<ActorProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.actores.length,
                  itemBuilder: (context, index) {
                    final actor = provider.actores[index];

                    return ActorCard(
                      actor: actor,
                      onTap: () async {
                        final updatedActor = await Navigator.pushNamed(
                          context,
                          'details',
                          arguments: {
                            ...actor,
                            'profile_path': actor['profile_path'] ?? 'https://via.placeholder.com/150',
                            'category': actor['category'] ?? 'Desconocido',
                            'popularity': actor['popularity'] ?? 'Desconocida',
                            'movies': actor['movies'] ?? [],
                          },
                        ) as Map<String, dynamic>?;

                        if (updatedActor != null) {
                          provider.updateActor(index, updatedActor);
                        }
                      },
                      onFavoriteToggle: () {
                        provider.toggleFavorite(index);
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
