import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:uds_security_app/const/enums/position.dart';
import 'package:uds_security_app/models/unitModel/unit.model.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/student/components/reportCase.dart';
import 'package:uds_security_app/services/security/units_services.dart';
import 'package:uds_security_app/services/staffAndStudent/staff_services.dart';

class AddGuardScreen extends StatefulWidget {
  const AddGuardScreen({super.key});

  @override
  _AddGuardScreenState createState() => _AddGuardScreenState();
}

class _AddGuardScreenState extends State<AddGuardScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _rankController = TextEditingController();
  StaffServices staffServices = StaffServices();
  final unitServices = UnitServices();
  final TextEditingController _unitNameController = TextEditingController();
  List<String> gender = ["Male", "Female"];

  @override
  void dispose() {
    _middleNameController.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userIdController.dispose();
    _unitNameController.dispose();

    super.dispose();
  }

  void clearTextFields() {
    _emailController.clear();
    _userIdController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _phoneController.clear();
    _genderController.clear();
    _unitNameController.clear();
  }

  void _submitForm() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        final userModel = UserModel(
          rank: _rankController.text,
          userId: _userIdController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          middleName: _middleNameController.text,
          phone: _phoneController.text,
          gender: _genderController.text,
          role: Position.guard.name,
        );

        final result = await staffServices.addNewStaff(user: userModel);
        result.fold(
          (failure) {
            ToastMessage().showToast(failure!);
            setState(() {
              isLoading = false;
            });
          },
          (verified) {
            if (verified) {
              ToastMessage().showToast("Guard added successfully");
              setState(() {
                isLoading = false;
              });
              clearTextFields();
            } else {
              ToastMessage().showToast("Failed to add guard");
              setState(() {
                isLoading = false;
              });
            }
          },
        );
      }
    } catch (e) {
      log("==========================$e");
      ToastMessage().showToast("Something went wrong try again");
    }
  }

  @override
  void initState() {
    loadUnits();
    super.initState();
  }

  bool isLoading = false;
  UnitModel userId = UnitModel();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveWrapper.of(context).scaledHeight,
      decoration: const BoxDecoration(),
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
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => const ProfileScreen(),
                      // ));
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.green,
                    )),
                Text(
                  "Add Guard".toUpperCase(),
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
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.white.withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      const Text(
                        'Staff ID',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _userIdController,
                        decoration: InputDecoration(
                          hintText: 'Staff ID',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          hintStyle: const TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your staff id';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'First Name',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          hintStyle: const TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Middle Name',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _middleNameController,
                        decoration: InputDecoration(
                          hintText: 'Middle Namae',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          hintStyle: const TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your middle name';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Last Name',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          hintStyle: const TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your last name';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Phone Number',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          hintStyle: const TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Gender',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _genderController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Gender',
                          filled: true,
                          suffixIcon: InkWell(
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
                                            gender.length,
                                            (index) {
                                              return StausTile(
                                                status: gender[index],
                                                onTap: () {
                                                  setState(() {
                                                    _genderController.text =
                                                        gender[index];
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
                          fillColor: Colors.white.withOpacity(0.8),
                          hintStyle: const TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your last name';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Rank',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      TextFormField(
                        controller: _rankController,
                        decoration: InputDecoration(
                          hintText: 'Rank',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          hintStyle: const TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // const Text(
                      //   'Unit',
                      //   style: TextStyle(
                      //       fontSize: 22,
                      //       fontWeight: FontWeight.w600,
                      //       color: Colors.black),
                      // ),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // TextFormField(
                      //   controller: _unitNameController,
                      //   readOnly: true,
                      //   decoration: InputDecoration(
                      //     hintText: 'Unit',
                      //     filled: true,
                      //     fillColor: Colors.white.withOpacity(0.8),
                      //     hintStyle: const TextStyle(fontSize: 18),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(30),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //     suffixIcon: InkWell(
                      //         onTap: () {
                      //           showModalBottomSheet(
                      //             isScrollControlled: true,
                      //             context: context,
                      //             builder: (BuildContext context) {
                      //               return CustomerModalSheet(
                      //                 child: Column(
                      //                   mainAxisSize: MainAxisSize.min,
                      //                   children: <Widget>[
                      //                     ...List.generate(
                      //                       listofUnit.length,
                      //                       (index) {
                      //                         return StausTile(
                      //                           status: listofUnit[index]
                      //                               .unitName!,
                      //                           onTap: () {
                      //                             setState(() {
                      //                               _unitNameController.text =
                      //                                   listofUnit[index]
                      //                                       .unitName!;
                      //                               userId =
                      //                                   listofUnit[index];
                      //                             });
                      //                             Navigator.pop(context);
                      //                           },
                      //                         );
                      //                       },
                      //                     )
                      //                   ],
                      //                 ),
                      //               );
                      //             },
                      //           );
                      //         },
                      //         child: const Icon(Icons.arrow_drop_down)),
                      //   ),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please select a unit';
                      //     }

                      //     return null;
                      //   },
                      // ),
                      const SizedBox(height: 60),
                      Visibility(
                        visible: !isLoading,
                        replacement: const SpinKitFadingCircle(
                          color: Colors.green,
                        ),
                        child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.green)),
                          onPressed: _submitForm,
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "Add",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
