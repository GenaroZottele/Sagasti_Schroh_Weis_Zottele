import 'package:flutter/material.dart';
import 'package:flutter_application_base/screens/custom_list_reg_detail.dart';

class custom_list_reg extends StatelessWidget {
     custom_list_reg({
    super.key,
  });

  final List<Map<String, String>> registros = [
    {'id': '1', 'nombre': 'Registro 1', 'descripcion': 'Detalle 1'},
    {'id': '2', 'nombre': 'Registro 2', 'descripcion': 'Detalle 2'},
    // Agregar más registros.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Registros')),
      body: ListView.builder(
        itemCount: registros.length,
        itemBuilder: (context, index) {
          final registro = registros[index];
          return ListTile(
            title: Text(registro['nombre']!),
            subtitle: Text(registro['descripcion']!),
            onTap: () => Navigator.pushNamed(
              context,
              '/details',
              arguments: registro,
            ),
          );
        },
      ),
    );
  }
}
