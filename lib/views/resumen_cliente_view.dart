import 'package:flutter/material.dart';
import 'package:examenp1/model/cliente_model.dart';

class ResumenClienteView extends StatelessWidget {
  final ClienteModel cliente;

  const ResumenClienteView({Key? key, required this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(cliente.nombre, style: Theme.of(context).textTheme.titleLarge),
          _buildAnimatedValue("Saldo Actual", cliente.saldoActual),
          _buildAnimatedValue("Pago Mínimo", cliente.pagoMinimo),
          _buildAnimatedValue("Pago Sin Intereses", cliente.pagoSinIntereses),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text('Volver a inicio'),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedValue(String label, double value) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: const Duration(seconds: 1),
      builder: (_, val, __) => Text("$label: \$${val.toStringAsFixed(2)}"),
    );
  }
}

