import 'package:e_commerce_app/screens/productScreen/Main_app_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user.dart';
import '../../services/auth.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';



class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
   TextEditingController usernameController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
    AuthService authService = AuthService();
  String _errorMessage = '';
  bool loading = false;
  bool _isPasswordVisible = false;

  Future<void> _handleLogin() async {
  String username = usernameController.text;
  String password = passwordController.text;
  SharedPreferences prefs =await SharedPreferences.getInstance();

  if (username.isNotEmpty && password.isNotEmpty) {
    Users? user = await authService.login(username, password);

    if (user != null) {
      prefs.setBool("isLoggedIn", true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainAppPage(user: user),
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid Details.';
      });
    }
  } else {
    setState(() {
      if (username.isEmpty && password.isEmpty) {
        _errorMessage = 'Please enter both email and password.';
      } else if (username.isEmpty) {
        _errorMessage = 'Please enter your email.';
      } else {
        _errorMessage = 'Please enter your password.';
      }
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Center(child: Text('Sign In to Your App')),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'User Name'),
                        keyboardType: TextInputType.emailAddress,
                        controller: usernameController,
                      ),
                      SizedBox(height: 20.0),

                      TextFormField(
                        obscureText: !_isPasswordVisible,
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          ),
                        controller: passwordController,
                      ),
                      SizedBox(height: 20.0),

                      //Submit Button
                      
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          fixedSize: Size(300, 60),
                          textStyle: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        child: Text('Sign In'),
                        onPressed:_handleLogin,
                      ),
                     
                      SizedBox(height: 20.0),

                      Row(
                        children: [
                          Text("Don't have an account?"),
                          GestureDetector(
                            child: Text("Register"),
                           onTap: () => widget.toggleView(), 
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                     if(_errorMessage.isNotEmpty) Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                    
                  ),
                ),
              ),
            ),
          );
  }

}







