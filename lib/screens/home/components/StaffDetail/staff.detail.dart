import 'package:flutter/material.dart';
import 'package:uds_security_app/const/enums/func.dart';
import 'package:uds_security_app/screens/home/all_cases.dart';
import 'package:uds_security_app/screens/student/profile.dart';

import '../../../../models/userModel/user.model.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailScreen({super.key, required this.user});

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
                            getInitials("${user.firstName} ${user.lastName}"),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          '${user.firstName} ${user.lastName}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      Center(
                        child: Text(user.role ?? '',
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
                              _buildDetailRow('Phone', user.phone),
                              _buildDetailRow('Email', user.email),
                              _buildDetailRow('Department', user.department),
                              _buildDetailRow('Faculty', user.faculty),
                              _buildDetailRow('Address', user.address),
                              _buildDetailRow('Hostile', user.hostile),
                              _buildDetailRow('Status', user.status),
                              _buildDetailRow('Date', user.date),
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
                      Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Column(
                              children: [
                                ...List.generate(
                                  6,
                                  (index) {
                                    return Column(
                                      children: [
                                        StudentCard(
                                          fullname:
                                              '${user.firstName} ${user.lastName}',
                                          isResolved: false,
                                        ),
                                        Divider(
                                          color: Colors.grey[300],
                                          thickness: 1,
                                        )
                                      ],
                                    );
                                  },
                                )
                              ],
                            ),
                          ))
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
