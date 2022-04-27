import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_2_cg/src/screens/counter_page.dart';
import 'package:flutter_riverpod_2_cg/src/themes/az_material_colors.dart';

final counterProvider = StateProvider((ref) => 0);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // onPrimary: is the background color
            primary: Theme.of(context).colorScheme.primary,

            // onPrimary: is the foreground color
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          child: const Text('Go to counter page'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CounterPage(counterProvider: counterProvider),
              ),
            );
          },
        ),
      ),
    );
  }
}
