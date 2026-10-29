import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// MADL Task 6: Include icons, images and charts in a Flutter app.
// B3 teaching-plan date: 02/09/2026.
// Dependency required in pubspec.yaml: fl_chart: ^1.0.0

void main() => runApp(const VisualDashboardApp());

class VisualDashboardApp extends StatelessWidget {
  const VisualDashboardApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Visual Dashboard',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), useMaterial3: true),
        home: const VisualDashboardPage(),
      );
}

class VisualDashboardPage extends StatelessWidget {
  const VisualDashboardPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Visual Dashboard')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Row(children: [
              Icon(Icons.analytics, size: 34, color: Colors.blue),
              SizedBox(width: 10),
              Expanded(child: Text('Student Activity', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
            ]),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=900',
                height: 170,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 170,
                  color: Colors.blue.shade50,
                  child: const Center(child: Icon(Icons.image_not_supported, size: 48)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Weekly Progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            SizedBox(
              height: 230,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 20, 18, 12),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 10,
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 28)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const days = ['M', 'T', 'W', 'T', 'F'];
                              final index = value.toInt();
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(index >= 0 && index < days.length ? days[index] : ''),
                              );
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: const FlGridData(show: true, drawVerticalLine: false),
                      barGroups: List.generate(5, (index) {
                        const values = [4.0, 6.0, 5.0, 8.0, 7.0];
                        return BarChartGroupData(x: index, barRods: [
                          BarChartRodData(toY: values[index], width: 22, borderRadius: BorderRadius.circular(4)),
                        ]);
                      }),
                    ),
                  ),
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text('Widgets used'),
              subtitle: Text('Icon, Image.network, Card, and BarChart from fl_chart'),
            ),
          ],
        ),
      );
}
