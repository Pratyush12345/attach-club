import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:attach_club/bloc/add_link/add_link_bloc.dart';
import 'package:attach_club/bloc/add_link/add_link_repository.dart';
import 'package:attach_club/bloc/add_service/add_service_bloc.dart';
import 'package:attach_club/bloc/add_service/add_service_repository.dart';
import 'package:attach_club/bloc/buy_plan/buy_plan_bloc.dart';
import 'package:attach_club/bloc/buy_plan/buy_plan_repository.dart';
import 'package:attach_club/bloc/complete_profile/complete_profile_bloc.dart';
import 'package:attach_club/bloc/complete_profile/complete_profile_repository.dart';
import 'package:attach_club/bloc/connections/connection_provider.dart';
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
import 'package:attach_club/bloc/notifications/notifications_bloc.dart';
import 'package:attach_club/bloc/notifications/notifications_repository.dart';
import 'package:attach_club/bloc/profile/profile_bloc.dart';
import 'package:attach_club/bloc/profile/profile_repository.dart';
import 'package:attach_club/bloc/profile_image/profile_image_bloc.dart';
import 'package:attach_club/bloc/profile_image/profile_image_repository.dart';
import 'package:attach_club/bloc/profile_privacy/profile_privacy_bloc.dart';
import 'package:attach_club/bloc/profile_privacy/profile_privacy_repository.dart';
import 'package:attach_club/bloc/search_connections/Search_provider.dart';
import 'package:attach_club/bloc/search_connections/search_connections_bloc.dart';
import 'package:attach_club/bloc/search_connections/search_connections_repository.dart';
import 'package:attach_club/bloc/signup/signup_bloc.dart';
import 'package:attach_club/bloc/signup/signup_repository.dart';
import 'package:attach_club/bloc/splash_screen/splash_screen_repository.dart';
import 'package:attach_club/bloc/verify_phone/verify_phone_bloc.dart';
import 'package:attach_club/bloc/verify_phone/verify_phone_repository.dart';
import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/core/repository/firebase_api.dart';
import 'package:attach_club/firebase_options.dart';
import 'package:attach_club/views/add_link/add_link.dart';
import 'package:attach_club/views/add_service/add_service_screen.dart';
import 'package:attach_club/views/blocked/blocked.dart';
import 'package:attach_club/views/buy_plan/buy_plan.dart';
import 'package:attach_club/views/complete_profile/complete_profile.dart';
import 'package:attach_club/views/detailed_analytics/detailed_analytics.dart';
import 'package:attach_club/views/intro/intro1.dart';
import 'package:attach_club/views/intro/intro2.dart';
import 'package:attach_club/views/intro/intro3.dart';
import 'package:attach_club/views/no_internet/no_internet.dart';
import 'package:attach_club/views/settings/settings_provider.dart';
import 'package:attach_club/views/social_greeting/greetings.dart';
import 'package:attach_club/views/manage_profile/manage_profile.dart';
import 'package:attach_club/views/notifications/notifications.dart';
import 'package:attach_club/views/profile/profile.dart';
import 'package:attach_club/views/profile_image/profile_image.dart';
import 'package:attach_club/views/profile_privacy/profile_privacy.dart';
import 'package:attach_club/views/qr_code/qr_code_screen.dart';
import 'package:attach_club/views/settings/settings.dart';
import 'package:attach_club/home.dart';
import 'package:attach_club/views/signup/sign_up.dart';
import 'package:attach_club/views/splash_screen/splash_screen.dart';
import 'package:attach_club/views/verify_phone/verify_phone.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import 'bloc/splash_screen/splash_screen_bloc.dart';
import 'core/repository/user_data_notifier.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions().currentPlatform,
  );
  await FirebaseApi().initNotifications();
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
  late StreamSubscription<List<ConnectivityResult>> subscription;
  bool isNavigated = false;

  bool _getConnectivityResult(List<ConnectivityResult> result) {
    return result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.vpn) ||
        result.contains(ConnectivityResult.ethernet) ||
        result.contains(ConnectivityResult.other);
  }

  Future<void> _onRetry() async {
    final newResult = await (Connectivity().checkConnectivity());
    if (_getConnectivityResult(newResult)) {
      navigatorKey.currentState?.pop();
      isNavigated = false;
    }
  }

  @override
  void initState() {
    super.initState();
    client = Client();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      if (_getConnectivityResult(result)) {
        if (isNavigated) {
          await _onRetry();
        }
      } else {
        if (!isNavigated) {
          isNavigated = true;
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) {
              return NoInternet(
                onRetry: _onRetry,
              );
            },
          ));
        }
      }
    });
  }

  @override
  void dispose() {
    client.close();
    // subscription.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return ChangeNotifierProvider(
      create: (context) => UserDataNotifier(),
      child: Provider(
        create: (context) => client,
        child: MultiRepositoryProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => ChangeScreenProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => ChangeConnectionScreenProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => ChangeSearchScreenProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => ChangeSettingScreenProvider(),
            ),
            RepositoryProvider(
              create: (context) => CoreRepository(),
            ),
            RepositoryProvider(
              create: (context) => SignupRepository(
                context.read<CoreRepository>(),
              ),
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
            RepositoryProvider(
              create: (context) => VerifyPhoneRepository(
                context.read<CoreRepository>(),
              ),
            ),
            RepositoryProvider(
              create: (context) =>
                  NotificationsRepository(context.read<CoreRepository>()),
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
              BlocProvider(
                create: (context) => VerifyPhoneBloc(
                  context.read<VerifyPhoneRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) =>
                    NotificationsBloc(context.read<NotificationsRepository>()),
              ),
            ],
            child: MaterialApp(
              navigatorKey: navigatorKey,
              // locale: DevicePreview.locale(context),
              // builder: DevicePreview.appBuilder,
              title: 'Attach Club',
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
              debugShowCheckedModeBanner: false,
              initialRoute: "/splash_screen",
              routes: {        
                "/splash_screen": (context) => UpgradeAlert(
                  dialogStyle: Platform.isIOS? UpgradeDialogStyle.cupertino: UpgradeDialogStyle.material,
                  showIgnore: true,
                  showLater: true,
                  child: const SplashScreen()),
                "/signup": (context) => const SignUp(),
                "/onboard1": (context) => const CompleteProfile(),
                "/onboard2": (context) => const ProfileImage(),
                "/onboard3": (context) => const AddLink(),
                "/onboard4": (context) => const AddService(),
                "/settings": (context) => const SettingsPage(),
                "/settings/manageProfile": (context) => const ManageProfile(),
                "/settings/profilePrivacy": (context) => const ProfilePrivacy(),
                "/home": (context) => const HomeScreen(),
                "/profile": (context) => const Profile(
                      buttonTitle: "My Profile",
                    ),
                // "/profile/products": (context) => const ViewAllProducts(),
                "/qr": (context) => const QrCodeScreen(),
                "/settings/detailedAnalytics": (context) =>
                    const DetailedAnalytics(),
                "/greetings": (context) => const Greetings(),
                "/buyPlan": (context) => const BuyPlan(),
                "/notifications": (context) => const Notifications(),
                "/verifyPhone": (context) => const VerifyPhone(),
                "/blocked": (context) => const BlockedScreen(),
                "/intro1": (context) => const Intro1(),
                "/intro2": (context) => const Intro2(),
                "/intro3": (context) => const Intro3(),
                // "/noInternet": (context) => const NoInternet(),
              },
            ),
          ),
        ),
      ),
    );
  }
}
