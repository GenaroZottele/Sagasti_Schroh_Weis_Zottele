import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_base/widgets/drawer_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Obtiene el tema actual
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PELÍCULAS Y SERIES',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 0, 0, 0),
            letterSpacing: 2.0,
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
        leadingWidth: 40,
        toolbarHeight: 80,
        backgroundColor: isDarkMode
            ? theme.colorScheme.primary.withOpacity(0.9)
            : const Color.fromARGB(255, 43, 43, 43),
        elevation: 10,
      ),
      drawer: DrawerMenu(),
      body: Stack(
        children: [
          // Imagen de fondo con difuminado
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  isDarkMode
                      ? const Color.fromARGB(255, 255, 255, 255).withOpacity(0.7)
                      : const Color.fromARGB(255, 161, 161, 161).withOpacity(0.5),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          // Contenido superpuesto al fondo
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.movie,
                  size: 100,
                  color: isDarkMode ? const Color.fromARGB(255, 255, 255, 255) : Colors.amberAccent,
                ),
                const SizedBox(height: 20),
                Text(
                  'BIENVENIDO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'EXPLORA TUS ACTORES, PELÍCULAS Y SERIES FAVORITAS, SIN PERDERTE DE NINGÚN ESTRENO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.7)
                        : const Color.fromRGBO(255, 255, 255, 0.702),
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
