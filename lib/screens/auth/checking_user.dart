import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uds_security_app/const/enums/position.dart';
import 'package:uds_security_app/screens/auth/login.dart';
import 'package:uds_security_app/screens/guard/guard.screen.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/student/student.dart';
import 'package:uds_security_app/services/auth/hive_auth_user.dart';

class ValidationUser extends StatefulWidget {
  const ValidationUser({super.key});

  @override
  State<ValidationUser> createState() => _ValidationUserState();
}

class _ValidationUserState extends State<ValidationUser> {
  HiveAuthServices hiveAuthServices = HiveAuthServices();

  @override
  void initState() {
    checkingUser();
    super.initState();
  }

  checkingUser() async {
    final currentUser = await hiveAuthServices.hasUserLogin();

    currentUser.fold((failure) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
    }, (user) {
      log("$user");
      Future.delayed(const Duration(seconds: 3), () async {
        if (user.role == Position.staffAdmin.name) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DashboardPage(currentUser: user)),
          );
        } else if (user.role == Position.staff.name) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DashboardPage(currentUser: user)),
          );
        } else if (user.role == Position.student.name) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => StudentHome(student: user)),
          );
          
        }else if (user.role == Position.guard.name) {
         Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => GaurdHome(currentUser: user)),
          );  
        }
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) =>
        //            ///StudentHome(student: user,)
        //           //Navigator.push(
        //           //    context,
        //           //    MaterialPageRoute(builder: (context) =>
        //            GaurdHome(currentUser: user)
        //           //DashboardPage(currentUser: user),
          //  ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpinKitFadingCircle(
            color: Colors.green,
            size: 50,
          ),
          const SizedBox(height: 30),
          Text(
            "User Authentication".toUpperCase(),
            style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                //  fontFamily: "UKNumberPlate",
                fontWeight: FontWeight.bold),
          ),
          const Text(
            "Please Wait ....",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                //  fontFamily: "UKNumberPlate",
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
