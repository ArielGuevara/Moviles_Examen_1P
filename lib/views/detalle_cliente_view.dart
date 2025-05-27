import 'package:flutter/material.dart';
import 'package:examenp1/model/cliente_model.dart';
import 'package:examenp1/views/resumen_cliente_view.dart';

class DetalleClienteView extends StatelessWidget {
  final ClienteModel cliente;

  const DetalleClienteView({Key? key, required this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'cliente_${cliente.id}',
      child: Scaffold(
        appBar: AppBar(
          title: Text(cliente.nombre),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ResumenClienteView(cliente: cliente),
          ),
        ),
      ),
    );
  }
}
