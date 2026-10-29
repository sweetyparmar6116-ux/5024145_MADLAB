import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

// MADL Task 8: Use a library and create, write, and read a text file.
// B3 teaching-plan date: 30/09/2026.
// Dependency required in pubspec.yaml: path_provider: ^2.1.5

void main() => runApp(const FileHandlingApp());

class FileHandlingApp extends StatelessWidget {
  const FileHandlingApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'File Handling',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), useMaterial3: true),
        home: const FileHandlingPage(),
      );
}

class FileHandlingPage extends StatefulWidget {
  const FileHandlingPage({super.key});

  @override
  State<FileHandlingPage> createState() => _FileHandlingPageState();
}

class _FileHandlingPageState extends State<FileHandlingPage> {
  final controller = TextEditingController();
  String output = 'Type some text, then save or read the file.';
  bool busy = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/madl_notes.txt');
  }

  Future<void> _saveFile() async {
    setState(() => busy = true);
    try {
      final file = await _getFile();
      await file.writeAsString(controller.text);
      setState(() => output = 'Saved successfully to: ' + file.path);
    } catch (error) {
      setState(() => output = 'Could not save file: ' + error.toString());
    } finally {
      setState(() => busy = false);
    }
  }

  Future<void> _readFile() async {
    setState(() => busy = true);
    try {
      final file = await _getFile();
      if (!await file.exists()) {
        setState(() => output = 'File does not exist yet. Save some text first.');
      } else {
        final contents = await file.readAsString();
        setState(() => output = 'File contents:\n' + contents);
      }
    } catch (error) {
      setState(() => output = 'Could not read file: ' + error.toString());
    } finally {
      setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Text File Practice')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextField(
              controller: controller,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Text to save',
                hintText: 'Write a note...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: ElevatedButton.icon(
                onPressed: busy ? null : _saveFile,
                icon: const Icon(Icons.save),
                label: const Text('Save'),
              )),
              const SizedBox(width: 12),
              Expanded(child: OutlinedButton.icon(
                onPressed: busy ? null : _readFile,
                icon: const Icon(Icons.file_open),
                label: const Text('Read'),
              )),
            ]),
            const SizedBox(height: 20),
            if (busy) const LinearProgressIndicator(),
            const SizedBox(height: 12),
            const Text('Result', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(child: SingleChildScrollView(child: SelectableText(output))),
          ]),
        ),
      );
}
