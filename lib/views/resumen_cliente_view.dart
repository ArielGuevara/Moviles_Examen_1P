import 'package:flutter/material.dart';
import 'package:examenp1/model/cliente_model.dart';

class ResumenClienteView extends StatelessWidget {
  final ClienteModel cliente;

  const ResumenClienteView({Key? key, required this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: Text(cliente.nombre),
        backgroundColor: Colors.deepPurple,
        elevation: 2,
      ),
      body: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.account_circle, size: 60, color: Colors.white),
                const SizedBox(height: 10),
                Text(cliente.nombre, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                const SizedBox(height: 20),
                _buildAnimatedValue("Saldo Actual", cliente.saldoActual),
                _buildAnimatedValue("Pago Mínimo", cliente.pagoMinimo),
                _buildAnimatedValue("Pago Sin Intereses", cliente.pagoSinIntereses),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    minimumSize: const Size.fromHeight(45),
                  ),
                  icon: const Icon(Icons.home, color: Colors.white),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  label: const Text('Volver a inicio'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedValue(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label + ':',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: value),
            duration: const Duration(seconds: 1),
            builder: (_, val, __) => Text(
              "\$${val.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
