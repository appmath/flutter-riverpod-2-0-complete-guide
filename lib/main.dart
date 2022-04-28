import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_2_cg/src/app.dart';
import 'package:flutter_riverpod_2_cg/src/themes/az_material_colors.dart';

// Automatically disposes of the resource whenever CounterPage is removed: resets
// the counter to 0.
// final counterProvider = StateProvider.autoDispose((ref) => 0);

abstract class WebsocketClient {
  Stream<int> getCounterStream([int start]);
}

class FakeWebsocketClient implements WebsocketClient {
  @override
  Stream<int> getCounterStream([int start = 0]) async* {
    int i = start;
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      yield i++;
    }
  }
}

final websocketClientProvider = Provider<WebsocketClient>((ref) {
  return FakeWebsocketClient();
});

final counterProvider = StreamProvider.family<int, int>((ref, start) {
  final wsClient = ref.watch(websocketClientProvider);
  return wsClient.getCounterStream(start);
});

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: lightThemeData(),
      darkTheme: darkThemeData(),
      title: 'Counter App',
      home: HomePage(),
    );
  }

// MaterialApp(
//  themeMode: ThemeMode.light,
//  theme: lightThemeData(),
//  darktheme: darkThemeData(),...
  ThemeData lightThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: greyMaterialColor,
      ).copyWith(
        secondary: orangeMaterialColor,
      ),
    );
  }

  // MaterialApp( darktheme: darkThemeData(),...
  ThemeData darkThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: greyMaterialColor,
        brightness: Brightness.dark,
      ).copyWith(
        secondary: orangeMaterialColor,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Counter Page'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => const CounterPage()),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ConsumerWidget is like a StatelessWidget
// but with a WidgetRef parameter added in the build method.
class CounterPage extends ConsumerWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Using the WidgetRef to get the counter int from the counterProvider.
    // The watch method makes the widget rebuild whenever the int changes value.
    //   - something like setState() but automatic
    final AsyncValue<int> counter = ref.watch(counterProvider(5));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: Text(
          counter
              .when(
                  data: (int value) => value,
                  error: (Object e, _) => e,
                  loading: () => 5)
              .toString(),
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }

  void _showErrorDialog(String title, String content, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
