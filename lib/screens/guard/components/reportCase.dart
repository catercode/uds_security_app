import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:uds_security_app/models/caseModel/case.model.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/student/profile.dart';
import 'package:uds_security_app/services/case/cases_services.dart';

class ReportCase extends StatefulWidget {
  final UserModel student;
  const ReportCase({super.key, required this.student});

  @override
  State<ReportCase> createState() => _ReportCaseState();
}

class _ReportCaseState extends State<ReportCase> {
  bool isLoading = false;
  CaseServices staffServices = CaseServices();
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _quickReportController = TextEditingController();
  void clearTextFields() {
    _issueController.clear();
    // _issueController.clear();
    _levelController.clear();
  }

  void _submitForm() async {
    if (_quickReportController.text.isEmpty && _issueController.text.isEmpty) {
      ToastMessage()
          .showToast("Select a case or draft your case before submit");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      final userModel = CaseModel(
          level: _levelController.text,
          statement: _issueController.text,
          quickReport: _quickReportController.text,
          studentId: widget.student.id);

      final result = await staffServices.reportCase(issues: userModel);
      result.fold(
        (failure) {
          ToastMessage().showToast(failure!);
          setState(() {
            isLoading = false;
          });
        },
        (verified) {
          if (verified) {
            ToastMessage().showToast("Report submited successfully");
            setState(() {
              isLoading = false;
            });
            clearTextFields();
          } else {
            ToastMessage().showToast("Failed to submit report");
            setState(() {
              isLoading = false;
            });
          }
        },
      );
    } catch (e) {
      log("==========================$e");
      ToastMessage().showToast("Something went wrong try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ResponsiveWrapper.of(context).scaledWidth,
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
          child: ListView(
            shrinkWrap: true,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSafeArea(),
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
                      "Report A Case".toUpperCase(),
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Quick Report",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
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
                          setState(() {
                            if (status != null) {
                              _levelController.text = status;
                              ToastMessage().showToast(
                                'Case status has change to $status',
                              );
                            }
                          });
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
                                "Lvl: ${_levelController.text}",
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
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.only(top: 32),
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: templates.length,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              _issueController.text = templates[index];
                              _quickReportController.text = templates[index];
                            },
                            child: Card(
                              color: Colors.green.withOpacity(0.5),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      templates[index],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              ),
                            ),
                          ))),
              const SizedBox(
                height: 32,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "What is the issue?",
                  style: TextStyle(
                      fontSize: 25,
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
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: _issueController,
                      maxLines: 10,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      decoration: const InputDecoration(
                          hintText: "Type your report here",
                          hintStyle:
                              TextStyle(fontSize: 20, color: Colors.grey),
                          enabledBorder: InputBorder.none),
                    ),
                  )),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(height: 60),
              Visibility(
                visible: !isLoading,
                replacement: const SpinKitFadingCircle(
                  color: Colors.green,
                ),
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green)),
                  onPressed: () {
                    _submitForm();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Submit",
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
    );
  }
}

class CustomerModalSheet extends StatefulWidget {
  const CustomerModalSheet({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  State<CustomerModalSheet> createState() => _CustomerModalSheetState();
}

class _CustomerModalSheetState extends State<CustomerModalSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: widget.child,
    );
  }
}

class ThreatStatus extends StatelessWidget {
  const ThreatStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        StausTile(
          status: "High",
        ),
        StausTile(
          status: "Medium",
        ),
        StausTile(
          status: "Low",
        ),
      ],
    );
  }
}

class StausTile extends StatelessWidget {
  const StausTile({super.key, required this.status, this.onTap, this.color = Colors.green});
  final String status;
  final VoidCallback? onTap;
  final Color color;
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        status,
        style:  TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color:color),
      ),
      onTap: onTap ??
          () {
            Navigator.pop(
              context,
              status,
            );
          },
      trailing:  Icon(
        Icons.arrow_forward_ios,
        size: 18,
        color: color,
      ),
    );
  }
}

List<String> templates = [
  "Intruder",
  "Lost phone",
  "Fight between students",
  "Fire out-break"
];
