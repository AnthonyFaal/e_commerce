import 'dart:convert';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

 Future<Users?> register(String email, String password, String username) async {
  try {
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/users'),
      body: {'email': email, 'password': password, 'username': username},
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('id')) {
        // If the response contains an 'id' field, create a dummy user
        Users user = Users(
          id: responseData['id'].toString(),
          email: email,
          username: username,
        );

        // Save user ID locally using SharedPreferences (if needed)
        await saveUserIdLocally(user.id);

        return user;
      } else {
        // Handle registration failure
        print('Registration failed: ${responseData['message']}');
        return null;
      }
    } else {
      // Handle other error cases
      print('Registration failed with status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    // Handle network errors
    print('Error during registration: $e');
    return null;
  }
}


  
  
   final String apiUrl = 'https://fakestoreapi.com/auth/login';
Future<Users?> login(String username, String password) async {
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {'username': username, 'password': password},
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('token')) {
        // If the response contains a 'token' field, create a dummy user
        Users user = Users(id: 'dummyId', email: 'dummy@email.com', username: username);

        // Save user ID locally using SharedPreferences (if needed)
        await saveUserIdLocally(user.id);

        return user;
      } else {
        // Handle login failure
        print('Login failed: ${responseData['message']}');
        return null;
      }
    } else {
      // Handle other error cases
      print('Login failed with status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    // Handle network errors
    print('Error during login: $e');
    return null;
  }
}


Future<Users?> updateUser(String userId, String newEmail, String newPassword) async {
    try {
      final response = await http.put(
        Uri.parse('https://fakestoreapi.com/users/$userId'),
        body: {'email': newEmail, 'password': newPassword},
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == true) {
          Users user = Users.fromJson(responseData['data']);
          return user;
        } else {
          // Handle update failure
          print('Update failed: ${responseData['message']}');
          return null;
        }
      } else {
        // Handle other error cases
        print('Update failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle network errors
      print('Error during update: $e');
      return null;
    }
  }


 Future<void> deleteUser(String userId) async {
    try {
      final response = await http.delete(
        Uri.parse('https://fakestoreapi.com/users/$userId'),
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == true) {
          print('User deleted successfully');
        } else {
          // Handle delete failure
          print('Delete failed: ${responseData['message']}');
        }
      } else {
        // Handle other error cases
        print('Delete failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      print('Error during delete: $e');
    }
  }


  Future<void> saveUserIdLocally(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', userId);
  }

  Future<String?> getLocalUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }


Future<void> logout() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
    prefs.setBool('isLoggedIn', false);
    // Close the app
     // exit(0);
  } catch (e) {
    print('Error during logout: $e');
  }
}

}
