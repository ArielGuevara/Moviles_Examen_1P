import 'package:flutter/material.dart';
import 'package:examenp1/model/cliente_model.dart';
import 'package:examenp1/views/resumen_cliente_view.dart';
import 'package:provider/provider.dart';
import 'package:examenp1/controller/bancoController.dart';
import 'package:flutter/src/rendering/box.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _WelcomePageBody();
  }
}

class _WelcomePageBody extends StatefulWidget {
  @override
  State<_WelcomePageBody> createState() => _WelcomePageBodyState();
}

class _WelcomePageBodyState extends State<_WelcomePageBody> {
  String _resultadoIntereses = '';

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
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _resultadoIntereses = bancoController.verSaldoPorIntereses();
                  });
                },
                child: const Text('Ver total de intereses acumulados'),
              ),
              const SizedBox(height: 10),
              Text(_resultadoIntereses, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('Lista de clientes:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.person_add),
                  label: const Text('Agregar cliente'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/agregar_cliente');
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: bancoController.clientes.length,
                  itemBuilder: (context, index) {
                    final cliente = bancoController.clientes[index];
                    return Card(
                      child: ListTile(
                        title: Text(cliente.nombre),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID: ${cliente.id}'),
                            Text('Saldo actual: \$${cliente.saldoActual.toStringAsFixed(2)}'),
                            Text('Compras realizadas: \$${cliente.comprasRealizadas.toStringAsFixed(2)}'),
                            Text('Pago depositado: \$${cliente.pagoDepositado.toStringAsFixed(2)}'),
                          ],
                        ),
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
