import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:uds_security_app/const/enums/position.dart';
import 'package:uds_security_app/models/caseModel/case.model.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/student/components/reportCase.dart';
import 'package:uds_security_app/services/auth/hive_auth_user.dart';
import 'package:uds_security_app/services/case/cases_services.dart';
import 'package:uds_security_app/services/staffAndStudent/staff_services.dart';

class ReportDetail extends StatefulWidget {
  final CaseModel cases;
  final UserModel currentUser;
  const ReportDetail(
      {super.key, required this.cases, required this.currentUser});

  @override
  State<ReportDetail> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail>
    with WidgetsBindingObserver {
  final staffServices = StaffServices();
  final caseServices = CaseServices();
  UserModel gaurd = UserModel();
  bool isLoading = false;
  bool isMarking = false;
  String fullName = "";
  List<UserModel> listofStaff = [];
  HiveAuthServices hiveAuthServices = HiveAuthServices();

  @override
  initState() {
    setState(() {
      isLoading = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadCases();
      loadStaff();
    });
    super.initState();
  }

  loadCases() async {
    await staffServices
        .getGuardById(id: widget.cases.securityAssign.toString())
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
            gaurd = data;

            isLoading = false;
          });
        },
      );
      // if (mounted) {

      // }
    });
  }

  markCaseCompleted(id) async {
    setState(() {
      isMarking = true;
    });
    await caseServices.markCaseCompleted(caseid: id).then((data) {
      data.fold(
        (failure) {
          log(failure);
          ToastMessage().showToast(failure);
          setState(() {
            isMarking = false;
          });
        },
        (data) {
          setState(() {
            isMarking = false;
          });
          ToastMessage().showToast("Case mark as resolved");
        },
      );
    });
  }

  loadStaff() async {
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
            listofStaff = data;
            isLoading = false;
          });
        },
      );
      // if (mounted) {

      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    fullName = "${gaurd.firstName} ${gaurd.lastName}";
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
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Report Detail".toUpperCase(),
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
              Visibility(
                visible: !isLoading,
                replacement: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: ResponsiveWrapper.of(context).scaledHeight / 3,
                    ),
                    const Center(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Visibility(
                      visible:
                          widget.currentUser.role == Position.staffAdmin.name
                              ? true
                              : false,
                      replacement: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Status : ${widget.cases.status == "false" ? "Open" : "Close"}",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          Text(
                            "Lvl: ${widget.cases.level}",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Card(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Text(
                                  "Revoke Report",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return const CustomerModalSheet(
                                    child: ThreatStatus(),
                                  );
                                },
                              ).then((status) {
                                if (status != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Status selected: $status')),
                                  );
                                }
                              });
                            },
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      "Lvl: ${widget.cases.level != "" ? widget.cases.level : "Medium"}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_down_circle_rounded,
                                      color: Colors.green,
                                    )
                                  ],
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
                    SizedBox(
                      width: ResponsiveWrapper.of(context).scaledWidth,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              widget.cases.statement!,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Security Assigned : $fullName",
                                maxLines: 1,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Contact No : ${gaurd.phone}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Rank : ${gaurd.rank}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.currentUser.role == Position.guard.name)
                const SizedBox(
                  height: 100,
                ),
              Visibility(
                  visible: widget.currentUser.role == Position.guard.name
                      ? true
                      : false,
                  child: Visibility(
                    visible: !isMarking,
                    replacement: const SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        markCaseCompleted(widget.cases.id!);
                      },
                      child: const Text(
                        "Mark As Resolved",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  )),
              Visibility(
                visible: widget.currentUser.role == Position.staffAdmin.name
                    ? true
                    : false,
                child: SizedBox(
                  width: ResponsiveWrapper.of(context).scaledWidth / 2,
                  child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomerModalSheet(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...List.generate(
                                    listofStaff.length,
                                    (index) => InkWell(
                                      onTap: () async {
                                        final data = await caseServices
                                            .assignAgentToCase(
                                                caseid: widget.cases.id!,
                                                gaurdName:
                                                    "${listofStaff[index].userId}");

                                        data.fold(
                                          (failure) {
                                            ToastMessage().showToast(
                                                'Failed to assign guard');
                                          },
                                          (success) {
                                            fullName =
                                                '${listofStaff[index].firstName!} ${listofStaff[index].lastName!}';
                                            ToastMessage().showToast(
                                                '$fullName" assign to resolve the case');
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            Text(
                                              "${listofStaff[index].firstName!}  ${listofStaff[index].lastName!}",
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            const Divider()
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Assign Gaurd",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 32,
              )
            ],
          ),
        ),
      ),
    );
  }
}
