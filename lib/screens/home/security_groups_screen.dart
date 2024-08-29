import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:uds_security_app/models/unitModel/unit.model.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';
import 'package:uds_security_app/screens/home/components/add_guard_to_unit.dart';
import 'package:uds_security_app/screens/home/components/add_units.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/student/components/reportCase.dart';
import 'package:uds_security_app/services/staffAndStudent/staff_services.dart';

class SecurityGroupsScreen extends StatefulWidget {
  const SecurityGroupsScreen({super.key});

  @override
  State<SecurityGroupsScreen> createState() => _SecurityGroupsScreenState();
}

class _SecurityGroupsScreenState extends State<SecurityGroupsScreen> {
  final staffServices = StaffServices();
  List<UnitModel> listofUnit = [];
  bool isLoading = false;
  // int femaleCount = 0;
  // int maleCount = 0;
  bool statLoading = false;

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadUnits();
      // getTotal("Female");
      // getTotal("Male");
    });
    super.initState();
  }

  loadUnits() async {
    setState(() {
      isLoading = true;
    });
    await staffServices.getUnits().then((data) {
      data.fold(
        (failure) {
          log("======================$failure");
          ToastMessage().showToast(failure);
          setState(() {
            isLoading = false;
          });
        },
        (data) {
          log("======================$data");
          setState(() {
            listofUnit = data;
            isLoading = false;
          });
        },
      );
      // if (mounted) {

      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.green,
            onPressed: null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    loadUnits();
                  },
                  child: const Card(
                    color: Colors.white,
                    child: Icon(
                      Icons.refresh,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return const CustomerModalSheet(
                          child: AddUnitScreen(),
                        );
                      },
                    );
                  },
                  child: const Card(
                    color: Colors.white,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return const CustomerModalSheet(
                          child: AddGuardToUnitScreen(),
                        );
                      },
                    );
                  },
                  child: const Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.person_add_alt_outlined,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ExpansionPanelListExample(
                  listOfUnits: listofUnit,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class ExpansionPanelListExample extends StatefulWidget {
  const ExpansionPanelListExample({super.key, required this.listOfUnits});
  final List<UnitModel> listOfUnits;
  @override
  _ExpansionPanelListExampleState createState() =>
      _ExpansionPanelListExampleState();
}

class _ExpansionPanelListExampleState extends State<ExpansionPanelListExample> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
            widget.listOfUnits.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: UnitExpandedTile(
                unit: widget.listOfUnits[index],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class UnitExpandedTile extends StatefulWidget {
  const UnitExpandedTile({super.key, required this.unit});
  final UnitModel unit;

  @override
  State<UnitExpandedTile> createState() => _UnitExpandedTileState();
}

class _UnitExpandedTileState extends State<UnitExpandedTile> {
  final staffServices = StaffServices();
  List<UserModel> listofAssignedGuards = [];
  bool isLoading = false;
  // int femaleCount = 0;
  // int maleCount = 0;
  bool statLoading = false;

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadGaurd();
      // getTotal("Female");
      // getTotal("Male");
    });
    super.initState();
  }

  loadGaurd() async {
    setState(() {
      isLoading = true;
    });
    await staffServices.getUnitsGaurds(widget.unit.unitId).then((data) {
      data.fold(
        (failure) {
          log("======================$failure");
          ToastMessage().showToast(failure);
          setState(() {
            isLoading = false;
          });
        },
        (data) {
          log("======================$data");
          setState(() {
            listofAssignedGuards = data;
            isLoading = false;
          });
        },
      );
      // if (mounted) {

      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        title: Text(
          widget.unit.unitName!,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        children: [
          SizedBox(
            height: ResponsiveWrapper.of(context).scaledHeight * 0.4,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(
                    listofAssignedGuards.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16, left: 16, right: 16),
                        child: SecurityInfoCard(
                          guard: listofAssignedGuards[index],
                        ),
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

class SecurityInfoCard extends StatefulWidget {
  const SecurityInfoCard({super.key, required this.guard});
  final UserModel guard;
  @override
  State<SecurityInfoCard> createState() => _SecurityInfoCardState();
}

class _SecurityInfoCardState extends State<SecurityInfoCard> {
  @override
  bool _isExpanded = false;
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
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Visibility(
            visible: !_isExpanded,
            replacement: const Icon(
              Icons.radio_button_checked_outlined,
              size: 40,
            ),
            child: const Icon(
              Icons.radio_button_off_outlined,
              size: 40,
            ),
          ),
        )
      ],
    );
  }
}
