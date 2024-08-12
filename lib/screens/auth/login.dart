import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uds_security_app/const/enums/position.dart';
import 'package:uds_security_app/screens/auth/forget_password.dart';
import 'package:uds_security_app/screens/auth/signup.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/student/student.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:uds_security_app/services/auth/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false;
  final TextEditingController _idController = TextEditingController();
  TextEditingController passController = TextEditingController();
  AuthServices authServices = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final result = await authServices.login(
          sid: _idController.text, password: passController.text);
      result.fold(
        (failure) => {
          ToastMessage().showToast(failure),
          setState(() {
            isLoading = false;
          }),
        },
        (success) {
          ToastMessage().showToast("Login successful");

          if (success.role == Position.staff.name) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
            setState(() {
              isLoading = false;
            });
          } else if (success.role == Position.student.name) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const StudentHome()),
            );

            setState(() {
              isLoading = false;
            });
          }
          //  else {
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(builder: (context) => const StudentHome()),
          //   );

          //   setState(() {
          //     isLoading = false;
          //   });
          // }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.jpg', // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
            // Green gradient overlay
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
            // Login form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "UDS".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 70,
                        color: Colors.white,
                        fontFamily: "UKNumberPlate",
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Security App".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign in to continue".toUpperCase(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _idController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person,
                                size: 25, color: Colors.green),
                            hintText: 'Staff or Student id',
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
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock,
                                size: 25, color: Colors.green),
                            hintText: 'Password',
                            filled: true,
                            hintStyle: const TextStyle(fontSize: 18),
                            fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      rememberMe = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  "Remember Me",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ForgetPassword(),
                                ));
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Visibility(
                          visible: !isLoading,
                          replacement: const SpinKitFadingCircle(
                            color: Colors.green,
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                _submitForm();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen()));
                            },
                            child: const Text(
                              "Create Account",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String login({required String email, required String password}) {
  if (email == "staff@gmail.com" && password == "123456") {
    return "Staff";
  } else if (email == "student@gmail.com" && password == "123456") {
    return "Staudent";
  } else {
    return "";
  }
}
