import 'package:attach_club/bloc/splash_screen/splash_screen_bloc.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/views/intro/indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Intro3 extends StatefulWidget {
  const Intro3({super.key});

  @override
  State<Intro3> createState() => _Intro3State();
}

class _Intro3State extends State<Intro3> {
  _navigate(String route) {
    Navigator.of(context).popUntil((route) => false);
    Navigator.of(context).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
          if (state is NavigateToOnboarding) {
            _navigate("/onboard1");
          }
          if (state is NavigateToDashboard) {
            _navigate("/home");
          }
          if (state is NavigateToSignup) {
            _navigate("/signup");
          }
          if (state is NavigateToVerifyPhone) {
            _navigate("/verifyPhone");
          }
        },
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/intro3.svg",
                          height: 0.7222222222 * width,
                          width: 0.7222222222 * width,
                        ),
                        const Text(
                          "Showcase Your Product Catalogue",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          "Display your products in an organized and attractive manner, making it easier for clients to discover what you offer.",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    const Indicator(index: 2),
                    SizedBox(
                      height: 0.04506437768 * height,
                    ),
                    CustomButton(
                      onPressed: () {
                        context.read<SplashScreenBloc>().add(CheckLoginStatus(
                              isInsideIntro: true,
                            ));
                      },
                      title: "NEXT",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
