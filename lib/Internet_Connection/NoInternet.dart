import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: non_constant_identifier_names
Widget NoInternet() {
  return Container(
    color: Colors.white,
    child: Center(
      child:
          Lottie.asset('assets/image/noInternet.json', width: 250, height: 250),
    ),
  );
}
