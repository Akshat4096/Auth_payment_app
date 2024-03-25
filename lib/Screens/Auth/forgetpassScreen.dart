import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class forgetpass extends StatefulWidget {
  const forgetpass({super.key});

  @override
  State<forgetpass> createState() => _forgetpassState();
}

class _forgetpassState extends State<forgetpass> {
 TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
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
                                  ElevatedButton(onPressed: () {
                                    _forgetpassword(_email.text.toString());
                                  },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(40, 12, 40, 12),
                                      child: Text('Reset Password'),
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
  void _forgetpassword (String email) async {
    if(email == ""){
      print('Enter Required fields');
    } else {
     FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }

  }
}
