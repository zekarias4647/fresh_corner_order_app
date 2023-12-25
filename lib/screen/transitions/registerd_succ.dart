import 'package:flutter/material.dart';
import 'package:freshcornersample/screen/homescreen/home_screen.dart';
import 'package:lottie/lottie.dart';

class RegisteredSuccessfully extends StatefulWidget {
  const RegisteredSuccessfully({Key? key}) : super(key: key);

  @override
  _RegisteredSuccessfullyState createState() => _RegisteredSuccessfullyState();
}

class _RegisteredSuccessfullyState extends State<RegisteredSuccessfully>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Adjust the duration as needed
    );

    _animationController.forward();

    // After a delay, navigate to the login screen
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4CAF50), // Use a green color for the background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'asset/lottie/Animation - 1703071499254.json', // Replace with your Lottie animation file
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Registered Successfully',
              style: TextStyle(
                fontSize: 24, // Increase the font size
                fontWeight: FontWeight.bold,
                color: Colors.white, // Use white color for the text
              ),
            ),
            SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}
