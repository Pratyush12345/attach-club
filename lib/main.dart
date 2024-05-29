import 'package:attach_club/bloc/add_link/add_link_bloc.dart';
import 'package:attach_club/bloc/add_link/add_link_repository.dart';
import 'package:attach_club/bloc/add_service/add_service_bloc.dart';
import 'package:attach_club/bloc/add_service/add_service_repository.dart';
import 'package:attach_club/bloc/buy_plan/buy_plan_bloc.dart';
import 'package:attach_club/bloc/buy_plan/buy_plan_repository.dart';
import 'package:attach_club/bloc/complete_profile/complete_profile_bloc.dart';
import 'package:attach_club/bloc/complete_profile/complete_profile_repository.dart';
import 'package:attach_club/bloc/connections/connections_bloc.dart';
import 'package:attach_club/bloc/connections/connections_repository.dart';
import 'package:attach_club/bloc/dashboard/dashboard_bloc.dart';
import 'package:attach_club/bloc/dashboard/dashboard_repository.dart';
import 'package:attach_club/bloc/detailed_analytics/detailed_analytics_bloc.dart';
import 'package:attach_club/bloc/detailed_analytics/detailed_analytics_repository.dart';
import 'package:attach_club/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:attach_club/bloc/edit_profile/edit_profile_repository.dart';
import 'package:attach_club/bloc/greetings/greetings_bloc.dart';
import 'package:attach_club/bloc/greetings/greetings_repository.dart';
import 'package:attach_club/bloc/home/home_bloc.dart';
import 'package:attach_club/bloc/home/home_repository.dart';
import 'package:attach_club/bloc/profile/profile_bloc.dart';
import 'package:attach_club/bloc/profile/profile_repository.dart';
import 'package:attach_club/bloc/profile_image/profile_image_bloc.dart';
import 'package:attach_club/bloc/profile_image/profile_image_repository.dart';
import 'package:attach_club/bloc/profile_privacy/profile_privacy_bloc.dart';
import 'package:attach_club/bloc/profile_privacy/profile_privacy_repository.dart';
import 'package:attach_club/bloc/search_connections/search_connections_bloc.dart';
import 'package:attach_club/bloc/search_connections/search_connections_repository.dart';
import 'package:attach_club/bloc/signup/signup_bloc.dart';
import 'package:attach_club/bloc/signup/signup_repository.dart';
import 'package:attach_club/bloc/splash_screen/splash_screen_repository.dart';
import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/firebase_options.dart';
import 'package:attach_club/views/add_link/add_link.dart';
import 'package:attach_club/views/add_service/add_service_screen.dart';
import 'package:attach_club/views/buy_plan/buy_plan.dart';
import 'package:attach_club/views/complete_profile/complete_profile.dart';
import 'package:attach_club/views/detailed_analytics/detailed_analytics.dart';
import 'package:attach_club/views/edit_profile/edit_profile.dart';
import 'package:attach_club/views/social_greeting/greetings.dart';
import 'package:attach_club/views/manage_profile/manage_profile.dart';
import 'package:attach_club/views/notifications/notifications.dart';
import 'package:attach_club/views/profile/profile.dart';
import 'package:attach_club/views/profile/view_all_products.dart';
import 'package:attach_club/views/profile_image/profile_image.dart';
import 'package:attach_club/views/profile_privacy/profile_privacy.dart';
import 'package:attach_club/views/qr_code/qr_code_screen.dart';
import 'package:attach_club/views/settings/settings.dart';
import 'package:attach_club/home.dart';
import 'package:attach_club/views/signup/sign_up.dart';
import 'package:attach_club/views/splash_screen/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'bloc/splash_screen/splash_screen_bloc.dart';
import 'core/repository/user_data_notifier.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions().currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Client client;

  @override
  void initState() {
    super.initState();
    client = Client();
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserDataNotifier(),
      child: Provider(
        create: (context) => client,
        child: MultiRepositoryProvider(
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
                client,
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
            RepositoryProvider(
              create: (context) => HomeRepository(
                context.read<CoreRepository>(),
              ),
            ),
            RepositoryProvider(
              create: (context) => ProfileRepository(
                context.read<CoreRepository>(),
              ),
            ),
            RepositoryProvider(
              create: (context) => EditProfileRepository(
                context.read<CoreRepository>(),
              ),
            ),
            RepositoryProvider(
              create: (context) => SearchConnectionsRepository(
                context.read<CoreRepository>(),
                client,
              ),
            ),
            RepositoryProvider(
              create: (context) => DashboardRepository(
                  context.read<CoreRepository>(), context.read<Client>()),
            ),
            RepositoryProvider(
              create: (context) => BuyPlanRepository(
                  context.read<CoreRepository>(), context.read<Client>()),
            ),
            RepositoryProvider(
              create: (context) => DetailedAnalyticsRepository(
                context.read<CoreRepository>(),
              ),
            ),
            RepositoryProvider(
              create: (context) => GreetingsRepository(),
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
              BlocProvider(
                create: (context) => HomeBloc(
                  context.read<HomeRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => DashboardBloc(
                  context.read<DashboardRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => ProfileBloc(
                  context.read<ProfileRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => EditProfileBloc(
                  context.read<EditProfileRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => SearchConnectionsBloc(
                    context.read<SearchConnectionsRepository>()),
              ),
              BlocProvider(
                create: (context) => BuyPlanBloc(
                  context.read<BuyPlanRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => DetailedAnalyticsBloc(
                  context.read<DetailedAnalyticsRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => GreetingsBloc(
                  context.read<GreetingsRepository>(),
                ),
              ),
            ],
            child: MaterialApp(
              // locale: DevicePreview.locale(context),
              // builder: DevicePreview.appBuilder,
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
                "/settings": (context) => const SettingsPage(),
                "/settings/manageProfile": (context) => const ManageProfile(),
                "/settings/profilePrivacy": (context) => const ProfilePrivacy(),
                "/home": (context) => const HomeScreen(),
                "/profile": (context) => const Profile(buttonTitle: "My Profile",),
                "/profile/products": (context) => const ViewAllProducts(),
                "/qr": (context) => const QrCodeScreen(),
                "/settings/detailedAnalytics": (context) =>
                    const DetailedAnalytics(),
                "/greetings": (context) => const Greetings(),
                "/buyPlan": (context) => const BuyPlan(),
                "/notifications": (context) => const Notifications(),
              },
            ),
          ),
        ),
      ),
    );
  }
}
