import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:uds_security_app/models/unitModel/unit.model.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/student/components/reportCase.dart';
import 'package:uds_security_app/services/staffAndStudent/staff_services.dart';

class AddUnitScreen extends StatefulWidget {
  const AddUnitScreen({super.key});

  @override
  _AddUnitScreenState createState() => _AddUnitScreenState();
}

class _AddUnitScreenState extends State<AddUnitScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unitNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  StaffServices staffServices = StaffServices();

  void clearTextFields() {
    _unitNameController.clear();
    _locationController.clear();
    _statusController.clear();
    _dateController.clear();
  }

  bool isLoading = false;
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final unitModel = UnitModel(
        unitName: _unitNameController.text,
        location: _locationController.text,
        date: _dateController.text,
        status: _statusController.text,
      );

      final result = await staffServices.addNewUnit(unit: unitModel);
      result.fold(
        (failure) {
          ToastMessage().showToast(failure!);
          setState(() {
            isLoading = false;
          });
        },
        (verified) {
          if (verified) {
            ToastMessage().showToast("Unit added successfully");
            setState(() {
              isLoading = false;
            });
            clearTextFields();
          } else {
            ToastMessage().showToast("Unit failed to add");
            setState(() {
              isLoading = false;
            });
          }
        },
      );
    }
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
                    "Add Unit".toUpperCase(),
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
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      const Text(
                        'Unit Name',
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
                        decoration: InputDecoration(
                          hintText: 'Unit Name',
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
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Location',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          hintText: 'Location',
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
                            return 'Please enter your unit location';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Status',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _statusController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Enable',
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
                                            status.length,
                                            (index) {
                                              return StausTile(
                                                status: status[index],
                                                onTap: () {
                                                  setState(() {
                                                    _statusController.text =
                                                        status[index];
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
                      ),
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
                              "Add Unit",
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
          ],
        ),
      ),
    );
  }
}

List status = ["Enable", "Disable"];
