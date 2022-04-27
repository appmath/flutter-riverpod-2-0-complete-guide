import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_2_cg/src/app.dart';
import 'package:flutter_riverpod_2_cg/src/themes/az_material_colors.dart';

// Automatically disposes of the resource whenever CounterPage is removed: resets
// the counter to 0.
// final counterProvider = StateProvider.autoDispose((ref) => 0);

abstract class WebsocketClient {
  Stream<int> getCounterStream();
}

class FakeWebsocketClient implements WebsocketClient {
  @override
  Stream<int> getCounterStream() async* {
    int i = 0;
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      yield i++;
    }
  }
}

final websocketClientProvider = Provider<WebsocketClient>((ref) {
  return FakeWebsocketClient();
});

final counterProvider = StreamProvider<int>((ref) {
  final wsClient = ref.watch(websocketClientProvider);
  return wsClient.getCounterStream();
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
    final int counter = ref.watch(counterProvider);

    ref.listen<int>(counterProvider, (previous, next) {
      if (next >= 5) {
        _showErrorDialog('Warning',
            'Counter dangerously high. Consider resetting it.', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // returns void and is more efficient.
              ref.invalidate(counterProvider);

              // returns 0
              // ref.refresh(counterProvider);
            },
          )
        ],
      ),
      body: Center(
        child: Text(
          counter.toString(),
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Using the WidgetRef to read() the counterProvider just one time.
          //   - unlike watch(), this will never rebuild the widget automatically
          // We don't want to get the int but the actual StateNotifier, hence we access it.
          // StateNotifier exposes the int which we can then mutate (in our case increment).
          ref.read(counterProvider.notifier).state++;
        },
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
