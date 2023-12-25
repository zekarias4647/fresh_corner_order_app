import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freshcornersample/screen/homescreen/home_screen.dart';
import 'package:lottie/lottie.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({Key? key}) : super(key: key);

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay before navigating to the home screen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(), // Replace HomeScreen with your actual home screen widget
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
          SizedBox(height: 300,),
            Center(
              child: Lottie.asset('asset/lottie/pFvXRA8hwS.json',
                height: 300,
                width: 300,
                repeat: false


              ), // Replace with the correct Lottie animation file path
            ),
            Center(child: Text('Thank you for Purchasing ')),
          ],
        ),
      ),
    );
  }
}

