import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// MADL Task 9: Connect Flutter UI with Firebase Realtime Database.
// B3 teaching-plan date: 07/10/2026.
// Add firebase_core and firebase_database dependencies, configure Firebase for your app,
// and replace the database URL below with your Firebase Realtime Database URL.

const databaseUrl = 'https://YOUR-PROJECT-ID-default-rtdb.firebaseio.com/';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FirebaseNotesApp());
}

class FirebaseNotesApp extends StatelessWidget {
  const FirebaseNotesApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase Notes',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
        home: const FirebaseNotesPage(),
      );
}

class FirebaseNotesPage extends StatefulWidget {
  const FirebaseNotesPage({super.key});

  @override
  State<FirebaseNotesPage> createState() => _FirebaseNotesPageState();
}

class _FirebaseNotesPageState extends State<FirebaseNotesPage> {
  final controller = TextEditingController();
  late final DatabaseReference notesRef;
  String status = 'Enter a note and save it to Firebase.';

  @override
  void initState() {
    super.initState();
    notesRef = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: databaseUrl,
    ).ref('madl_notes');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    final note = controller.text.trim();
    if (note.isEmpty) {
      setState(() => status = 'Please enter some text first.');
      return;
    }
    try {
      await notesRef.push().set({
        'text': note,
        'createdAt': ServerValue.timestamp,
      });
      controller.clear();
      setState(() => status = 'Note saved successfully to Firebase.');
    } catch (error) {
      setState(() => status = 'Save failed: ' + error.toString());
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Firebase Realtime Database')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Enter a note', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _saveNote,
              icon: const Icon(Icons.cloud_upload),
              label: const Text('Save to Firebase'),
            ),
            const SizedBox(height: 12),
            Text(status),
            const SizedBox(height: 20),
            const Text('Saved notes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<DatabaseEvent>(
                stream: notesRef.orderByChild('createdAt').onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text('Could not read notes: ${snapshot.error}');
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final raw = snapshot.data?.snapshot.value;
                  if (raw == null) return const Center(child: Text('No notes saved yet.'));
                  final entries = (raw as Map).entries.toList().reversed.toList();
                  return ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final value = Map<String, dynamic>.from(entries[index].value as Map);
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.note),
                          title: Text((value['text'] ?? '').toString()),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ]),
        ),
      );
}
