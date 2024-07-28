import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SecurityGroupsScreen extends StatefulWidget {
  const SecurityGroupsScreen({super.key});

  @override
  _SecurityGroupsScreenState createState() => _SecurityGroupsScreenState();
}

class _SecurityGroupsScreenState extends State<SecurityGroupsScreen> {
  final List<List<String>> initialGroups = [
    ['ABC', 'ABC'],
    ['FGH'],
    ['XYZ'],
    ['TWS'],
    ['JKL']
  ];

  List<List<String>> currentGroups = [];
  DateTime? lastShuffleDate;
  final Box box = Hive.box('securityGroups');

  @override
  void initState() {
    super.initState();
    loadGroups();
  }

  Future<void> loadGroups() async {
    final lastShuffleDateString = box.get('lastShuffleDate');

    if (lastShuffleDateString != null) {
      lastShuffleDate = DateTime.parse(lastShuffleDateString);
      currentGroups = (box.get('currentGroups') as List<dynamic>)
          .map((group) => (group as List<dynamic>).cast<String>())
          .toList();
    }

    if (currentGroups.isEmpty || _shouldShuffle()) {
      _shuffleGroups();
    } else {
      setState(() {});
    }
  }

  bool _shouldShuffle() {
    if (lastShuffleDate == null) return true;
    final now = DateTime.now();
    final difference = now.difference(lastShuffleDate!).inDays;
    return difference >= 7;
  }

  Future<void> _shuffleGroups() async {
    final random = Random();
    currentGroups = List.from(initialGroups);
    currentGroups.shuffle(random);

    lastShuffleDate = DateTime.now();
    await box.put('lastShuffleDate', lastShuffleDate!.toIso8601String());
    await box.put('currentGroups', currentGroups);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Groups'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _shuffleGroups,
          ),
        ],
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green[700]!.withOpacity(0.8),
                    Colors.green[300]!.withOpacity(0.8)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(currentGroups.length, (index) {
                  return Column(
                    children: [
                      Text(
                        'Group ${index + 1}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        currentGroups[index].join(', '),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
