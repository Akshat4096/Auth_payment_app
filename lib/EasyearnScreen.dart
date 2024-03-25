import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/Services/Payment_razorpay.dart';
import 'package:flutter/material.dart';

import 'Screens/Auth/LoginScreen.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'Services/Payment_stripe.dart';

class EasyEarnScreen extends StatefulWidget {
  const EasyEarnScreen({super.key});

  @override
  State<EasyEarnScreen> createState() => _EasyEarnScreenState();
}

class _EasyEarnScreenState extends State<EasyEarnScreen> {

  logout () async {
    FirebaseAuth.instance.signOut().then((value) =>
        Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context)=>LoginScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (counter) => payment_razorpay()));
          },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 12, 40, 12),
              child: Text('Payment with Razorpay'),
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
          SizedBox(height: 20,),
          ElevatedButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (counter) => payment_stripe()));
          },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 12, 40, 12),
              child: Text('Payment with Stripe'),
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
          SizedBox(height: 20,),
          Center(
            child:  ElevatedButton(onPressed: () {
              logout();
            },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 12, 40, 12),
                child: Text('Logout'),
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
          ),
        ],
      ),
    );
  }
}
