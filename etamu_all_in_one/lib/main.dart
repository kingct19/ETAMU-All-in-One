import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/guest_home.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ❌ DO NOT call setPersistence() on mobile. Firebase Auth is persistent by default on Android/iOS.

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
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/guest': (context) => const GuestHomePage(),
        '/student_home': (context) => const Home(role: 'student'),
        '/faculty_home': (context) => const Home(role: 'faculty'),
      },
    );
  }
}
