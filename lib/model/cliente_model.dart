import 'package:flutter/material.dart';

class ClienteModel
{
  final int id;
  final String nombre;
  double saldoAnterior;
  double comprasRealizadas;
  double pagoDepositado;
  double interesesAcumulados = 0.0;

  ClienteModel(this.id, this.nombre, this.saldoAnterior, this.comprasRealizadas,
      this.pagoDepositado);

  double get saldoActual {
    double saldoParcial = saldoAnterior + comprasRealizadas - pagoDepositado;
    if (pagoDepositado < saldoParcial * 0.15) {
      interesesAcumulados = saldoParcial * 0.12;
      return saldoParcial + interesesAcumulados + 200;
    }
    return saldoParcial;
  }

  double get pagoMinimo => saldoActual * 0.15;
  double get pagoSinIntereses => saldoActual * 0.85;

}
