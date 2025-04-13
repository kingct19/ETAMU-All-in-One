import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/guest_home.dart';
import 'screens/splash_screen.dart'; // ✅ NEW
import 'screens/role_picker.dart';   // ✅ RENAMED

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'BreeSerif',
      ),
      initialRoute: '/', // ✅ now points to splash
      routes: {
        '/': (context) => const SplashScreen(),       // ✅ Splash first
        '/login': (context) => LoginScreen(),
        '/student_home': (context) => Home(role: 'student'),
        '/faculty_home': (context) => Home(role: 'faculty'),
        '/guest': (context) => const GuestHomePage(),
        '/role_picker': (context) => const RolePickerPage(), // ✅ still accessible
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
