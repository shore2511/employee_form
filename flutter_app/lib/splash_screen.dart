import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_app/pages/home_page.dart';
import 'package:animate_do/animate_do.dart'; // Import animate_do

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Set a timer for 3 seconds before navigating to HomePage
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(171, 178, 255, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Apply FadeInDown animation to the image
            FadeInDown(
              child: Image.network(
                'https://utfs.io/f/AKh1tRQO1vwW7EFKYmP0NOcb7r1D8vxn3QBLITF2etK9iHYs',
                width: 250,
                height: 250,
              ),
            ),
            SizedBox(height: 20),

            // Apply FadeInUp animation to the text "WorkWise"
            FadeInUp(
              child: Text(
                'WorkWise',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
