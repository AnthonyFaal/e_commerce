import 'package:e_commerce_app/screens/wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
final themeMode = ValueNotifier(2);
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
         builder: (context, value, g) {
        return   MaterialApp(
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.values.toList()[value as int],
        debugShowCheckedModeBanner: false,
        home:Wrapper(),//SplashScreen(),
       );
        },
         valueListenable: themeMode,
      );
  }
}
