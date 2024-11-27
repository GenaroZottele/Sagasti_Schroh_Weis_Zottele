import 'package:flutter/material.dart';

class custom_list_reg_detail extends StatelessWidget {
    custom_list_reg_detail({
    super.key,
    });

  @override
  Widget build(BuildContext context) {
    final registro = ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(title: Text('Detalle del Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Detalle de: ${registro['nombre']}'),
            TextFormField(
              initialValue: registro['descripcion'],
              decoration: InputDecoration(labelText: 'Editar descripción'),
            ),
            SwitchListTile(
              title: Text('Activo'),
              value: true,
              onChanged: (value) {},
            ),
            SizedBox(height: 20),
            // Imagen opcional
            Image.network('https://via.placeholder.com/150'),
          ],
        ),
      ),
    );
  }
}
