import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_base/widgets/drawer_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PELÍCULAS Y SERIES',
          style: TextStyle(
            fontSize: 30,  // Fuente más grande
            fontWeight: FontWeight.bold,
            color: Colors.yellow, // Color amarillo
            letterSpacing: 2.0, // Aumento de espacio entre letras
            fontFamily: 'Roboto',  // Fuente por defecto
          ),
        ),
        centerTitle: true,
        leadingWidth: 40,
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(255, 61, 61, 61),
        elevation: 10,
      ),
      drawer: DrawerMenu(),
      body: Stack(
        children: [
          // Imagen de fondo con difuminado
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'), // Imagen de fondo
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  const Color.fromARGB(255, 66, 12, 12).withOpacity(0.5), // Difuminado con opacidad
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          // Contenido superpuesto al fondo
          Center( // Usamos Center para centrar todo el contenido
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centrado verticalmente
              crossAxisAlignment: CrossAxisAlignment.center, // Centrado horizontalmente
              children: [
                // Icono decorativo
                Icon(
                  Icons.movie,
                  size: 100,
                  color: Colors.amberAccent,
                ),
                const SizedBox(height: 20),
                // Texto principal con fuente y tamaño más grande
                Text(
                  'BIENVENIDO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,  // Fuente grande
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'OpenSans',  // Otra fuente predeterminada
                  ),
                ),
                const SizedBox(height: 10),
                // Subtítulo con fuente más ligera
                Text(
                  'EXPLORA TUS ACTORES, PELÍCULAS Y SERIES FAVORITAS, SIN PERDERTE DE NINGÚN ESTRENO ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color.fromRGBO(255, 255, 255, 0.702),
                    fontFamily: 'Poppins', // Otra fuente predeterminada
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
