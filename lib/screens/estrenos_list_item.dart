import 'package:flutter/material.dart';

class EstrenosListItem extends StatefulWidget {
  const EstrenosListItem({super.key});

  @override
  State<EstrenosListItem> createState() => _EstrenosListItemState();
}

class _EstrenosListItemState extends State<EstrenosListItem> {
  late bool isFavorite;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    isFavorite = args['favorite'];
  }

  void toggleFavorite(bool value) {
    setState(() {
      isFavorite = value;
    });
  }

void saveChanges(BuildContext context) {
  Navigator.pop(context, isFavorite);  
}
 

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(args['title']),
        elevation: 10,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, null); 
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderEstrenosListItem(
              poster: args['poster'],
              isFavorite: isFavorite,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: BodyEstrenosListItem(
                args: args,
                isFavorite: isFavorite,
                onFavoriteToggle: toggleFavorite,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => saveChanges(context),
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderEstrenosListItem extends StatelessWidget {
  final String poster;
  final bool isFavorite;

  const HeaderEstrenosListItem({
    super.key,
    required this.poster,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          color: const Color(0xff2d3e4f),
          child: Image.asset(
            'assets/posters_estrenos/$poster.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Icon(
            isFavorite ? Icons.star : Icons.star_border_outlined,
            color: isFavorite ? Colors.yellow : Colors.grey,
            size: 30,
          ),
        ),
      ],
    );
  }
}

class BodyEstrenosListItem extends StatelessWidget {
  final Map<String, dynamic> args;
  final bool isFavorite;
  final ValueChanged<bool> onFavoriteToggle;

  const BodyEstrenosListItem({
    super.key,
    required this.args,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Título: ${args['title']}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          'Categoría: ${args['category']}',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Clasificación: ', style: TextStyle(fontSize: 18)),
            RatingCircle(rating: args['rating']),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Agregar a favoritos:',
              style: TextStyle(fontSize: 18),
            ),
            Switch(
              value: isFavorite,
              onChanged: onFavoriteToggle,
            ),
          ],
        ),
      ],
    );
  }
}

class RatingCircle extends StatelessWidget {
  final double rating;

  const RatingCircle({Key? key, required this.rating}) : super(key: key);

  Color _getRatingColor(double rating) {
    if (rating < 50) return Colors.red; 
    if (rating < 75) return Colors.amber;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: _getRatingColor(rating),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        rating.toStringAsFixed(1),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
