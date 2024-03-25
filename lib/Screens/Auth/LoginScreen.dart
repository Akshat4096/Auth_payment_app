import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/EasyearnScreen.dart';
import 'package:firebase_series/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import '../Component/Login_Button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgetpassScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool value = false ;
  final _email = TextEditingController();
  final _password = TextEditingController();


  @override
  void initState(){
    super.initState();
    _getSavedCredentials();

  }


  void _getSavedCredentials() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if(email != null && password != null){
      setState(() {
        _email.text = email ;
        _password.text = password ;
        value = true ;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body : Padding(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Center(
            child: Column(
              children:<Widget> [
                Container(
                  height: MediaQuery.of(context).size.height /2.5,
                  child: Column(
                    children :<Widget> [
                      Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),) ,
                      SizedBox(height: 30,),
                      SvgPicture.asset(
                        'assets/logoimg.svg',
                        height: 230,
                        width: double.infinity,
                      ) ,],
                  ),
                ) ,
                Expanded(
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            )
                        ),
                        child: SingleChildScrollView(
                          child: Form(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Material(
                                    elevation: 3,
                                    child: TextField(
                                      controller: _email,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.fromLTRB(30,10, 50, 10 ),
                                          child: Icon(
                                            Icons.email_outlined ,
                                            color: Colors.black,
                                          ),
                                        ),
                                        hintText: 'E-mail',
                                      ),
                                    ),
                                  ) ,
                                  SizedBox(height: 40,),
                                  Material(
                                    elevation: 3,
                                    child: TextField(
                                      controller: _password,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.fromLTRB(30,10, 50, 10 ),
                                          child: Icon(
                                            Icons.lock_open ,
                                            color: Colors.black,
                                          ),
                                        ),
                                        hintText: 'Password',
                                      ),
                                    ),
                                  ) ,
                                  SizedBox(height: 5,),
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        activeColor: Colors.blue,
                                        value: this.value,
                                        onChanged: (bool? value){
                                          setState(()=> this.value = value!);
                                        },
                                      ) ,
                                      Text('Remember me',style: TextStyle(fontSize: 15),),
                                      SizedBox(width: MediaQuery.of(context).size.height/33,),
                                      TextButton(onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> forgetpass()));
                                      }, child: Text(
                                        'Forget Password?' ,style: TextStyle(
                                        fontSize: 15,
                                      ),
                                      )) ,
                                    ],
                                  ) ,
                                  SizedBox(
                                    height: 40,
                                  ) ,

                                  ElevatedButton(onPressed: () {
                                    _login();
                                  },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(40, 12, 40, 12),
                                      child: Text('Login'),
                                    ) ,
                                    style: ElevatedButton.styleFrom(
                                        shadowColor: Colors.blueAccent,
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ) ,
                                        textStyle: TextStyle(
                                          fontSize: 18 ,

                                        )
                                    ),

                                  ) ,
                                  SizedBox(height: 5,),
                                  Login_Btn()

                                ],
                              ),
                            ),
                          ),
                        )
                    )
                )
              ],
            ),
          ),
        )
    );
  }

  Future <void> _login() async {
    if (_email == "" && _password == "") {
      print("Enter your required fields");
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.text, password: _password.text).then((value) => 
        Navigator.push(context, MaterialPageRoute(builder: (context)=>EasyEarnScreen()))
        );

        if (value==true) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', _email.text);
          prefs.setString('password', _password.text);

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EasyEarnScreen()));
        }
      } on FirebaseException catch (e) {
        print('Error occurs ${e}');
      }
    }
  }
  //
  // void _login(String email , String password) async{
  //       if(email == "" && password == ""){
  //         print("Enter your required fields");
  //       } else {
  //         UserCredential? userCredential ;
  //         try{
  //           userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) =>
  //           Navigator.push(context, MaterialPageRoute(builder: (context)=> EasyEarnScreen()))
  //           );
  //         } on FirebaseException catch(e){
  //           print('Error occur ${e}');
  //         }
  //       }
  // }
}
