import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:uds_security_app/const/enums/func.dart';
import 'package:uds_security_app/models/unitModel/unit.model.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';
import 'package:uds_security_app/screens/home/components/assigned_guard_to_unit.dart';
import 'package:uds_security_app/screens/home/components/add_units.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/student/components/reportCase.dart';
import 'package:uds_security_app/services/auth/auth.dart';
import 'package:uds_security_app/services/security/units_services.dart';
import 'package:uds_security_app/services/staffAndStudent/staff_services.dart';

List<UnitModel> listofUnit = [];

class SecurityGroupsScreen extends StatefulWidget {
  const SecurityGroupsScreen({super.key});

  @override
  State<SecurityGroupsScreen> createState() => _SecurityGroupsScreenState();
}

class _SecurityGroupsScreenState extends State<SecurityGroupsScreen> {
  final staffServices = StaffServices();
  final unitServices = UnitServices();
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
    listofUnit.clear();
    await unitServices.getUnits().then((data) {
      data.fold(
        (failure) {
          ToastMessage().showToast(failure);
          setState(() {
            isLoading = false;
          });
        },
        (data) {
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
            Visibility(
              visible: !isLoading,
              replacement:
                  const Center(child: SpinKitFadingCircle(color: Colors.white)),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ExpansionPanelListExample(
                    listOfUnits: listofUnit,
                  ),
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
  // final staffServices = StaffServices();
  // bool isLoading = false;
  // getGuardsUnderUnits() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   await staffServices.getUnitsGaurds("").then((data) {
  //     data.fold(
  //       (failure) {
  //         log("======================$failure");
  //         ToastMessage().showToast(failure);
  //         setState(() {
  //           isLoading = false;
  //         });
  //       },
  //       (data) {
  //         log("======================$data");
  //         setState(() {
  //           isLoading = false;
  //         });
  //       },
  //     );

  //   });
  // }

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
  final unitServices = UnitServices();
  List<UserModel> listofAssignedGuards = [];
  bool isLoading = false;
  bool isDeleting = false;
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
    await unitServices.getUnitsGaurds(widget.unit.unitId).then((data) {
      data.fold(
        (failure) {
          log("======================$failure");
          ToastMessage().showToast(failure);
          setState(() {
            isLoading = false;
          });
        },
        (data) {
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

  deleteUnit() async {
    isDeleting = true;
    await unitServices.deleteUnitsGuardById(id: widget.unit.unitId!).then(
      (data) {
        data.fold(
          (failure) {
            setState(() {
              isDeleting = false;
            });
            ToastMessage().showToast(failure);
          },
          (data) async {
            setState(() {
              isDeleting = false;
            });

            ToastMessage().showToast("Unit deleted successfully");
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              widget.unit.unitName!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return CustomerModalSheet(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              "Are you sure you want to delete  ${widget.unit.unitName!} ?",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: !isDeleting,
                                replacement: const SpinKitFadingCircle(
                                  color: Colors.black,
                                  size: 30,
                                ),
                                child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.redAccent)),
                                    onPressed: () {
                                
                                      deleteUnit();
                                    },
                                    child: const Text("Yes",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "No",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
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
                      //  log("======listofAssignedGuards================${listofAssignedGuards[index]}");
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16, left: 16, right: 16),
                        child: SecurityInfoCard(
                          oldUnit: widget.unit,
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
  const SecurityInfoCard({super.key, this.oldUnit, required this.guard});
  final UserModel guard;
  final UnitModel? oldUnit;
  @override
  State<SecurityInfoCard> createState() => _SecurityInfoCardState();
}

class _SecurityInfoCardState extends State<SecurityInfoCard> {
  final bool _isExpanded = false;
  String indexId = "";
  bool isLoading = false;

  bool assignLoading = false;
  final staffServices = StaffServices();
  final unitServices = UnitServices();
  final authServices = AuthServices();

  reasignGuard({required UnitModel newUnit}) async {
    setState(() {
      assignLoading = true;
    });
    indexId = widget.guard.userId!;
    // ToastMessage().showToast("Guard reasigned successfully");
    await unitServices
        .reasignGuard(
            newUnit: newUnit, oldUnit: widget.oldUnit!, guard: widget.guard)
        .then((data) {
      data.fold(
        (failure) {
          setState(() {
            assignLoading = false;
            indexId = "";
          });
          ToastMessage().showToast(failure);
        },
        (data) async {
          await authServices.updateGuard(
              userid: widget.guard.id!, unit: newUnit.unitName!);
          setState(() {
            assignLoading = false;
            indexId = "";
          });
          ToastMessage().showToast("Guard reasigned successfully");
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 30,
          child: Text(
            getInitials("${widget.guard.firstName} ${widget.guard.lastName}"),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.guard.firstName!} ${widget.guard.lastName!}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.guard.rank.toString(),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        // const Column(
        //   children: [],
        // ),
        // const SizedBox(
        //   width: 16,
        // ),
        Visibility(
          visible: true,
          child: InkWell(
            onTap: () {
              log("======listofAssignedGuards==$indexId==============${widget.guard.userId}");
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return CustomerModalSheet(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ...List.generate(
                          listofUnit.length,
                          (index) {
                            return StausTile(
                              status: listofUnit[index].unitName!,
                              onTap: () async {
                                await reasignGuard(newUnit: listofUnit[index]);
                                // setState(() {});
                                Navigator.pop(context);
                              },
                            );
                          },
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: Visibility(
              visible: indexId != widget.guard.userId,
              replacement: const SpinKitFadingCircle(
                color: Colors.black,
                size: 30,
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.info,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  Text(
                    'Action',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
