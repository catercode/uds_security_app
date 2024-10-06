import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:uds_security_app/const/enums/func.dart';
import 'package:uds_security_app/models/caseModel/case.model.dart';
import 'package:uds_security_app/screens/home/all_cases.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/student/components/report.details.dart';
import 'package:uds_security_app/screens/student/profile.dart';
import 'package:uds_security_app/services/case/cases_services.dart';
import 'package:uds_security_app/services/staffAndStudent/staff_services.dart';

import '../../../../models/userModel/user.model.dart';

class UserDetailScreen extends StatefulWidget {
  final UserModel user;

  const UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
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

      //  getTotalCases(widget.status);
    });
    super.initState();
  }

  loadCases() async {
    setState(() {
      isLoading = true;
    });
    await caseServices
        .getAllCasesByStudentId(studentId: widget.user.userId!)
        .then((data) {
      data.fold(
        (failure) {
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
                height: 32,
              ),
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
                      "STAFF DETAIL".toUpperCase(),
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          child: Text(
                            getInitials(
                                "${widget.user.firstName} ${widget.user.lastName}"),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          '${widget.user.firstName} ${widget.user.lastName}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      Center(
                        child: Text(widget.user.role ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 24)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              _buildDetailRow('Phone', widget.user.phone),
                              _buildDetailRow('Email', widget.user.email),
                              _buildDetailRow(
                                  'Department', widget.user.department),
                              _buildDetailRow('Faculty', widget.user.faculty),
                              _buildDetailRow('Address', widget.user.address),
                              _buildDetailRow('Hostile', widget.user.hostile),
                              _buildDetailRow('Status', widget.user.status),
                              _buildDetailRow('Date', widget.user.date),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Case History',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: ResponsiveWrapper.of(context).scaledWidth,
                        height:
                            ResponsiveWrapper.of(context).scaledHeight * 0.5,
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Visibility(
                              visible: !isLoading,
                              replacement: const Center(
                                child: SpinKitFadingCircle(
                                  color: Colors.green,
                                ),
                              ),
                              child: Visibility(
                                visible: listofCases.isEmpty,
                                replacement: const Column(children: [
                                  SizedBox(height: 100),
                                  Icon(
                                    Icons.report_problem_outlined,
                                    size: 100,
                                    color: Colors.grey,
                                  ),
                                  Text("You don't have any case history",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ))
                                ]),
                                child: ListView.separated(
                                  padding:
                                      const EdgeInsets.only(top: 0, bottom: 0),
                                  shrinkWrap: true,
                                  itemCount: listofCases.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReportDetail(
                                                          currentUser:
                                                              widget.user,
                                                          cases: listofCases[
                                                              index])));
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            value ?? 'Not available',
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
