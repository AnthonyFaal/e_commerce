import 'package:e_commerce_app/screens/productScreen/Main_app_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../services/auth.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';


class Register extends StatefulWidget {
  final Function toggleView;

  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';
  bool loading = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =TextEditingController();
  AuthService authService = AuthService();
  bool passwordVisible = false;

   void _register() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String username = usernameController.text.trim();
     SharedPreferences prefs =await SharedPreferences.getInstance();

 if(!mounted){
  return;
 }
    Users? user = await authService.register(email, password, username);

    if (user != null) {
      // Registration successful, navigate to the home page
       prefs.setBool("isLoggedIn", true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainAppPage(user: user)),
      );
    } else {
     if(mounted){
      setState(() {
        _errorMessage = 'Failed to register.';
      });
     }
      
    }
  }


  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
           
            appBar: AppBar(
              elevation: 0,
              title: Center(child: Text("Register to Your App")),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: usernameController,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Name'),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: emailController,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: passwordController,
                        decoration: textInputDecoration.copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                          hintText: 'Password',
                        ),
                        obscureText: !passwordVisible,
                       
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: confirmPasswordController,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Confirm Password'),
                        obscureText: !passwordVisible,
                        validator: (val) => val != passwordController.text
                            ? 'Passwords do not match'
                            : null,
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          fixedSize: Size(300, 60),
                          textStyle: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onPressed:_register,
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?"),
                          GestureDetector(
                            child: Text("Sign In Here"),
                            onTap: () => widget.toggleView(),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}