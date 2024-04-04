import 'package:attach_club/features/on_board1/bloc/on_board1_bloc.dart';
import 'package:attach_club/features/on_board1/presentation/screens/on_board1.dart';
import 'package:attach_club/features/signup/presentation/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>OnBoard1Bloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF181B2F)
        ),
        initialRoute: "/signup",
        routes: {
          "/signup":(context)=>const SignUp(),
          "/onboard":(context)=>const OnBoard1(),
        },
      ),
    );
  }
}