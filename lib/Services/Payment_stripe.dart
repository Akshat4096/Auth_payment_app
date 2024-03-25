import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart'as http ;
class payment_stripe extends StatefulWidget {
  const payment_stripe({super.key});
  @override
  State<payment_stripe> createState() => _payment_stripeState();
}

class _payment_stripeState extends State<payment_stripe> {
  // @override
  // void initState(){
  //   Stripe.instance.setOptions(
  //     StripeOptions(publishableKey : "")
  //   );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }

  createPaymentIntent(String amount , String currenct) async{
    try{
      Map<String , dynamic> body = {
        'amount' : 100,
        'currency' : "currency" ,
        'payment_method_types[]' : "card[]" ,
      };
      var secretkey = 'your_secret_key' ;

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents') ,
        headers : {
          "Authorization " : 'Bearer $secretkey' ,
          'content-type ' : 'application/x-www-form-urlencoded'
        },
        body : body ,

      );
      print('Payment intent body ${response.body.toString()}');
      return jsonDecode(response.body.toString());
    } catch(e){
      throw(Exception(e));
    }
  }
}
