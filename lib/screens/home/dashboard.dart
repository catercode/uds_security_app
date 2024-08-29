import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uds_security_app/screens/home/all_cases.dart';
import 'package:uds_security_app/screens/home/list_of_guards.dart';
import 'package:uds_security_app/screens/home/list_of_staff.dart';
import 'package:uds_security_app/screens/student/components/reportCase.dart';
import 'package:uds_security_app/screens/home/security_groups_screen.dart';
import 'package:uds_security_app/screens/student/list_of_student.dart';
import 'package:uds_security_app/screens/student/components/report.details.dart';
import 'package:uds_security_app/screens/student/profile.dart';
import 'package:uds_security_app/services/staffAndStudent/staff_services.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final staffServices = StaffServices();

  int totalStaff = 0;
  int totalStudent = 0;
  bool statLoading = false;

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getTotal("Staff");
      getTotal("Student");
    });
    super.initState();
  }

  getTotal(String status) async {
    setState(() {
      statLoading = true;
    });
    await staffServices.getAllStaff(status: status).then((data) {
      data.fold(
        (failure) {
          ToastMessage().showToast(failure);
          setState(() {
            statLoading = false;
            totalStaff = 0;
          });
        },
        (staffData) {
          setState(() {
            if (status == "Staff") {
              totalStaff = staffData.length;
            } else if (status == "Student") {
              totalStudent = staffData.length;
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
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomerModalSheet(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  StausTile(
                                    status: "Add Hostel",
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => const AllGuard(),
                                      ));
                                    },
                                  ),
                                  
                                  StausTile(
                                    status: "Security Guards",
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => const AllGuard(),
                                      ));
                                    },
                                  ),
                                  StausTile(
                                    status: " Duty Schedule",
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const SecurityGroupsScreen(),
                                      ));
                                    },
                                  )
                                ],
                              ),
                            );
                          },
                        ).then((status) {
                          if (status != null) {
                            ToastMessage().showToast(
                              'Case status has change to $status',
                            );
                          }
                        });
                      },
                      child: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    Text(
                      "Dashboard".toUpperCase(),
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const SizedBox()
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AllStaff(),
                                      ));
                                },
                                child: ActivityCard(
                                  icon: Icons.person_4,
                                  title: "STAFF",
                                  isLoading: statLoading,
                                  value: totalStaff.toString(),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AllStudent(),
                                      ));
                                },
                                child: ActivityCard(
                                  icon: Icons.person,
                                  isLoading: statLoading,
                                  title: "STUDENT",
                                  value: totalStudent.toString(),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AllCases(),
                                      ));
                                },
                                child: ActivityCard(
                                  isLoading: statLoading,
                                  icon: Icons.report_problem_outlined,
                                  title: "CASES",
                                  value: "10",
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AllStaff(),
                                      ));
                                },
                                child: ActivityCard(
                                  icon: Icons.ac_unit,
                                  isLoading: statLoading,
                                  title: "RESOLVED",
                                  value: "5",
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Recent CASES".toUpperCase(),
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
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
                        child: ListView.separated(
                          padding: const EdgeInsets.only(top: 0, bottom: 0),
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ReportDetail()));
                                },
                                child: const StudentCard(
                                  isResolved: false,
                                ));
                          },
                          separatorBuilder: (context, index) => const Divider(
                            color: Colors.grey,
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

class ActivityCard extends StatelessWidget {
  const ActivityCard(
      {super.key,
      required this.title,
      required this.value,
      this.isLoading = false,
      this.mainAxisAlignment = MainAxisAlignment.start,
      required this.icon});
  final String title;
  final String value;
  final IconData icon;
  final bool isLoading;
  final MainAxisAlignment mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.3,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          CircleAvatar(
            backgroundColor: Colors.green,
            radius: 30,
            child: Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
              ),
              Visibility(
                visible: !isLoading,
                replacement: const Center(
                    child: SpinKitFadingCircle(
                  color: Colors.green,
                )),
                child: Text(
                  value,
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  const StudentCard({
    super.key,
    required this.isResolved,
  });
  final bool isResolved;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(
              'assets/images/student.jpg'), // Replace with your image path
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'John Paul',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Some is tring to break my room',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Intruder',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red[600],
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          isResolved ? 'Awaiting' : "Resolved",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ToastMessage {
  showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.green,
      fontSize: 14.0,
    );
  }
}
