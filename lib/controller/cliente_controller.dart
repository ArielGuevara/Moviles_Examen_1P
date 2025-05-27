import 'package:flutter/material.dart';
import 'package:examenp1/controller/cliente_controller.dart';

class ClienteController {
  // Atributos
  String _usuario = '';
  String _password = '';

  // Getters
  String get usuario => _usuario;
  String get password => _password;

  // Setters
  set usuario(String value) {
    _usuario = value;
  }

  set password(String value) {
    _password = value;
  }

  // Métodos
  bool validarUsuario() {
    return _usuario.isNotEmpty && _password.isNotEmpty;
  }
}