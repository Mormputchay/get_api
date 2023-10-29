import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_api/home_screen.dart';
import 'package:lottie/lottie.dart';

// ignore: non_constant_identifier_names
class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Lottie.asset("assets/image/noInternet.json",
                  width: 300, height: 300)),
          const Text(
            "No Internet connection",
            style: TextStyle(
                fontSize: 23,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 8),
          const Text("Check your connection, then refresh the page."),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async {
              ConnectivityResult result =
                  await Connectivity().checkConnectivity();
              print(result.toString());
              // ignore: use_build_context_synchronously
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            style: ElevatedButton.styleFrom(primary: Colors.green),
            child: const Text('Refresh'),
          )
        ],
      ),
    );
  }
}
