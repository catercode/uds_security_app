import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:uds_security_app/const/enums/position.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/student/components/reportCase.dart';
import 'package:uds_security_app/services/auth/auth.dart';

class ValidateUserScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String address;
  final String middleName;

  final String phone;

  const ValidateUserScreen(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.address,
      required this.middleName,
      required this.phone});

  @override
  _ValidateUserScreenState createState() => _ValidateUserScreenState();
}

class _ValidateUserScreenState extends State<ValidateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  AuthServices authServices = AuthServices();

  @override
  void dispose() {
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });
      // Perform signup action (e.g., send data to server)
      final userModel = UserModel(
        role: _roleController.text,
        phone: widget.phone,
        userId: _userIdController.text,
        firstName: widget.firstName,
        lastName: widget.lastName,
        email: widget.email,
        password: widget.password,
        address: widget.address,
        middleName: widget.middleName,
      );
      final result = await authServices.register(user: userModel);
      if (result.isRight()) {
        ToastMessage().showToast("Account created successfully");
        setState(() {
          isLoading = false;
        });
      } else {
        ToastMessage().showToast("Failed to create account");
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  bool isLoading = false;
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
          child: Column(
            children: [
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
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => const ProfileScreen(),
                          // ));
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    Text(
                      "User Validation".toUpperCase(),
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
                height: 60,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
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
                              'Select Position',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: _roleController,
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: 'Select Position',
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.8),
                                  hintStyle: const TextStyle(fontSize: 18),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomerModalSheet(
                                            child: SizedBox(
                                              width:
                                                  ResponsiveWrapper.of(context)
                                                      .scaledWidth,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ...List.generate(
                                                    Position.values.length,
                                                    (index) => InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          _roleController.text =
                                                              Position
                                                                  .values[index]
                                                                  .name
                                                                  .toString();
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 16),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              Position
                                                                  .values[index]
                                                                  .name
                                                                  .toString()
                                                                  .toUpperCase(),
                                                              style: const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                            const Divider(
                                                              color:
                                                                  Colors.green,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Icon(
                                        Icons.arrow_drop_down_outlined),
                                  )),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your position';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              'Enter staff or student',
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
                                hintText: 'UDS-21948DHS',
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
                                  return 'Please enter your email';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const SizedBox(height: 30),
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
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
