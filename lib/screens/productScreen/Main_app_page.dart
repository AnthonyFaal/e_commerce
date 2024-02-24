import 'package:e_commerce_app/services/auth.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../models/user.dart';
import '../Authenticate/splashScreen.dart';
import 'cartpage.dart';
import 'product_list_page.dart';


class MainAppPage extends StatefulWidget {
  final Users user;
  const MainAppPage({Key? key, required this.user}) : super(key: key);

  
  @override
  _MainAppPageState createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
   // HomePage(),
    ProductListPage(),
      CartPage(cartProducts: [],),
   // Profile(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

AuthService auth= AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('E-commerce App')),
         // Light and dark mode
          actions: [
         
          IconButton(
              icon: Icon(Icons.nightlight_round),
              onPressed: () {
                themeMode.value = themeMode.value == 1 ? 2 : 1;
              })]
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color.fromARGB(255, 78, 4, 237).withOpacity(0.7), // Background color of the selected item
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
        
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          selectedIconTheme: IconThemeData(color: Colors.black), // Icon color of the selected item
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 28,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_basket,
                size: 28,
              ),
              label: 'Cart',
            ),
          ],
        ),
      ),
    

    //Drawer code
    drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                accountName: Text(
                  "Abhishek Mishra"//https://fakestoreapi.com/users
                  ,
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("abhishekm977@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text(' History '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
           
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(' Edit Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
               auth.logout;
               /* Navigator.pushReplacement(
                  context,
              MaterialPageRoute(builder: (context) =>Splashscreen()),
             );*/
              },
            ),
          ],
        ),
      ),
    );
  }
}
