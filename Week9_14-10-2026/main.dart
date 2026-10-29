import 'package:flutter/material.dart';

// MADL Task 10: Production-readiness checklist for a Flutter Android app.
// This practical UI organizes test, debug, release-build, and deployment checks.

void main() => runApp(const ReleaseChecklistApp());

class ReleaseChecklistApp extends StatelessWidget {
  const ReleaseChecklistApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Release Checklist',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green), useMaterial3: true),
        home: const ReleaseChecklistPage(),
      );
}

class ReleaseChecklistPage extends StatefulWidget {
  const ReleaseChecklistPage({super.key});

  @override
  State<ReleaseChecklistPage> createState() => _ReleaseChecklistPageState();
}

class _ReleaseChecklistPageState extends State<ReleaseChecklistPage> {
  final tasks = <String>[
    'Run the app on an emulator',
    'Test on a physical Android device',
    'Check form validation and error messages',
    'Review and fix debug issues',
    'Run flutter analyze and resolve warnings',
    'Run automated tests',
    'Set the app version and build number',
    'Build a release APK or App Bundle',
    'Test the release build',
    'Prepare store listing and deployment details',
  ];
  late final List<bool> completed = List<bool>.filled(tasks.length, false);

  @override
  Widget build(BuildContext context) {
    final count = completed.where((value) => value).length;
    return Scaffold(
      appBar: AppBar(title: const Text('Android Release Checklist')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Prepare for Release', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('$count of ${tasks.length} checks completed'),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: count / tasks.length),
          ]),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) => CheckboxListTile(
              value: completed[index],
              title: Text(tasks[index]),
              secondary: Icon(index < 6 ? Icons.bug_report : Icons.rocket_launch),
              onChanged: (value) => setState(() => completed[index] = value ?? false),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: OutlinedButton.icon(
            onPressed: () => setState(() {
              for (var i = 0; i < completed.length; i++) {
                completed[i] = false;
              }
            }),
            icon: const Icon(Icons.refresh),
            label: const Text('Reset checklist'),
          ),
        ),
      ]),
    );
  }
}
