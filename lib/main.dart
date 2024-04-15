import 'package:attach_club/bloc/add_link/add_link_bloc.dart';
import 'package:attach_club/bloc/add_link/add_link_repository.dart';
import 'package:attach_club/bloc/add_service/add_service_bloc.dart';
import 'package:attach_club/bloc/add_service/add_service_repository.dart';
import 'package:attach_club/bloc/complete_profile/complete_profile_bloc.dart';
import 'package:attach_club/bloc/complete_profile/complete_profile_repository.dart';
import 'package:attach_club/bloc/connections/connections_bloc.dart';
import 'package:attach_club/bloc/connections/connections_repository.dart';
import 'package:attach_club/bloc/profile_image/profile_image_bloc.dart';
import 'package:attach_club/bloc/profile_image/profile_image_repository.dart';
import 'package:attach_club/bloc/profile_privacy/profile_privacy_bloc.dart';
import 'package:attach_club/bloc/profile_privacy/profile_privacy_repository.dart';
import 'package:attach_club/bloc/signup/signup_bloc.dart';
import 'package:attach_club/bloc/signup/signup_repository.dart';
import 'package:attach_club/bloc/splash_screen/splash_screen_repository.dart';
import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/firebase_options.dart';
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
import 'package:attach_club/views/splash_screen/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'bloc/splash_screen/splash_screen_bloc.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions().currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => CoreRepository(),
        ),
        RepositoryProvider(
          create: (context) => SignupRepository(),
        ),
        RepositoryProvider(
          create: (context) => CompleteProfileRepository(
            context.read<CoreRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SplashScreenRepository(),
        ),
        RepositoryProvider(
          create: (context) => AddLinkRepository(
            context.read<CoreRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => ProfilePrivacyRepository(
            context.read<CoreRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => ConnectionsRepository(
            context.read<CoreRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => ProfileImageRepository(
            context.read<CoreRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => AddServiceRepository(
            context.read<CoreRepository>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CompleteProfileBloc(
              context.read<CompleteProfileRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => AddLinkBloc(
              context.read<AddLinkRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) =>
                AddServiceBloc(context.read<AddServiceRepository>()),
          ),
          BlocProvider(
            create: (context) => SignupBloc(
              context.read<SignupRepository>(),
              context.read<CoreRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SplashScreenBloc(
              context.read<SplashScreenRepository>(),
              context.read<CoreRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ProfileImageBloc(
              context.read<CoreRepository>(),
              context.read<ProfileImageRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ProfilePrivacyBloc(
              context.read<ProfilePrivacyRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ConnectionsBloc(
              context.read<ConnectionsRepository>(),
            ),
          ),
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
          initialRoute: "/splash_screen",
          routes: {
            "/splash_screen": (context) => const SplashScreen(),
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
      ),
    );
  }
}
