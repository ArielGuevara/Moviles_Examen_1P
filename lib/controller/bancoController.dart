import 'package:flutter/material.dart';
import 'package:examenp1/model/cliente_model.dart';

class BancoController extends ChangeNotifier{

  List<ClienteModel> _clientes = [];

  List<ClienteModel> get clientes => _clientes;

  BancoController() {
    cargarClientes([
      ClienteModel(1, 'Juan Pérez', 1000, 200, 100),
      ClienteModel(2, 'Ana Gómez', 1500, 300, 200),
      ClienteModel(3, 'Luis Torres', 2000, 500, 300),
    ]);
  }

  void cargarClientes(List<ClienteModel> clientes) {
    _clientes = clientes;
    notifyListeners();
  }
  void agregarCliente(ClienteModel cliente) {
    _clientes.add(cliente);
    notifyListeners();
  }
  String verSaldoPorIntereses(){
    double total=0.0;
    String respuesta='';
   for(var cliente in _clientes){
    total += cliente.interesesAcumulados;
   }
   return respuesta='Total de intereses ganados por morosos: \$${total.toStringAsFixed(2)}';
  }
  void actualizarPago(String clienteId, double nuevoPago) {
    final cliente = _clientes.firstWhere((c) => c.id == clienteId);
    cliente.pagoDepositado = nuevoPago;
    notifyListeners();
  }
  void metodoQueCambiaEstado() {
    notifyListeners(); // Notifica a los widgets suscritos
  }
}

