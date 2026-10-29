import 'package:flutter/material.dart';

// MADL Task 7: Navigation, named routes and gesture detection.

void main() => runApp(const NavigationGesturesApp());

class NavigationGesturesApp extends StatelessWidget {
  const NavigationGesturesApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/details': (context) => const DetailsPage(),
        },
      );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Navigation Demo')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Card tapped!')),
                ),
                onDoubleTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Card double-tapped!')),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(children: [
                    Icon(Icons.touch_app, size: 52, color: Colors.indigo),
                    SizedBox(height: 12),
                    Text('Tap or double-tap this card', textAlign: TextAlign.center),
                  ]),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/details'),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Open Details Screen'),
              ),
            ]),
          ),
        ),
      );
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Details Screen')),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.route, size: 56),
            const SizedBox(height: 12),
            const Text('You navigated using a named route.'),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ]),
        ),
      );
}
