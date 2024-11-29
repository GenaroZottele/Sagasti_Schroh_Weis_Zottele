import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_base/mocks/estrenos_mock.dart' show peliculasEstrenos;
import 'package:flutter_application_base/widgets/movie_card.dart';

class CustomListScreen extends StatefulWidget {
  const CustomListScreen({super.key});

  @override
  State<CustomListScreen> createState() => _CustomListScreenState();
}

class _CustomListScreenState extends State<CustomListScreen> {
  late List _auxiliarElements;
  String _searchQuery = '';
  bool _searchActive = false;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _auxiliarElements = List.from(peliculasEstrenos);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _updateSearch(String? query) {
    setState(() {
      _searchQuery = query ?? '';
      if (_searchQuery.isEmpty) {
        _auxiliarElements = List.from(peliculasEstrenos);
      } else {
        _auxiliarElements = peliculasEstrenos.where((element) {
          return element[1].toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();
      }
    });
  }

  void _updateFavorite(String title, bool isFavorite) {
    setState(() {
      final index = peliculasEstrenos.indexWhere((movie) => movie[1] == title);
      if (index != -1) peliculasEstrenos[index][4] = isFavorite;

      // También actualizar la lista auxiliar si corresponde
      final auxIndex = _auxiliarElements.indexWhere((movie) => movie[1] == title);
      if (auxIndex != -1) _auxiliarElements[auxIndex][4] = isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            searchArea(),
            listItemsArea(),
          ],
        ),
      ),
    );
  }

  Expanded listItemsArea() {
  return Expanded(
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _auxiliarElements.length,
      itemBuilder: (BuildContext context, int index) {
        final movie = _auxiliarElements[index];

        return GestureDetector(
          onTap: () async {
            final updatedFavorite = await Navigator.pushNamed(
              context,
              'estrenos_list_item',
              arguments: {
                'poster': movie[0],
                'title': movie[1],
                'category': movie[2],
                'rating': movie[3].toDouble(), // Asegúrate de pasar un double
                'favorite': movie[4],
              },
            );

            // Actualizar el estado si cambian favoritos o cualquier otra propiedad
            if (updatedFavorite != null) {
              setState(() {
                movie[4] = updatedFavorite;
              });
            }
          },
          child: MovieCard(
            poster: movie[0],
            title: movie[1],
            category: movie[2],
            rating: movie[3].toDouble(), // Asegúrate de usar double
            isFavorite: movie[4],
            onFavoriteToggle: () {
              // Cambiar estado local al presionar el botón de favorito
              setState(() {
                movie[4] = !movie[4];
              });
            },
          ),
        );
      },
    ),
  );
}
  AnimatedSwitcher searchArea() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: (_searchActive)
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      onChanged: _updateSearch,
                      decoration: const InputDecoration(hintText: 'Buscar...'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _searchController.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                      _updateSearch('');
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _searchActive = false;
                      });
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _searchActive = true;
                    });
                    _focusNode.requestFocus();
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
    );
  }
}

