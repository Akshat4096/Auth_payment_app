import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class payment_razorpay extends StatefulWidget {
  const payment_razorpay({Key? key}) : super(key: key);

  @override
  State<payment_razorpay> createState() => _payment_razorpayState();
}

class _payment_razorpayState extends State<payment_razorpay> {
  var _razorpay = Razorpay();


  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, errorHandler);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, successHandler);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWalletHandler);
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    _razorpay.clear();
  }
  TextEditingController amountController = TextEditingController();
  void errorHandler(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.message!),
      backgroundColor: Colors.red,
    ));
    showAlertDialog(context, 'Payment Failed', 'Payment Failed , please try again');
  }

  void successHandler(PaymentSuccessResponse response) {
    User? user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      String userId = user.uid;
      var email = user.email;

      //Storing payment details
      FirebaseFirestore.instance.collection('payments').add({
        'userId' : userId,
        'email' : email,
        'amount' : num.parse(amountController.text),
        'paymentId' : response.paymentId,
        'orderId' : response.orderId,
        'signature' : response.signature,
        'timestamp' : FieldValue.serverTimestamp(),
        'customer_id' : 'cust_NoFBLIyaxaAwIJ',
        'save' : 1

      });

    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.paymentId!),
      backgroundColor: Colors.green,

    ));
  }

  void externalWalletHandler(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.walletName!),
      backgroundColor: Colors.green,
    ));
    showAlertDialog(context, 'Payment Failed', 'Payment Failed , please try again');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Razor pay")),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    hintText: "Amount",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: () {
                openCheckout();
              },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 12, 40, 12),
                  child: Text('Pay-Now'),
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
            ],
          )),
    );
  }

  void openCheckout() {
    var options = {
      "key": "Your_key",
      'key_Secret' : "Secret_key",
      "amount": num.parse(amountController.text)*100,
      "name": "test",
      "description": " this is the test payment",
      "timeout": "180",
      "currency": "INR",
      'customer_id' : 'Id',
      'save' : 1

      // "customer_id" : "cust_4lsdkfldlteskf"
    };
    _razorpay.open(options);
  }

void showAlertDialog(BuildContext context , String title , String content){
    showDialog(
        context: context,
        builder: (BuildContext){
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
          }, child: Text('Ok'))
            ],

      );
        }
    );

}

}
