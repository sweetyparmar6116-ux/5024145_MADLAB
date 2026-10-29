import 'package:flutter/material.dart';

// MADL Task 3: Common Flutter widgets. B3 date: 12/08/2026.
void main() => runApp(const CommonWidgetsApp());

class CommonWidgetsApp extends StatefulWidget {
  const CommonWidgetsApp({super.key});
  @override
  State<CommonWidgetsApp> createState() => _CommonWidgetsAppState();
}

class _CommonWidgetsAppState extends State<CommonWidgetsApp> {
  final nameController = TextEditingController();
  String greeting = 'Enter your name and tap Say Hello.';
  @override
  void dispose() { nameController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), useMaterial3: true),
    home: Scaffold(
      appBar: AppBar(title: const Text('Common Flutter Widgets')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Row(children: [Icon(Icons.widgets, size: 36), SizedBox(width: 12), Expanded(child: Text('Explore Flutter Widgets', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))]),
          ),
          const SizedBox(height: 20),
          TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Your name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder())),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => setState(() => greeting = nameController.text.trim().isEmpty ? 'Hello, Flutter!' : 'Hello, ' + nameController.text.trim() + '!'),
            icon: const Icon(Icons.waving_hand), label: const Text('Say Hello'),
          ),
          const SizedBox(height: 16),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Text(greeting, textAlign: TextAlign.center))),
        ]),
      ),
    ),
  );
}