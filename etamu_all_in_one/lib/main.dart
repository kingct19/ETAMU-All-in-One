import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/role.dart';
import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/guest_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ETAMU All-in-One',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const RoleSelectionPage(),
        '/login': (context) => const LoginScreen(),
        // Removed '/home' since Home now requires a role.
        '/student_home': (context) => Home(role: 'student'),
        '/faculty_home': (context) => Home(role: 'faculty'),
        '/guest': (context) => const GuestHomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
