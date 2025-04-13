import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/guest_home.dart';
import 'screens/splash_screen.dart'; // ✅ Splash screen
import 'widgets/role_picker.dart';  // ✅ Modal widget, not a page

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
      initialRoute: '/', // Starts from splash screen
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/student_home': (context) => Home(role: 'student'),
        '/faculty_home': (context) => Home(role: 'faculty'),
        '/guest': (context) => const GuestHomePage(),
        // 🔁 Removed '/role_picker' as it's now a modal, not a route
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
