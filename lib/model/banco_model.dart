import 'package:flutter/material.dart';
import 'package:examenp1/controller/cliente_controller.dart';
import 'package:examenp1/model/cliente_model.dart';

class BancoModel {

  final List<ClienteModel> clientes;
  BancoModel(this.clientes);

  // Calcula el total de intereses ganados por morosos.
  double get interesesTotales {
    return clientes.fold(0.0, (sum, cliente) => sum + cliente.interesesAcumulados);
  }
}