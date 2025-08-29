import 'package:flutter/material.dart';

/// Modelo de contador usando ChangeNotifier
class CounterModel extends ChangeNotifier {
  int _counter = 0;
  String _message = 'Toque nos botões para alterar o contador';
  Color _color = Colors.blue;

  int get counter => _counter;
  String get message => _message;
  Color get color => _color;

  void increment() {
    _counter++;
    _message = 'Contador incrementado';
    _updateColor();
    notifyListeners();
  }

  void decrement() {
    _counter--;
    _message = 'Contador decrementado';
    _updateColor();
    notifyListeners();
  }

  void reset() {
    _counter = 0;
    _message = 'Contador resetado';
    _updateColor();
    notifyListeners();
  }

  void _updateColor() {
    if (_counter > 0) {
      _color = Colors.green;
    } else if (_counter < 0) {
      _color = Colors.red;
    } else {
      _color = Colors.blue;
    }
  }
}
