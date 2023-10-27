import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_api/Internet_Connection/Loading.dart';
import 'package:get_api/home_screen.dart';

import 'NoInternet.dart';

class InternetScreen extends StatefulWidget {
  const InternetScreen({super.key});
  @override
  State<InternetScreen> createState() => _InternetScreenState();
}

class _InternetScreenState extends State<InternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
            print(snapshot.toString());
            if (snapshot.hasData) {
              ConnectivityResult? result = snapshot.data;
              if (result == ConnectivityResult.mobile) {
                return const HomeScreen();
              } else if (result == ConnectivityResult.wifi) {
                return const HomeScreen();
              } else {
                return NoInternet();
              }
            } else {
              return const LoadingScreen();
            }
          },
        ),
      ),
    );
  }

  Widget connected(String type) {
    return Center(
      child: Text(
        '$type Connected',
        style: const TextStyle(color: Colors.green, fontSize: 20),
      ),
    );
  }
}
