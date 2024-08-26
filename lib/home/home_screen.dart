import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pictures_dot_com/helper/pick_image.dart';
import 'package:pictures_dot_com/home/trending_pics.dart';
import 'package:pictures_dot_com/profile/login_screen.dart';
import 'package:pictures_dot_com/profile/profile_screen.dart';
import 'dart:developer';

import 'category_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool isLoggedIn = false;
  late ProfileScreen _profileScreen; // Store ProfileScreen with user info

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 4 && !isLoggedIn) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(
              onLogin: (displayName, email, photoUrl, phoneNumber) {
                setState(() {
                  isLoggedIn = true;
                  _selectedIndex = 4;
                  Navigator.pop(context);
                  _profileScreen = ProfileScreen(
                    onLogout: () {
                      setState(() {
                        isLoggedIn = false;
                      });
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    displayName: displayName,
                    email: email,
                    photoUrl: photoUrl,
                    phoneNumber: phoneNumber,
                  );
                });
              },
            ),
          ),
        );
      }
      if (index == 2 && !isLoggedIn) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(
              onLogin: (displayName, email, photoUrl, phoneNumber) {
                setState(() {
                  isLoggedIn = true;
                  _selectedIndex = 2;
                  Navigator.pop(context);
                  _profileScreen = ProfileScreen(
                    onLogout: () {
                      setState(() {
                        isLoggedIn = false;
                      });
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    displayName: displayName,
                    email: email,
                    photoUrl: photoUrl,
                    phoneNumber: phoneNumber,
                  );
                  _onItemTapped(2);
                });
              },
            ),
          ),
        );
      }
      if (index == 2 && isLoggedIn) {
        Get.defaultDialog(
          title: 'Confirmation Of Media Rights',
          titlePadding: EdgeInsets.all(20),
          middleText:
              'You may only upload photos and video that you own the rights',
          contentPadding: EdgeInsets.all(20),
          confirm: TextButton(
              onPressed: () {
                PickImages().pickAndUploadImage();
                Get.back();
                _selectedIndex = 0;
                if (mounted) {
                  setState(() {});
                }
              },
              child: Text(
                'Upload',
                style: TextStyle(color: Colors.green),
              )),
        );
      }
      // if (index == 1) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => Material(child: categoryViewClass())), // Wrap with Material
      //   );
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for amazing photos',
                    icon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _selectedIndex == 0
                ? const DefaultTabController(
                    length: 2,
                    child: Expanded(
                      child: Column(
                        children: [
                          TabBar(
                            labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: Colors.black),
                            tabs: [
                              Tab(text: 'Trending'),
                              Tab(text: 'Following'),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                TrendingPicsList(),
                                Center(
                                    child: Text('Following content goes here')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: _selectedIndex == 4
                        ? isLoggedIn
                            ? _profileScreen
                            : LoginScreen(
                                onLogin: (displayName, email, photoUrl,
                                    phonenumber) {
                                  setState(() {
                                    isLoggedIn = true;
                                    Navigator.pop(context);
                                    _profileScreen = ProfileScreen(
                                      onLogout: () {
                                        setState(() {
                                          isLoggedIn = false;
                                        });
                                        if (mounted) {
                                          setState(() {});
                                        }
                                      },
                                      displayName: displayName,
                                      email: email,
                                      photoUrl: photoUrl,
                                    );
                                  });
                                },
                              )
                        : _selectedIndex == 1 // Check for index 1
                            ? Material(
                                child:
                                    categoryViewClass()) // Render categoryViewClass
                            : Center(
                                child: _selectedIndex != 2
                                    ? Text(
                                        'Content for index $_selectedIndex',
                                        style: TextStyle(fontSize: 24),
                                      )
                                    : null,
                              ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.add_circled_solid,
              color: Colors.black,
              size: 40,
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bell),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        onTap: _onItemTapped,
        selectedIconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
    );
  }
}
