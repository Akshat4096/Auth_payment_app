import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/EasyearnScreen.dart';
import 'package:firebase_series/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}
class _SignupScreenState extends State<SignupScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  void dispose() {

    super.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2.8,
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.black,
                            )),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          'Create Account',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SvgPicture.asset(
                      'assets/signupimg.svg',
                      height: 230,
                      width: double.infinity,
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    )),
                child: SingleChildScrollView(
                  child: Form(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // SizedBox(height: 20,),
                          Material(
                            elevation: 3,
                            child: TextField(
                              controller: name,
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(30, 10, 50, 10),
                                    child: Icon(
                                      Icons.person_outline,
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: 'User Name'),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 3,
                            child: TextField(
                              controller: email,
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(30, 10, 50, 10),
                                    child: Icon(
                                      Icons.mail_outline,
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: 'E-mail'),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 3,
                            child: TextField(
                              controller: password,
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(30, 10, 50, 10),
                                    child: Icon(
                                      Icons.lock_outline,
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: 'Password'),
                            ),
                          ),
                          SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () {
                              _signup(email.text.toString(),
                                  password.text.toString());
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(25, 12, 25, 12),
                              child: Text('Sign Up'),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                shadowColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                textStyle: TextStyle(
                                  fontSize: 18,
                                )),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account ? ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ));
                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.black,
                                          decorationThickness: 3,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.blue.shade900),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  void _signup(String email, String password) async {

      if(email=="" && password==""){
        print('Enter the required fields');
      } else {
        UserCredential? userCredential ;
        try{
          userCredential =await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) =>
          Navigator.push(context, MaterialPageRoute(builder: (context)=> EasyEarnScreen())));

          FirebaseFirestore.instance.collection("users").doc().set({
            "name": name,
            "email" : email,
            "password" : password,
            "createAt" : DateTime.now(),
          });
        } on  FirebaseException catch(e){
          print("Error is occur${e}");
        }
      }
  }

}
