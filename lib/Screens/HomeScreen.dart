import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/Screens/Auth/LoginScreen.dart';
import 'package:flutter/material.dart';

import '../EasyearnScreen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // return Checkuser();
    return Scaffold();
  }

  // Checkuser() {
  //   final user = FirebaseAuth.instance.currentUser;
  //

  //   if(user != null){
  //     return EasyEarnScreen();
  //   } else {
  //     LoginScreen();
  //   }
  }

