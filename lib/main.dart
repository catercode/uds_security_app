import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uds_security_app/models/Notification/notification.api.dart';
import 'package:uds_security_app/screens/auth/checking_user.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCJo9iQX7N8XuUc2IeylKDyy5M_22fzyv8",
            projectId: "usd-app-1440a",
            messagingSenderId: "97255775091",
            appId: "1:97255775091:web:7472091d12934757500306"));
  } else {
    await Firebase.initializeApp();
  }
  await Hive.initFlutter(); // Initialize Hive locally storage
  await Hive.openBox('securityGroups'); // Open the securityGroups box
  await Hive.openBox('loginUser');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: MediaQuery.of(context).size.width / 1,
        minWidth: 480,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
      title: 'UDS SECURITY',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ValidationUser(),
      // home: DashboardPage(
      //   user: UserModel(),
      // ),
      //home: StudentHome(student: UserModel(),),
    );
  }
}
