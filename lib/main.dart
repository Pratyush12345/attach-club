import 'package:attach_club/bloc/add_link/add_link_bloc.dart';
import 'package:attach_club/bloc/add_service/add_service_bloc.dart';
import 'package:attach_club/bloc/complete_profile/complete_profile_bloc.dart';
import 'package:attach_club/views/add_link/add_link.dart';
import 'package:attach_club/views/add_service/add_service_screen.dart';
import 'package:attach_club/views/complete_profile/complete_profile.dart';
import 'package:attach_club/views/manage_profile/manage_profile.dart';
import 'package:attach_club/views/profile/profile.dart';
import 'package:attach_club/views/profile_image/profile_image.dart';
import 'package:attach_club/views/profile_privacy/profile_privacy.dart';
import 'package:attach_club/views/settings/settings.dart';
import 'package:attach_club/home.dart';
import 'package:attach_club/views/signup/sign_up.dart';
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
        BlocProvider(create: (context) => CompleteProfileBloc()),
        BlocProvider(create: (context) => AddLinkBloc()),
        BlocProvider(create: (context) => AddServiceBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF181B2F),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF26293B),
          ),
          cardTheme: const CardTheme(
            color: Color(0xFF26293B),
            surfaceTintColor: Color(0xFF26293B),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xFF2D4CF9)),
        ),
        themeMode: ThemeMode.dark,
        initialRoute: "/signup",
        routes: {
          "/signup": (context) => const SignUp(),
          "/onboard1": (context) => const CompleteProfile(),
          "/onboard2": (context) => const ProfileImage(),
          "/onboard3": (context) => const AddLink(),
          "/onboard4": (context) => const AddService(),
          "/settings": (context) => const Settings(),
          "/settings/manageProfile": (context) => const ManageProfile(),
          "/settings/profilePrivacy": (context) => const ProfilePrivacy(),
          "/home": (context) => const HomeScreen(),
          "/profile": (context) => const Profile(),
        },
      ),
    );
  }
}
