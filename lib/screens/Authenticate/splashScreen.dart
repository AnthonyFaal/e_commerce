import 'dart:async';

import 'package:flutter/material.dart';

import '../../shared/constants.dart';
import 'authenticate.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  
 @override
void initState() {
 Timer(Duration(seconds: 10000), (){
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> 
Authenticate()));
});
 super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(image: 
        AssetImage("assets/background/background1.jpeg"),
        fit: BoxFit.fill)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("Welcome to my ecommerce app",
            style:splashTextStyle ,),
          ),
          Center(
            child: Text("Your number one ecommerce platform",
             style: splashTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18
             ),),
          )
        ],
      ),
    );
  }
}