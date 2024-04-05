import 'package:attach_club/features/on_board1/bloc/on_board1_bloc.dart';
import 'package:attach_club/features/on_board1/presentation/screens/on_board1.dart';
import 'package:attach_club/features/on_board2/presentation/screens/on_board2.dart';
import 'package:attach_club/features/on_board3/bloc/on_board3_bloc.dart';
import 'package:attach_club/features/on_board3/presentation/screens/on_board3.dart';
import 'package:attach_club/features/on_board4/bloc/on_board4_bloc.dart';
import 'package:attach_club/features/on_board4/presentation/screens/on_board4.dart';
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
        BlocProvider(create: (context)=>OnBoard3Bloc()),
        BlocProvider(create: (context)=>OnBoard4Bloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF181B2F)
        ),
        initialRoute: "/onboard4",
        routes: {
          "/signup":(context)=>const SignUp(),
          "/onboard1":(context)=>const OnBoard1(),
          "/onboard2": (context)=>const OnBoard2(),
          "/onboard3": (context)=>const OnBoard3(),
          "/onboard4": (context)=>const OnBoard4(),

        },
      ),
    );
  }
}