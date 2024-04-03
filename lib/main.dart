import 'package:attach_club/features/signup/presentation/screens/sign_up.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF181B2F)
      ),
      initialRoute: "/signup",
      routes: {
        "/signup":(context)=>const SignUp(),
      },
    );
  }
}