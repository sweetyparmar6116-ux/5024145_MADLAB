import 'package:flutter/material.dart';

// MADL Task 4: Interactive form using Form and validation. B3 date: 18/08/2026.
void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: RegistrationPage()));

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  String? department;
  bool acceptedTerms = false;

  @override
  void dispose() { nameController.dispose(); emailController.dispose(); super.dispose(); }

  void submit() {
    if (!formKey.currentState!.validate()) return;
    if (!acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please accept the terms and conditions.')));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration submitted for ' + nameController.text.trim() + '!')));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Student Registration')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Icon(Icons.app_registration, size: 52),
          const Text('Create an Account', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextFormField(controller: nameController, decoration: const InputDecoration(labelText: 'Full name', border: OutlineInputBorder()), validator: (v) => v == null || v.trim().isEmpty ? 'Enter your name.' : null),
          const SizedBox(height: 14),
          TextFormField(controller: emailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()), validator: (v) {
            final email = v?.trim() ?? '';
            if (email.isEmpty) return 'Enter your email.';
            if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) return 'Enter a valid email.';
            return null;
          }),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            value: department,
            decoration: const InputDecoration(labelText: 'Department', border: OutlineInputBorder()),
            items: const [
              DropdownMenuItem(value: 'Information Technology', child: Text('Information Technology')),
              DropdownMenuItem(value: 'Computer Engineering', child: Text('Computer Engineering')),
              DropdownMenuItem(value: 'Electronics', child: Text('Electronics')),
            ],
            onChanged: (v) => setState(() => department = v),
            validator: (v) => v == null ? 'Choose a department.' : null,
          ),
          CheckboxListTile(contentPadding: EdgeInsets.zero, value: acceptedTerms, title: const Text('I accept the terms and conditions'), onChanged: (v) => setState(() => acceptedTerms = v ?? false)),
          FilledButton(onPressed: submit, child: const Text('Submit')),
        ]),
      ),
    ),
  );
}