import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uds_security_app/models/caseModel/case.model.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/home/list_of_staff.dart';
import 'package:uds_security_app/screens/student/list_of_student.dart';
import 'package:uds_security_app/screens/student/components/report.details.dart';
import 'package:uds_security_app/screens/student/profile.dart';
import 'package:uds_security_app/services/case/cases_services.dart';
import 'package:uds_security_app/services/staffAndStudent/staff_services.dart';

class AllCases extends StatefulWidget {
  final UserModel currentUser;
  final String status;
  const AllCases({super.key, required this.currentUser, required this.status});

  @override
  State<AllCases> createState() => _AllCasesState();
}

class _AllCasesState extends State<AllCases> with WidgetsBindingObserver {
  final staffServices = StaffServices();
  final caseServices = CaseServices();
  int totalResolvecases = 0;
  int totalUnResolvecases = 0;
  CaseModel? caseNotiModel;

  // NoticationApi noticationApi = NoticationApi();
  int totalStaff = 0;
  int totalStudent = 0;
  bool statLoading = false;
  List<CaseModel> listofCases = [];

  bool isLoading = false;

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadCases();

      getTotalCases(widget.status);
    });
    super.initState();
  }

  loadCases() async {
    setState(() {
      isLoading = true;
    });
    await caseServices.getAllCases(status: widget.status).then((data) {
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
    });
  }

  getTotalCases(String status) async {
    setState(() {
      statLoading = true;
    });
    await caseServices.getCasesCount(status: status).then((data) {
      data.fold(
        (failure) {
          ToastMessage().showToast(failure);
          setState(() {
            statLoading = false;
          });
        },
        (caseData) {
          setState(() {
            // totalUnResolvecases = caseData;
            totalResolvecases = caseData;
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
              const CustomSafeArea(),
              const SizedBox(height: 30),
              Padding(
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
                      widget.status == "false"
                          ? "CASES".toUpperCase()
                          : "Resolved".toUpperCase(),
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
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AllStaff(),
                                  ));
                            },
                            child: ActivityCard(
                              width: 1,
                              icon: Icons.person_4,
                              title: "Total Resolved",
                              value: totalResolvecases.toString(),
                            ),
                          ),
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
                        child: ListView.separated(
                          padding: const EdgeInsets.only(top: 0, bottom: 0),
                          shrinkWrap: true,
                          itemCount: listofCases.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReportDetail(
                                              currentUser: widget.currentUser,
                                              cases: listofCases[index])));
                                },
                                child: CaseCard(
                                    caseData: listofCases[index],
                                    isResolved:
                                        listofCases[index].status!.toString() ==
                                                "false"
                                            ? false
                                            : true));
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
      this.width = 2.3,
      required this.icon});
  final String title;
  final String value;
  final IconData icon;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
              Text(
                value,
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.green),
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
    this.fullname = "John Paul",
  });
  final bool isResolved;
  final String fullname;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const CircleAvatar(
          radius: 30,
          child: Text("JP"), // Replace with your image path
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                fullname,
                style: const TextStyle(
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
