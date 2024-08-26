import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  final void Function(String?, String?, String?, String?)
      onLogin; // Updated signature

  const LoginScreen({super.key, required this.onLogin});

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null; // user canceled the sign-in process
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print('Error during Google sign-in: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/background.jpg'), // Your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // Bottom black container
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 400,
            width: double.infinity, // Ensure the width is constrained
            decoration: const BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
          ),
        ),

        // Centered content
        Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.photo_library,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Thousands of amazing photos & videos. For free.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  _buildLoginButton(
                    icon: Icons.email,
                    text: 'Continue with Email',
                    color: Colors.black,
                    onPressed: () {
                      // Handle email sign-in
                      onLogin(null, null, null, null); // Simulate login for now
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildLoginButton(
                    icon: Icons.facebook,
                    text: 'Continue with Facebook',
                    color: Colors.blueAccent,
                    onPressed: () {
                      // Handle Facebook sign-in
                      onLogin(null, null, null, null); // Simulate login for now
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildLoginButton(
                    icon: Icons.g_translate,
                    text: 'Continue with Google',
                    color: Colors.white,
                    textColor: Colors.black,
                    onPressed: () async {
                      User? user = await _signInWithGoogle();
                      if (user != null) {
                        // Get user information
                        String? displayName = user.displayName;
                        String? email = user.email;
                        String? photoUrl = user.photoURL;
                        String? phoneNumber = user
                            .phoneNumber; // Get phone number (might be null)                        log(user.toString());

                        // Call onLogin with user information
                        onLogin(displayName, email, photoUrl, phoneNumber);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // Navigate to Sign In screen
                    },
                    child: const Text(
                      'Already got an account? Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton({
    required IconData icon,
    required String text,
    required Color color,
    Color textColor = Colors.white,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: textColor),
      label: Text(text, style: TextStyle(color: textColor)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
