import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_api/Internet_Connection/Internet_Screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: FlutterSplashScreen(
        duration: const Duration(seconds: 8),
        nextScreen: const InternetScreen(),
        backgroundColor: Colors.pinkAccent,
        splashScreenBody: Center(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/image/ecommerce.json',
                    width: 250,
                    height: 250,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
