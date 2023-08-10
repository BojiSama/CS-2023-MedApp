import 'package:flutter/material.dart';
import 'package:med_app/screens/home_screen.dart';
import 'package:med_app/screens/welcome_screen.dart';
import 'package:med_app/screens/registration_screen.dart';
import 'package:med_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MedicalEmergencyApp());
}

class MedicalEmergencyApp extends StatelessWidget {
  const MedicalEmergencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Emergency App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      // home: const HomePage(),
      // home: const WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      // initialRoute: HomePage.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        HomePage.id: (context) => const HomePage(),
      },
    );
  }
}