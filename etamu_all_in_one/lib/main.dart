import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/guest_home.dart';
import 'widgets/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('lastRole'); // ✅ Clear saved role
      await FirebaseAuth.instance.signOut(); // ✅ Sign out from Firebase
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ETAMU All-in-One',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'BreeSerif'),
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
