import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uds_security_app/const/enums/func.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';
import 'package:uds_security_app/screens/home/components/StaffDetail/staff.detail.dart';
import 'package:uds_security_app/screens/home/components/add_staff.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/student/components/report.details.dart';
import 'package:uds_security_app/screens/student/components/reportCase.dart';
import 'package:uds_security_app/screens/student/profile.dart';
import 'package:uds_security_app/services/staff/staff_services.dart';

class AllStaff extends StatefulWidget {
  const AllStaff({super.key});

  @override
  State<AllStaff> createState() => _AllStaffState();
}

class _AllStaffState extends State<AllStaff> with WidgetsBindingObserver {
  final staffServices = StaffServices();
  List<UserModel> listofStaff = [];
  bool isLoading = false;
  int femaleCount = 0;
  int maleCount = 0;
  bool statLoading = false;

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadStaff();
      getTotal("Female");
      getTotal("Male");
    });
    super.initState();
  }

  loadStaff() async {
    setState(() {
      isLoading = true;
    });
    await staffServices.getAllStaff().then((data) {
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

  getTotal(String gender) async {
    setState(() {
      statLoading = true;
    });
    await staffServices.getStaffByGender(gender: gender).then((data) {
      data.fold(
        (failure) {
          log(failure);
          ToastMessage().showToast(failure);
          setState(() {
            statLoading = false;
          });
        },
        (data) {
          setState(() {
            if (gender == "Female") {
              femaleCount = data;
            } else {
              maleCount = data;
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
                    loadStaff();
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
                          child: AddStaffScreen(),
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
                      "STAFF".toUpperCase(),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ActivityCard(
                            icon: Icons.person,
                            title: "MALES",
                            value: maleCount.toString(),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          ActivityCard(
                            icon: Icons.person,
                            title: "FEMALES",
                            value: femaleCount.toString(),
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
                        child: isLoading
                            ? const Center(
                                child: SpinKitFadingCircle(
                                size: 30,
                                color: Colors.green,
                              ))
                            : listofStaff.isEmpty
                                ? const Column(
                                    children: [
                                      SizedBox(height: 200),
                                      Icon(
                                        Icons.person,
                                        size: 100,
                                        color: Colors.grey,
                                      ),
                                      Text("No staff found",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ))
                                    ],
                                  )
                                : ListView.separated(
                                    padding: const EdgeInsets.only(
                                        top: 0, bottom: 0),
                                    shrinkWrap: true,
                                    itemCount: listofStaff.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserDetailScreen(
                                                          user: listofStaff[
                                                              index],
                                                        )));
                                          },
                                          child: StudentInfoCard(
                                            staff: listofStaff[index],
                                          ));
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      height: 10,
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

class StudentInfoCard extends StatelessWidget {
  const StudentInfoCard({super.key, required this.staff});
  final UserModel staff;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.green[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Text(
                getInitials("${staff.firstName} ${staff.lastName}"),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ), // Replace with your image path
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${staff.firstName}  ${staff.lastName}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    staff.department.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              staff.status.toString(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
