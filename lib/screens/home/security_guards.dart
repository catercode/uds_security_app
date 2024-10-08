import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';
import 'package:uds_security_app/screens/home/components/add_guard.dart';
import 'package:uds_security_app/screens/home/components/add_staff.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/home/duty_schedule_screen.dart';
import 'package:uds_security_app/screens/student/components/report.details.dart';
import 'package:uds_security_app/screens/student/components/reportCase.dart';
import 'package:uds_security_app/screens/student/profile.dart';
import 'package:uds_security_app/services/staffAndStudent/staff_services.dart';

class AllGuard extends StatefulWidget {
  const AllGuard({super.key});

  @override
  State<AllGuard> createState() => _AllGuardState();
}

class _AllGuardState extends State<AllGuard> {
  final staffServices = StaffServices();
  List<UserModel> listofStaff = [];
  bool isLoading = false;
  int dataCount = 0;

  bool statLoading = false;

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadGuard();
      getTotal("guard");
    });
    super.initState();
  }

  loadGuard() async {
    setState(() {
      isLoading = true;
    });
    await staffServices.getAllStaff(status: "guard").then((data) {
      data.fold(
        (failure) {
          log(failure);
          ToastMessage().showToast(failure);
          setState(() {
            isLoading = false;
          });
        },
        (data) {
          setState(() {
            isLoading = false;
            listofStaff = data;
          });
          getTotal("guard");
        },
      );
      // if (mounted) {

      // }
    });
  }

  getTotal(String role) async {
    setState(() {
      statLoading = true;
    });
    await staffServices.getStaffByRole(role: role).then((data) {
      data.fold(
        (failure) {
          log(failure);
          ToastMessage().showToast(failure);
          setState(() {
            statLoading = false;
            dataCount = 0;
          });
        },
        (data) {
          setState(() {
            dataCount = data;
            statLoading = false;
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3,
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
                    loadGuard();
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
                          child: AddGuardScreen(),
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
          child: Column(
            children: [
              const CustomSafeArea(),
              SafeArea(
                child: Padding(
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
                        "SECURITY GUARDS ".toUpperCase(),
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      const SizedBox()
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: ResponsiveWrapper.of(context).scaledWidth,
                        child: ActivityCard(
                          mainAxisAlignment: MainAxisAlignment.center,
                          icon: Icons.person,
                          title: "TOTAL GUARDS",
                          value: dataCount.toString(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.only(top: 32),
                      height: MediaQuery.of(context).size.height * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Visibility(
                          visible: !isLoading,
                          replacement: const Center(
                              child: SpinKitFadingCircle(
                            color: Colors.green,
                          )),
                          child: Visibility(
                            visible: listofStaff.isNotEmpty,
                            replacement: const Column(
                              children: [
                                SizedBox(height: 200),
                                Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.grey,
                                ),
                                Text("No guard found",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ))
                              ],
                            ),
                            child: ListView.separated(
                              padding: const EdgeInsets.only(top: 0, bottom: 0),
                              shrinkWrap: true,
                              itemCount: listofStaff.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const ReportDetail()));
                                    },
                                    child: SecurityInfoCard(
                                      //
                                      guard: listofStaff[index],
                                    ));
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class StudentInfoCardS extends StatelessWidget {
//   const StudentInfoCardS({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         const CircleAvatar(
//           radius: 30,
//           backgroundImage: AssetImage(
//               'assets/images/student.jpg'), // Replace with your image path
//         ),
//         const SizedBox(width: 20),
//         Expanded(
//           flex: 6,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const Text(
//                 'John Paul',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 'Bussiness',
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const Text(
//           '2017',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }
