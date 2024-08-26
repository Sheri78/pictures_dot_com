import 'package:flutter/material.dart';
import 'package:pictures_dot_com/api/apis.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback onLogout;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final String? phoneNumber;

  const ProfileScreen({
    super.key,
    required this.onLogout,
    this.displayName,
    this.email,
    this.photoUrl,
    this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Screen',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.deepOrangeAccent,
          elevation: 4,
          onPressed: () async {
            //sign out from app
            await APIs.auth.signOut().then((value) async {
              // Handle any sign-out actions here
              onLogout();
              Navigator.pop(context);
            });
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          label: const Text(
            'Logout',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: photoUrl != null
                  ? NetworkImage(photoUrl!)
                  : AssetImage('assets/profile.jpg'), // Fallback image
            ),
            const SizedBox(height: 20),
            Text(
              displayName ?? 'User', // Display name or "User" if null
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              email ?? 'user@example.com', // Display email or default if null
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            const SizedBox(height: 10),
            Text(
              phoneNumber ?? 'Phone number not available', // Display phone number or message
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}