import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:uds_security_app/const/enums/func.dart';
import 'package:uds_security_app/models/Notification/notification.api.dart';
import 'package:uds_security_app/models/caseModel/case.model.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';
import 'package:uds_security_app/screens/auth/login.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/student/components/report.details.dart';
import 'package:uds_security_app/screens/student/components/reportCase.dart';
import 'package:uds_security_app/screens/student/profile.dart';
import 'package:uds_security_app/services/auth/hive_auth_user.dart';
import 'package:uds_security_app/services/case/cases_services.dart';
import 'package:uds_security_app/services/security/units_services.dart';
import 'package:uds_security_app/services/staffAndStudent/staff_services.dart';
import 'package:uds_security_app/services/student/student.services.dart';

class StudentHome extends StatefulWidget {
  final UserModel student;
  const StudentHome({super.key, required this.student});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final staffServices = StaffServices();
  final studentServices = StudentServices();
  final unitServices = UnitServices();

  CaseModel? caseNotiModel;
  String unitNaame = 'Loading...';
  HiveAuthServices hiveAuthServices = HiveAuthServices();
  // NoticationApi noticationApi = NoticationApi();
  int totalStaff = 0;
  int totalStudent = 0;
  bool statLoading = false;
  bool isPostLoading = false;

  List<CaseModel> listofCases = [];
  StreamSubscription<DocumentSnapshot>? _subscription;

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadAllCasesByStudentId();

      _listenToNotificationStream();
    });
    super.initState();
  }

  void _listenToNotificationStream() {
    final stream = studentServices.studentNiotification(
      reporterId: widget.student.userId!,
    );

    if (stream != null) {
      _subscription = stream.listen((snapshot) {
        if (snapshot.exists) {
          var document = snapshot.data() as Map<String, dynamic>;

          caseNotiModel = CaseModel.fromJson(document);

          if (!listofCases.contains(caseNotiModel)) {
            setState(() {
              listofCases.add(caseNotiModel!);
            });
          }
          NotificationService.showInstantNotification(
            title: "Case report",
            body: caseNotiModel?.quickReport ?? '',
          );
        }
      });
    } else {
      // Handle the case where the stream is null
      log('The guardNotification stream is null. Cannot listen for notifications.');
    }
  }

  @override
  void dispose() {
    _subscription
        ?.cancel(); // Cancel the stream subscription when the widget is disposed
    super.dispose();
  }

  int totalResolvecases = 0;
  int totalUnResolvecases = 0;

  bool isLoading = false;
  loadAllCasesByStudentId() async {
    setState(() {
      isLoading = true;
    });
    getTotalCases("false");
    getTotalCases("true");
    await studentServices
        .getAllCasesByGuardId(studentId: widget.student.userId!)
        .then((data) {
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
            listofCases = data;

            isLoading = false;
          });
        },
      );
      // if (mounted) {

      // }
    });
  }

  getTotalCases(String status) async {
    setState(() {
      statLoading = true;
    });
    await studentServices
        .getCasesCount(status: status, userId: widget.student.userId)
        .then((data) {
      data.fold(
        (failure) {
          ToastMessage().showToast(failure);
          setState(() {
            statLoading = false;
            totalStaff = 0;
          });
        },
        (caseData) {
          setState(() {
            if (status == "false") {
              totalUnResolvecases = caseData;
            } else if (status == "true") {
              totalResolvecases = caseData;
            }
            statLoading = false;
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
      extendBodyBehindAppBar: true,
      floatingActionButton: SizedBox(
        width: ResponsiveWrapper.of(context).scaledWidth / 2,
        child: Row(
          children: [
            Expanded(
                child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 252, 252, 252),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                loadAllCasesByStudentId();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Refresh".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            )),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportCase(
                          student: widget.student,
                        ),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Report".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => unfocus(context),
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
                      const SizedBox(),
                      Text(
                        "Student".toUpperCase(),
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(profile: widget.student),
                          ));
                        },
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProfileScreen(profile: widget.student),
                                ));

                  ;
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: Text(
                              getInitials(
                                  "${widget.student.firstName} ${widget.student.lastName}"),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ActivityCard(
                              icon: Icons.report_problem_outlined,
                              color: Colors.red,
                              isLoading: isLoading,
                              title: "CASES",
                              value: totalUnResolvecases.toString(),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            ActivityCard(
                              icon: Icons.ac_unit,
                              isLoading: isLoading,
                              title: "RESOLVED",
                              value: totalResolvecases.toString(),
                            )
                          ],
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
                            visible: listofCases.isNotEmpty,
                            replacement: Column(
                              children: [
                                SizedBox(
                                  height: ResponsiveWrapper.of(context)
                                          .scaledHeight /
                                      5,
                                ),
                                const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 30,
                                    child: Icon(
                                      Icons.report_problem_outlined,
                                      color: Colors.white,
                                    )),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text(
                                  "No Cases",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22),
                                ),
                              ],
                            ),
                            child: Visibility(
                              visible: !isLoading,
                              replacement: const Center(
                                  child: SpinKitFadingCircle(
                                color: Colors.green,
                              )),
                              child: ListView.separated(
                                padding:
                                    const EdgeInsets.only(top: 0, bottom: 0),
                                shrinkWrap: true,
                                itemCount: listofCases.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const ReportDetail()));
                                      },
                                      child: CaseCard(
                                          caseData: listofCases[index],
                                          isResolved: listofCases[index]
                                                      .status!
                                                      .toString() ==
                                                  "false"
                                              ? false
                                              : true));
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
      ),
    );
  }
}

// class ActivityCard extends StatelessWidget {
//   const ActivityCard(
//       {super.key,
//       required this.title,
//       this.color = Colors.green,
//       required this.value,
//       required this.icon});
//   final String title;
//   final String value;
//   final IconData icon;
//   final Color color;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width / 2.3,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.8),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: color,
//             radius: 30,
//             child: Icon(
//               icon,
//               color: Colors.white,
//               size: 30,
//             ),
//           ),
//           const SizedBox(
//             width: 8,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w900,
//                     color: Colors.black),
//               ),
//               Text(
//                 value,
//                 style: TextStyle(
//                     fontSize: 40, fontWeight: FontWeight.w600, color: color),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
