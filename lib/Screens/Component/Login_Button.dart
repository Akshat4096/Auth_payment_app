import 'package:flutter/material.dart';

import '../Auth/SignupScreen.dart';


class Login_Btn extends StatefulWidget {
  const Login_Btn({super.key});

  @override
  State<Login_Btn> createState() => _Login_BtnState();
}

class _Login_BtnState extends State<Login_Btn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Don`t have an account ? ',style: TextStyle(
              fontSize: 15,fontWeight: FontWeight.bold
          ),) ,
          TextButton(onPressed: (){
            SignUp(context);
          }, child: Text('Sign Up',style: TextStyle(decoration: TextDecoration.underline,
              decorationColor: Colors.black,
              decorationThickness: 3,
              fontWeight: FontWeight.bold ,fontSize: 17 , color: Colors.blue.shade900
          ),)) ,
        ],
      ),
    );
  }
  void SignUp(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen(),));
  }
}
