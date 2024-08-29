import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/student/components/reportCase.dart';
import 'package:uds_security_app/services/staffAndStudent/staff_services.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _deptController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  StaffServices staffServices = StaffServices();
  List<String> gender = ["Male", "Female"];

  void clearTextFields() {
    _passwordController.clear();
    _confirmPasswordController.clear();
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _phoneController.clear();
    _genderController.clear();
    _deptController.clear();
  }

  bool isLoading = false;
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final userModel = UserModel(
          userId: _userIdController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          middleName: _middleNameController.text,
          phone: _phoneController.text,
          gender: _genderController.text,
          role: "Student",
          department: _deptController.text);

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
            ToastMessage().showToast("Student added successfully");
            setState(() {
              isLoading = false;
            });
            clearTextFields();
          } else {
            ToastMessage().showToast("Student failed to add");
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
                  "Add Student".toUpperCase(),
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
                        'Student ID',
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
                          hintText: 'Student ID',
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
                            return 'Please enter your id';
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
                        'Email Address',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email Address',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          hintStyle: const TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        // validator: (value) {
                        //   if (value != null || value!.isNotEmpty) {
                        //     if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        //         .hasMatch(value)) {
                        //       return 'Please enter a valid email';
                        //     }
                        //   } else {}
                        //   return null;
                        // },
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
                        keyboardType: TextInputType.number,
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
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Please confirm your phone number';
                        //   }
                        //   if (_phoneController.text.length > 10 ||
                        //       _phoneController.text.length < 10) {
                        //     return 'Invalid phone number';
                        //   }
                        //   return null;
                        // },
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
                        'Department',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _deptController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Department',
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
                                            department.length,
                                            (index) {
                                              return StausTile(
                                                status: department[index],
                                                onTap: () {
                                                  setState(() {
                                                    _deptController.text =
                                                        department[index];
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
                            return 'Enter your your department';
                          }

                          return null;
                        },
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
                              "Add Student",
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

List<String> department = [
  "Food & Science",
  "Computer Science",
  "Mid-Wifery",
  "History"
];
