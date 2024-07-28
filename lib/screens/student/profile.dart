import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                      const Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                                'assets/images/student.jpg'), // Replace with your image path
                          ),
                          Positioned(
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //SizedBox.shrink(),
                          Text(
                            'Evelyn Mac',
                            style: TextStyle(
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              ProfileText(
                                text: "Email :",
                              ),
                              CustomSizedBox(),
                              ProfileText(
                                text: "Phone :",
                              ),
                              CustomSizedBox(),
                              ProfileText(
                                text: "Age :",
                              ),
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
                              CustomSizedBox(),
                              ProfileText(text: "Entry Year :"),
                              CustomSizedBox(),
                              ProfileText(text: "Hostile :"),
                              CustomSizedBox(),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ProfileText(
                                text: "student@example.com",
                              ),
                              CustomSizedBox(),
                              ProfileText(
                                text: "+123456789",
                              ),
                              CustomSizedBox(),
                              ProfileText(
                                text: "26",
                              ),
                              CustomSizedBox(),
                              ProfileText(
                                text: "Female",
                              ),
                              CustomSizedBox(),
                              ProfileText(
                                text: "Address: 123 Main Street",
                              ),
                              CustomSizedBox(),
                              ProfileText(
                                text: "MPHIL CHD",
                              ),
                              CustomSizedBox(),
                              ProfileText(
                                text: "2017",
                              ),
                              CustomSizedBox(),
                              ProfileText(text: "Home Girl"),
                              CustomSizedBox(),
                            ],
                          ),
                        ],
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
