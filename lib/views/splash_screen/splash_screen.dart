import 'package:attach_club/bloc/splash_screen/splash_screen_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    return  Scaffold(
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
            if(state is NavigateToVerifyPhone){
              _navigate("/verifyPhone");
            }
            if(state is NavigateToIntro){
              _navigate("/intro1");
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset("assets/images/splash.png")
              ),
              const SizedBox(height: 10.0,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Attach", style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w800),),
                  Text("Club", style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w400),),
                ],
              ),
              const Text("PROOF OF YOUR SMARTNESS", style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w400),)
            ],
          ),
      ),
    );
  }
}
