import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:uds_security_app/screens/home/list_of_staff.dart';

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
      // appBar: AppBar(
      //   title: const Text('Security Groups'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.refresh),
      //       onPressed: _shuffleGroups,
      //     ),
      //   ],
      //   backgroundColor: Colors.green,
      // ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/background.jpg'),
        )),
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
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Security Groups".toUpperCase(),
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const SizedBox()
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.only(top: 32),
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 3,
                  itemBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: GroupTileCard(),
                  ),
                ),
              ))
              // Container(
              //   width: ResponsiveWrapper.of(context).scaledWidth,
              //   padding: const EdgeInsets.all(20),
              //   margin: const EdgeInsets.all(20),
              //   decoration: BoxDecoration(
              //     color: Colors.white.withOpacity(0.9),
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: List.generate(currentGroups.length, (index) {
              //       return Column(
              //         children: [
              //           Text(
              //             'Group ${index + 1}',
              //             style: const TextStyle(
              //               fontSize: 20,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           Text(
              //             currentGroups[index].join(', '),
              //             style: const TextStyle(
              //               fontSize: 16,
              //             ),
              //           ),
              //           const SizedBox(height: 10),
              //         ],
              //       );
              //     }),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class GroupTileCard extends StatelessWidget {
  const GroupTileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedTextColor: Colors.white,
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      collapsedBackgroundColor: Colors.white.withOpacity(0.8),
      backgroundColor: Colors.green.withOpacity(0.5),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Group 1",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            "Week1",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      children: [
        ...List.generate(
          4,
          (index) => SizedBox(
              width: ResponsiveWrapper.of(context).scaledWidth,
              child: const Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: SecurityInfoCard(),
                  ))),
        )
      ],
    );
  }
}

class SecurityInfoCard extends StatelessWidget {
  const SecurityInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(
              'assets/images/student.jpg'), // Replace with your image path
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'John Paul',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'A1 Unit',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        const Column(
          children: [
            Text(
              'Rank',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Rk001',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
