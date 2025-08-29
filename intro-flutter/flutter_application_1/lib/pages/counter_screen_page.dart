import 'package:flutter/material.dart';
import '../examples/change_counter_screen.dart';

class CounterScreenValueNotifier extends StatefulWidget {
  const CounterScreenValueNotifier({super.key});

  @override
  State<CounterScreenValueNotifier> createState() =>
      _CounterScreenValueNotifierState();
}

class _CounterScreenValueNotifierState
    extends State<CounterScreenValueNotifier> {
  final CounterModel _counterModel = CounterModel();

  @override
  void dispose() {
    _counterModel.dispose();
    super.dispose();
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
              // Container do contador ouvindo cor e valor
              ListenableBuilder(
                listenable: _counterModel,
                builder: (context, child) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _counterModel.color, width: 2),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Valor do contador:',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${_counterModel.counter}',
                          style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: _counterModel.color),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Mensagem ouvindo mudanças
              ListenableBuilder(
                listenable: _counterModel,
                builder: (context, child) {
                  return Text(
                    _counterModel.message,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
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
                    onPressed: _counterModel.decrement,
                    label: const Text('Decrementar'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red, width: 2),
                      foregroundColor: Colors.red,
                    ),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.refresh),
                    onPressed: _counterModel.reset,
                    label: const Text('Resetar'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue, width: 2),
                      foregroundColor: Colors.blue,
                    ),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: _counterModel.increment,
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
      ),
    );
  }
}
