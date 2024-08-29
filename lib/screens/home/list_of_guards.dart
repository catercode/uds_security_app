import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:uds_security_app/screens/home/components/add_guard.dart';
import 'package:uds_security_app/screens/home/components/add_staff.dart';
import 'package:uds_security_app/screens/home/dashboard.dart';
import 'package:uds_security_app/screens/home/security_groups_screen.dart';
import 'package:uds_security_app/screens/student/components/report.details.dart';
import 'package:uds_security_app/screens/student/components/reportCase.dart';
import 'package:uds_security_app/screens/student/profile.dart';

class AllGuard extends StatelessWidget {
  const AllGuard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
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
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
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
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: ResponsiveWrapper.of(context).scaledWidth,
                        child: const ActivityCard(
                          mainAxisAlignment: MainAxisAlignment.center,
                          icon: Icons.person,
                          title: "TOTAL GUARDS",
                          value: "5",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // Container(
                    //   margin: const EdgeInsets.symmetric(horizontal: 16),
                    //   padding: const EdgeInsets.only(top: 32),
                    //   height: MediaQuery.of(context).size.height * 0.8,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white.withOpacity(0.9),
                    //     borderRadius: const BorderRadius.only(
                    //       topLeft: Radius.circular(30),
                    //       topRight: Radius.circular(30),
                    //     ),
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 8, horizontal: 16),
                    //     child: ListView.separated(
                    //       padding: const EdgeInsets.only(top: 0, bottom: 0),
                    //       shrinkWrap: true,
                    //       itemCount: 10,
                    //       itemBuilder: (context, index) {
                    //         return InkWell(
                    //             onTap: () {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) =>
                    //                           const ReportDetail()));
                    //             },
                    //             child: const SecurityInfoCard());
                    //       },
                    //       separatorBuilder: (context, index) => const Divider(
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ),
                    //),
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

// class StudentInfoCard extends StatelessWidget {
//   const StudentInfoCard({
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
