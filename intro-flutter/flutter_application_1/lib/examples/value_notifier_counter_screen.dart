import 'package:flutter/material.dart';

class CounterScreenValueNotifier extends StatefulWidget {
  const CounterScreenValueNotifier({super.key});

  @override
  State<CounterScreenValueNotifier> createState() =>
      _CounterScreenValueNotifierState();
}

class _CounterScreenValueNotifierState
    extends State<CounterScreenValueNotifier> {

  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final ValueNotifier<String> _lastAction = ValueNotifier<String>('');

  @override
  void dispose() {
    _counter.dispose();
    _lastAction.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    _counter.value++;
    _lastAction.value = 'Incrementado';
  }

  void _decrementCounter() {
    _counter.value--;
    _lastAction.value = 'Decrementado';
  }

  void _resetCounter() {
    _counter.value = 0;
    _lastAction.value = 'Resetado';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador com ValueNotifier'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 185, 6, 217),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Valor do contador',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),

            
            ValueListenableBuilder<int>(
              valueListenable: _counter,
              builder: (context, value, child) {
                Color color = Colors.blue;
                if (value > 0) color = Colors.green;
                if (value < 0) color = Colors.red;

                return Column(
                  children: [
                    Text(
                      '$value',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ValueListenableBuilder<String>(
                      valueListenable: _lastAction,
                      builder: (context, action, child) {
                        return Text(
                          action.isNotEmpty ? 'Última ação: $action' : '',
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        );
                      },
                    ),
                  ],
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
        ),
      ),
    );
  }
}
