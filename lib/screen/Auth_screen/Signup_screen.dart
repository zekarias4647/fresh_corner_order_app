import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cool_ui/cool_ui.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:image_picker/image_picker.dart';

import '../transitions/registerd_succ.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  File? _imageFile;



  Future<void> pickImage() async {
    if (kIsWeb) {
      // Web-specific code (if needed)
    } else {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16.0),
                  Text(
                    'Fresh Corner',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: pickImage, // Use the correct method name
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: _imageFile != null
                              ? FileImage(_imageFile!)
                              : AssetImage('asset/image/zf5r_euha_230522.jpg',) as ImageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  _buildCoolButtonTextField('First Name', Icons.person),
                  SizedBox(height: 16.0),
                  _buildCoolButtonTextField('Last Name', Icons.person),
                  SizedBox(height: 16.0),
                  _buildCoolButtonTextField('Email', Icons.email),
                  SizedBox(height: 16.0),
                  _buildCoolButtonTextField('Password', Icons.lock, isPassword: true),
                  SizedBox(height: 24.0),
                  _buildCoolButtonTextField('License Plate', Icons.car_crash, isPassword: true),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisteredSuccessfully()),
                      );  // Handle login logic
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF4CAF50),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Sign-up',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoolButtonTextField(String label, IconData icon, {bool isPassword = false}) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 50,
      borderRadius: 8,
      blur: 10,
      alignment: Alignment.center,
      border: 2,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
      ),
      child: TextField(
        obscureText: isPassword,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(icon, color: Colors.white),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
