import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_base/mocks/estrenos_mock.dart' show peliculasEstrenos;
import 'package:flutter_application_base/widgets/movie_card.dart'; // Importar MovieCard

class CustomListScreenEstrenos extends StatefulWidget {
  const CustomListScreenEstrenos({super.key});

  @override
  State<CustomListScreenEstrenos> createState() => _CustomListScreenState();
}

class _CustomListScreenState extends State<CustomListScreenEstrenos> {
  List _auxiliarElements = [];
  String _searchQuery = '';
  bool _searchActive = false;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _auxiliarElements = peliculasEstrenos;
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
        _auxiliarElements = peliculasEstrenos; // Restablecer al estado original
      } else {
        _auxiliarElements = peliculasEstrenos.where((element) {
          return element[1].toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
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
            // Abrir detalle y esperar cambios
            final updatedData = await Navigator.pushNamed(
              context,
              'estrenos_list_item',
              arguments: {
                'poster': movie[0],
                'title': movie[1],
                'category': movie[2],
                'rating': movie[3], 
                'favorite': movie[4],
              },
            );

            // Verificar si hay cambios y actualizar la lista
            if (updatedData != null) {
              setState(() {
                // Actualizar solo los campos específicos
                _auxiliarElements[index][4] = updatedData; // Estado de favorito
              });
            }
          },
          child: MovieCard(
            poster: movie[0],
            title: movie[1],
            category: movie[2],
            rating: movie[3], 
            isFavorite: movie[4],
            onFavoriteToggle: () {
              setState(() {
                // Cambiar estado local directamente
                _auxiliarElements[index][4] = !_auxiliarElements[index][4];
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
      switchInCurve: Curves.bounceIn,
      switchOutCurve: Curves.bounceOut,
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
                      onChanged: (value) {
                        _updateSearch(value);
                      },
                      onFieldSubmitted: (value) {
                        _updateSearch(value);
                      },
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
          : Container(
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.keyboard_arrow_left_outlined)),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _searchActive = !_searchActive;
                        });
                        _focusNode.requestFocus();
                      },
                      icon: const Icon(Icons.search)),
                ],
              ),
            ),
    );
  }
}
