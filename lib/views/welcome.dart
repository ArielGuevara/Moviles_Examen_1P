import 'package:flutter/material.dart';
import 'package:examenp1/model/cliente_model.dart';
import 'package:examenp1/views/resumen_cliente_view.dart';
import 'package:provider/provider.dart';
import 'package:examenp1/controller/bancoController.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bancoController = Provider.of<BancoController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Banco bandido Peluche',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              // Input para buscar cliente por ID
              _BuscarClientePorId(),
              const SizedBox(height: 20),
              const Text('Lista de clientes:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: bancoController.clientes.length,
                  itemBuilder: (context, index) {
                    final cliente = bancoController.clientes[index];
                    return Card(
                      child: ListTile(
                        title: Text(cliente.nombre),
                        subtitle: Text('ID: ${cliente.id}'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResumenClienteView(cliente: cliente),
                              ),
                            );
                          },
                          child: const Text('Ver Detalle'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuscarClientePorId extends StatefulWidget {
  @override
  State<_BuscarClientePorId> createState() => _BuscarClientePorIdState();
}

class _BuscarClientePorIdState extends State<_BuscarClientePorId> {
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _idController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'ID del cliente',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            final id = int.tryParse(_idController.text);
            if (id != null) {
              final bancoController = Provider.of<BancoController>(context, listen: false);
              final cliente = bancoController.clientes.firstWhere(
                (c) => c.id == id,
                orElse: () => null as ClienteModel,
              );
              if (cliente != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResumenClienteView(cliente: cliente),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cliente no encontrado')),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ingrese un ID válido')),
              );
            }
          },
          child: const Text('Ver cliente por ID'),
        ),
      ],
    );
  }
}
