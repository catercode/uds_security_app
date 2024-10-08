import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:uds_security_app/const/enums/func.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';
import 'package:uds_security_app/screens/auth/login.dart';
import 'package:uds_security_app/services/auth/hive_auth_user.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel profile;
  const ProfileScreen({super.key, required this.profile});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  HiveAuthServices hiveAuthServices = HiveAuthServices();

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
                      "Profile".toUpperCase(),
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const ProfileScreen(),
                    //     ));
                    //   },
                    //   child: const CircleAvatar(
                    //     radius: 25,
                    //     backgroundColor: Colors.white,
                    //     child: Text(
                    //       "BA",
                    //       style: TextStyle(fontSize: 18),
                    //     ),
                    //   ),
                    // )
                    const SizedBox(),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: ResponsiveWrapper.of(context).scaledWidth,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: Text(
                                style: const TextStyle(fontSize: 30),
                                getInitials(
                                    "${widget.profile.firstName} ${widget.profile.lastName}")), // Replace with your image path
                          ),
                          const Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //SizedBox.shrink(),
                          Text(
                            "${widget.profile.firstName!} ${widget.profile.lastName!}",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Icon(
                          //   Icons.edit,
                          //   size: 30,
                          // ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 200,
                        child: Card(
                          color: Colors.green.withOpacity(0.5),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.edit,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              ProfileText(
                                text: "Email :",
                              ),
                              CustomSizedBox(),
                              ProfileText(
                                text: "Phone :",
                              ),
                              // CustomSizedBox(),
                              // ProfileText(
                              //   text: "Age :",
                              // ),
                              CustomSizedBox(),
                              ProfileText(
                                text: "Gender",
                              ),
                              CustomSizedBox(),
                              ProfileText(
                                text: "Address :",
                              ),
                              CustomSizedBox(),
                              ProfileText(
                                text: "Foculty :",
                              ),
                              // CustomSizedBox(),
                              // ProfileText(text: "Entry Year :"),
                              CustomSizedBox(),
                              ProfileText(text: "Hostile :"),
                              CustomSizedBox(),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ProfileText(
                                text: widget.profile.email != ""
                                    ? widget.profile.email!
                                    : "N/a",
                              ),
                              const CustomSizedBox(),
                              ProfileText(
                                text: widget.profile.phone != ""
                                    ? widget.profile.phone!
                                    : "N/a",
                              ),
                              // const CustomSizedBox(),
                              // const ProfileText(
                              //   text: "26",
                              // ),
                              const CustomSizedBox(),
                              ProfileText(
                                text: widget.profile.gender != ""
                                    ? widget.profile.gender!
                                    : "N/a",
                              ),
                              const CustomSizedBox(),
                              ProfileText(
                                text: widget.profile.address != ""
                                    ? widget.profile.address!
                                    : "N/a",
                              ),
                              const CustomSizedBox(),
                              ProfileText(
                                text: widget.profile.faculty != ""
                                    ? widget.profile.faculty!
                                    : "N/a",
                              ),
                              // const CustomSizedBox(),
                              // const ProfileText(
                              //   text: "2017",
                              // ),
                              const CustomSizedBox(),
                              ProfileText(
                                  text: widget.profile.hostile != ""
                                      ? widget.profile.hostile!
                                      : "N/a"),
                              const CustomSizedBox(),
                            ],
                          ),
                        ],
                      ),
                      const CustomSizedBox(),
                      const CustomSizedBox(),
                      InkWell(
                        onTap: () {
                          hiveAuthServices.clearHive();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                      ),
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
}

class CustomSafeArea extends StatelessWidget {
  const CustomSafeArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
    );
  }
}

class CustomSizedBox extends StatelessWidget {
  const CustomSizedBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 20);
  }
}

class ProfileText extends StatelessWidget {
  const ProfileText({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        color: Colors.grey[700],
      ),
    );
  }
}
