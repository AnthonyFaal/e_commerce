import 'package:e_commerce_app/screens/Authenticate/splashScreen.dart';
import 'package:e_commerce_app/screens/productScreen/Main_app_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Users? user;
          if (snapshot.data == true) {
            user = getUserData();
          }

          return snapshot.data == true
              ?MainAppPage(user: user!,)
              : Splashscreen(); 
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn") ?? false;
  }
  Users getUserData() {
    return Users( id: '', username: '', email: '');}
}
