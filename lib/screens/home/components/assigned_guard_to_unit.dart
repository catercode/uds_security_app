import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:uds_security_app/const/enums/func.dart';
import 'package:uds_security_app/models/unitModel/unit.model.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/home/list_of_staff.dart';
import 'package:uds_security_app/screens/student/components/reportCase.dart';
import 'package:uds_security_app/services/auth/auth.dart';
import 'package:uds_security_app/services/security/units_services.dart';
import 'package:uds_security_app/services/staffAndStudent/staff_services.dart';

class AddGuardToUnitScreen extends StatefulWidget {
  const AddGuardToUnitScreen({super.key});

  @override
  _AddGuardToUnitScreenState createState() => _AddGuardToUnitScreenState();
}

class _AddGuardToUnitScreenState extends State<AddGuardToUnitScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unitNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  StaffServices staffServices = StaffServices();
  final unitServices = UnitServices();

  void clearTextFields() {
    _unitNameController.clear();
    _locationController.clear();
    _statusController.clear();
    _dateController.clear();
  }

  bool isLoading = false;
  bool isAssignLoading = false;
  @override
  void initState() {
    loadGaurd();
    loadUnits();
    super.initState();
  }

  List<UnitModel> listofUnit = [];
  loadUnits() async {
    setState(() {
      isLoading = true;
    });
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

  UnitModel userId = UnitModel();
  List<UserModel> listofGuard = [];
  loadGaurd() async {
    setState(() {
      isLoading = true;
    });
    await staffServices.getAllGaurdNotAssigned(status: "guard").then((data) {
      data.fold(
        (failure) {
          ToastMessage().showToast(failure);
          setState(() {
            isLoading = false;
          });
        },
        (data) {
          log("==========1111============$data");
          setState(() {
            listofGuard = data;
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
    return Container(
      height: ResponsiveWrapper.of(context).scaledHeight,
      decoration: const BoxDecoration(),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 64,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => const ProfileScreen(),
                        // ));
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.green,
                      )),
                  Text(
                    "Assign Guard".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.green),
                  ),
                  const SizedBox()
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Unit',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _unitNameController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Select unit to assign guard to.',
                    filled: true,
                    suffixIcon: Visibility(
                      visible: !isLoading,
                      replacement: const SpinKitFadingCircle(
                        color: Colors.green,
                      ),
                      child: InkWell(
                          onTap: () {
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
                                            onTap: () {
                                              setState(() {
                                                _unitNameController.text =
                                                    listofUnit[index].unitName!;
                                                userId = listofUnit[index];
                                              });
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
                          child: const Icon(Icons.arrow_drop_down)),
                    ),
                    fillColor: Colors.white.withOpacity(0.8),
                    hintStyle: const TextStyle(fontSize: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: SizedBox(
                width: ResponsiveWrapper.of(context).scaledWidth,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.white.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Visibility(
                      visible: !isLoading,
                      replacement: const SpinKitFadingCircle(
                        color: Colors.green,
                      ),
                      child: Visibility(
                        visible: listofGuard.isNotEmpty,
                        replacement: const Column(
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            Icon(
                              Icons.person,
                              size: 100,
                              color: Colors.grey,
                            ),
                            Text(
                              "No guard found",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            const SizedBox(
                              height: 16,
                            ),
                            ...List.generate(listofGuard.length, (index) {
                              return GaurdInfoCard(
                                unit: userId,
                                staff: listofGuard[index],
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GaurdInfoCard extends StatefulWidget {
  const GaurdInfoCard({
    super.key,
    required this.staff,
    required this.unit,
  });
  final UserModel staff;
  final UnitModel unit;

  @override
  State<GaurdInfoCard> createState() => _GaurdInfoCardState();
}

class _GaurdInfoCardState extends State<GaurdInfoCard> {
  bool isChecked = false;
  bool isAssignLoading = false;
  final staffServices = StaffServices();
  final unitServices = UnitServices();
  final authServices = AuthServices();
  // int femaleCount = 0;
  // int maleCount = 0;
  bool statLoading = false;

  void _assignGaurd() async {
    setState(() {
      isAssignLoading = true;
    });

    final result = await unitServices.assignedGuard(
        unit: widget.unit, guard: widget.staff);
    result.fold(
      (failure) {
        ToastMessage().showToast(failure);
        setState(() {
          isAssignLoading = false;
        });
      },
      (verified) async {
        if (verified) {
          await authServices.updateGuard(
              userid: widget.staff.id!, unit: widget.unit.unitName!);
          ToastMessage().showToast("Guard added successfully");
          setState(() {
            isAssignLoading = false;
          });
        } else {
          ToastMessage().showToast("Guard failed to add");
          setState(() {
            isAssignLoading = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.green[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Text(
                getInitials(
                    "${widget.staff.firstName} ${widget.staff.lastName}"),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ), // Replace with your image path
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${widget.staff.firstName}  ${widget.staff.lastName}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.staff.rank.toString(),
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
            const SizedBox(
              width: 16,
            ),
            InkWell(
              onTap: () {
                if (widget.unit.unitId == null) {
                  ToastMessage()
                      .showToast("Select unit before assigning guard");
                  return;
                }
                setState(() {
                  isChecked = !isChecked;
                  if (isChecked == true) {
                    _assignGaurd();
                  }
                });
              },
              child: Visibility(
                visible: !isAssignLoading,
                replacement: const SpinKitFadingCircle(
                  color: Colors.black,
                  size: 30,
                ),
                child: Visibility(
                  visible: !isChecked,
                  replacement: const Icon(
                    Icons.radio_button_checked_outlined,
                    size: 40,
                  ),
                  child: const Icon(
                    Icons.radio_button_off_outlined,
                    size: 40,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
