import 'screens/role.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/guest_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
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
        '/': (context) => const RoleSelectionPage(), // 👈 New route
        '/login': (context) => LoginScreen(),
        '/home': (context) => Home(),
        '/guest': (context) => const GuestHomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
