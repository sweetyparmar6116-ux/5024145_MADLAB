import 'package:flutter/material.dart';

// MADL Task 5: Layout widgets and responsive dashboard..
void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: DashboardPage()));

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('My Courses', Icons.menu_book, Colors.indigo),
      ('Assignments', Icons.assignment, Colors.deepOrange),
      ('Timetable', Icons.calendar_month, Colors.teal),
      ('Results', Icons.grade, Colors.purple),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Student Dashboard')),
      body: LayoutBuilder(builder: (context, constraints) {
        final columns = constraints.maxWidth >= 600 ? 4 : 2;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(16)),
              child: const Row(children: [
                CircleAvatar(radius: 28, child: Icon(Icons.person, size: 32)),
                SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Welcome, Student!', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                  Text('Your learning overview'),
                ])),
              ]),
            ),
            const SizedBox(height: 24),
            const Text('Quick Access', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns, crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(child: InkWell(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(item.$1 + ' selected'))),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(item.$2, size: 36, color: item.$3),
                    const SizedBox(height: 10),
                    Text(item.$1, textAlign: TextAlign.center),
                  ]),
                ));
              },
            ),
          ]),
        );
      }),
    );
  }
}