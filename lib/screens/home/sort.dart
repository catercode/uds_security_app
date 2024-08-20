import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class SecurityGroupsScreen extends StatefulWidget {
  const SecurityGroupsScreen({super.key});

  @override
  State<SecurityGroupsScreen> createState() => _SecurityGroupsScreenState();
}

class _SecurityGroupsScreenState extends State<SecurityGroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(children: [
            const SizedBox(
              height: 60,
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
                      "Duty Schedule".toUpperCase(),
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const SizedBox()
                  ]),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: ExpansionPanelListExample(),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class ExpansionPanelListExample extends StatefulWidget {
  const ExpansionPanelListExample({super.key});

  @override
  _ExpansionPanelListExampleState createState() =>
      _ExpansionPanelListExampleState();
}

class _ExpansionPanelListExampleState extends State<ExpansionPanelListExample> {
  final List<String> units = [
    "Unit A",
    "Unit B",
    "Unit C",
    "Unit D",
    "Unit E",
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
            units.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: UnitExpandedTile(
                unit: units[index],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class UnitExpandedTile extends StatelessWidget {
  const UnitExpandedTile({super.key, required this.unit});
  final String unit;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        title: Text(
          unit,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        children: [
          SizedBox(
            height: ResponsiveWrapper.of(context).scaledHeight * 0.4,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(
                    5,
                    (index) {
                      return const Padding(
                        padding:
                            EdgeInsets.only(bottom: 16, left: 16, right: 16),
                        child: SecurityInfoCard(),
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ]);
  }
}

// Define a model class for each item

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
        const SizedBox(
          width: 16,
        ),
        const Icon(
          Icons.radio_button_checked_outlined,
          size: 40,
        )
      ],
    );
  }
}
