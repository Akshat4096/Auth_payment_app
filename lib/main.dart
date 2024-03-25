
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_series/EasyearnScreen.dart';
import 'package:firebase_series/Screens/Auth/LoginScreen.dart';
import 'package:firebase_series/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'firebase_options.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  final dynamiclinkparams = DynamicLinkParameters(
      link: Uri.parse("https://com.example.firebase_series/"),
      uriPrefix: "https://firebaseseriesakshat.page.link",
      androidParameters: AndroidParameters(packageName: "com.example.firebase_series"),
      iosParameters:  IOSParameters(bundleId: "com.example.firebaseSeries"),
  );

  final dynamicLink = await FirebaseDynamicLinks.instance.buildLink(dynamiclinkparams);
  print("Here is my dynamic link for this app ${dynamicLink}");
  // RazorpayService.initRazorpay();

  Stripe.publishableKey= "";

  await dotenv.load(fileName : "assets/.env");

  runApp(MyApp());

}
 class MyApp extends StatefulWidget {
    MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   User? user ;

   void initState(){
     user = FirebaseAuth.instance.currentUser;
   }

   @override
   Widget build(BuildContext context) {
     return MaterialApp(

       initialRoute: user != null? "EasyEarn": "Login" ,
       routes: {
         "EasyEarn" : (context) => EasyEarnScreen(),
         "Login" : (context) => LoginScreen()
       },

       debugShowCheckedModeBanner: false,
       home: LoginScreen(),
     );
   }
}
