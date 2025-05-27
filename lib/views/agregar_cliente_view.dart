import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examenp1/controller/bancoController.dart';
import 'package:examenp1/model/cliente_model.dart';

class AgregarClienteView extends StatefulWidget {
  const AgregarClienteView({Key? key}) : super(key: key);

  @override
  State<AgregarClienteView> createState() => _AgregarClienteViewState();
}

class _AgregarClienteViewState extends State<AgregarClienteView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _saldoAnteriorController = TextEditingController();
  final TextEditingController _comprasController = TextEditingController();
  final TextEditingController _pagoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Cliente')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _idController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ingrese el ID';
                  if (int.tryParse(value) == null) return 'ID inválido';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ingrese el nombre';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _saldoAnteriorController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Saldo anterior'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ingrese el saldo anterior';
                  if (double.tryParse(value) == null) return 'Saldo inválido';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _comprasController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Compras realizadas'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ingrese las compras realizadas';
                  if (double.tryParse(value) == null) return 'Valor inválido';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _pagoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Pago depositado'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ingrese el pago depositado';
                  if (double.tryParse(value) == null) return 'Valor inválido';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final nuevoCliente = ClienteModel(
                      int.parse(_idController.text),
                      _nombreController.text,
                      double.parse(_saldoAnteriorController.text),
                      double.parse(_comprasController.text),
                      double.parse(_pagoController.text),
                    );
                    Provider.of<BancoController>(context, listen: false).agregarCliente(nuevoCliente);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cliente agregado correctamente')));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Agregar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
