import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/custom_card.dart';
import 'package:flutter_application_1/examples/simple_change_notifier_example.dart';
//import 'package:flutter_application_1/pages/counter_screen_page.dart';
import 'package:flutter_application_1/examples/value_notifier_counter_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
          backgroundColor: Colors.purple,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CustomCard(
                      title: 'Counter Screen Notifier',
                      description: 'Teste de contador com clique',
                      icon: Icons.add_circle_outline,
                      destination: CounterScreenValueNotifier(),
                    ),
                    CustomCard(
                      title: 'Change Notifier Example',
                      description: 'Teste de Change Notifier',
                      icon: Icons.add_circle_outline,
                      destination: SimpleChangeNotifierExample(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
