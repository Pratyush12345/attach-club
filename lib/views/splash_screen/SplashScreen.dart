import 'package:attach_club/bloc/splash_screen/splash_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashScreenBloc>().add(CheckLoginStatus());
  }

  _navigate(String route){
    Navigator.of(context).popAndPushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashScreenBloc, SplashScreenState>(
        listener: (context, state) {
          if (state is ShowSnackBar) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          if(state is NavigateToOnboarding){
            _navigate("/onboard1");
          }
          if(state is NavigateToDashboard){
            _navigate("/home");
          }
          if(state is NavigateToSignup){
            _navigate("/signup");
          }
        },
        child: const Center(
          child: Text("Splash Screen"),
        ),
      ),
    );
  }
}
