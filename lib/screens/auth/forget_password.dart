import 'package:flutter/material.dart';
import 'package:uds_security_app/services/auth/auth.dart';

import '../home/dashboard.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _comfirmPasswordController =
      TextEditingController();
  bool isEmailVerified = false;
  AuthServices authServices = AuthServices();

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _comfirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (isEmailVerified == false) {
        final result =
            await authServices.verifyEmail(email: _emailController.text);
        result.fold(
          (failure) {
            ToastMessage().showToast(failure);
            setState(() {
              isEmailVerified = false;
            });
          },
          (verified) {
            setState(() {
              isEmailVerified = verified;
            });
          },
        );
      } else {
        final result = await authServices.resetPassword(
            email: _emailController.text,
            password: _newPasswordController.text.trim());
        result.fold(
          (failure) {
            ToastMessage().showToast(failure);
            setState(() {
              isEmailVerified = false;
            });
          },
          (verified) {
            setState(() {
              isEmailVerified = verified;
              Navigator.of(context).pop();
            });
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
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
                        "Reset Password".toUpperCase(),
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
                  height: 32,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(16),
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20)),
                //     color: Colors.white.withOpacity(0.8),
                //     child: Padding(
                //       padding: const EdgeInsets.all(16.0),
                //       child: Form(
                //         key: _formKey,
                //         child: ListView(
                //           shrinkWrap: true,
                //           children: <Widget>[
                //             const Text(
                //               'Verify your email address',
                //               style: TextStyle(
                //                   fontSize: 22,
                //                   fontWeight: FontWeight.w600,
                //                   color: Colors.black),
                //             ),
                //             const SizedBox(
                //               height: 8,
                //             ),
                //             // TextFormField(
                //             //   controller: _comfirmPasswordController,
                //             //   decoration: InputDecoration(
                //             //     hintText: 'Provide your email address',
                //             //     filled: true,
                //             //     fillColor: Colors.white.withOpacity(0.8),
                //             //     hintStyle: const TextStyle(fontSize: 18),
                //             //     border: OutlineInputBorder(
                //             //       borderRadius: BorderRadius.circular(30),
                //             //       borderSide: BorderSide.none,
                //             //     ),
                //             //   ),
                //             //   keyboardType: TextInputType.emailAddress,
                //             //   validator: (value) {
                //             //     if (value == null || value.isEmpty) {
                //             //       return 'Please enter your name';
                //             //     }
                //             //     return null;
                //             //   },
                //             // ),
                //             // Visibility(
                //             //   visible: isEmailVerified,
                //             //   child: Column(
                //             //     crossAxisAlignment: CrossAxisAlignment.start,
                //             //     children: [
                //             //       const SizedBox(
                //             //         height: 16,
                //             //       ),
                //             //       const Text(
                //             //         'Enter your new password',
                //             //         style: TextStyle(
                //             //             fontSize: 22,
                //             //             fontWeight: FontWeight.w600,
                //             //             color: Colors.black),
                //             //       ),
                //             //       const SizedBox(
                //             //         height: 8,
                //             //       ),
                //             //       TextFormField(
                //             //         controller: _emailController,
                //             //         decoration: InputDecoration(
                //             //           hintText: 'New Passsword',
                //             //           filled: true,
                //             //           fillColor: Colors.white.withOpacity(0.8),
                //             //           hintStyle: const TextStyle(fontSize: 18),
                //             //           border: OutlineInputBorder(
                //             //             borderRadius: BorderRadius.circular(30),
                //             //             borderSide: BorderSide.none,
                //             //           ),
                //             //         ),
                //             //         validator: (value) {
                //             //           if (value == null || value.isEmpty) {
                //             //             return 'Please enter your email';
                //             //           }
                //             //           if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                //             //               .hasMatch(value)) {
                //             //             return 'Please enter a valid email';
                //             //           }
                //             //           return null;
                //             //         },
                //             //       ),
                //             //       const SizedBox(
                //             //         height: 16,
                //             //       ),
                //             //       const Text(
                //             //         'Comfirm your new password',
                //             //         style: TextStyle(
                //             //             fontSize: 22,
                //             //             fontWeight: FontWeight.w600,
                //             //             color: Colors.black),
                //             //       ),
                //             //       const SizedBox(
                //             //         height: 8,
                //             //       ),
                //             //       TextFormField(
                //             //         controller: _comfirmPasswordController,
                //             //         decoration: InputDecoration(
                //             //           hintText: 'Comfirm new password',
                //             //           filled: true,
                //             //           fillColor: Colors.white.withOpacity(0.8),
                //             //           hintStyle: const TextStyle(fontSize: 18),
                //             //           border: OutlineInputBorder(
                //             //             borderRadius: BorderRadius.circular(30),
                //             //             borderSide: BorderSide.none,
                //             //           ),
                //             //         ),
                //             //         obscureText: true,
                //             //         validator: (value) {
                //             //           if (value == null || value.isEmpty) {
                //             //             return 'Please enter your password';
                //             //           }
                //             //           if (value.length < 6) {
                //             //             return 'Password must be at least 6 characters long';
                //             //           }
                //             //           return null;
                //             //         },
                //             //       ),
                //             //       const SizedBox(
                //             //         height: 16,
                //             //       ),
                //             //     ],
                //             //   ),
                //             // ),
                //             const SizedBox(height: 60),
                //             ElevatedButton(
                //               style: const ButtonStyle(
                //                   backgroundColor:
                //                       WidgetStatePropertyAll(Colors.green)),
                //               onPressed: _submitForm,
                //               child: Padding(
                //                 padding: const EdgeInsets.all(16),
                //                 child: Text(
                //                   isEmailVerified ? 'Reset Now' : "Verify Now",
                //                   style: const TextStyle(
                //                       fontSize: 22,
                //                       fontWeight: FontWeight.w600,
                //                       color: Colors.white),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
