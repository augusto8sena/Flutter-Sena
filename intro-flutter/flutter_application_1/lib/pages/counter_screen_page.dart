import 'package:flutter/material.dart';

class CounterScreenValueNotifier extends StatefulWidget {
  const CounterScreenValueNotifier({super.key});

  @override
  State<CounterScreenValueNotifier> createState() =>
      _CounterScreenValueNotifierState();
}

class _CounterScreenValueNotifierState
    extends State<CounterScreenValueNotifier> {
  final ValueNotifier<int> _counterNotifier = ValueNotifier<int>(0);
  final ValueNotifier<String> _messageNotifier =
      ValueNotifier<String>('Toque nos botões para alterar o contador');
  final ValueNotifier<Color> _counterColorNotifier =
      ValueNotifier<Color>(Colors.blue);

  @override
  void dispose() {
    _counterNotifier.dispose();
    _messageNotifier.dispose();
    _counterColorNotifier.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    _counterNotifier.value++;
    _messageNotifier.value = 'Contador incrementado';
    _updateColor();
  }

  void _decrementCounter() {
    _counterNotifier.value--;
    _messageNotifier.value = 'Contador decrementado';
    _updateColor();
  }

  void _resetCounter() {
    _counterNotifier.value = 0;
    _messageNotifier.value = 'Contador resetado';
    _updateColor();
  }

  void _updateColor() {
    if (_counterNotifier.value > 0) {
      _counterColorNotifier.value = Colors.green;
    } else if (_counterNotifier.value < 0) {
      _counterColorNotifier.value = Colors.red;
    } else {
      _counterColorNotifier.value = Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador Interativo'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder<Color>(
                  valueListenable: _counterColorNotifier,
                  builder: (context, color, child) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: color, width: 2),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Valor do contador:',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          ValueListenableBuilder<int>(
                            valueListenable: _counterNotifier,
                            builder: (context, value, child) {
                              return Text(
                                '$value',
                                style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: color),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder<String>(
                  valueListenable: _messageNotifier,
                  builder: (context, message, child) {
                    return Text(
                      message,
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade700),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton.icon(
                      icon: const Icon(Icons.remove),
                      onPressed: _decrementCounter,
                      label: const Text('Decrementar'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red, width: 2),
                        foregroundColor: Colors.red,
                      ),
                    ),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.refresh),
                      onPressed: _resetCounter,
                      label: const Text('Resetar'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blue, width: 2),
                        foregroundColor: Colors.blue,
                      ),
                    ),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.add),
                      onPressed: _incrementCounter,
                      label: const Text('Incrementar'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green, width: 2),
                        foregroundColor: Colors.green,
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
