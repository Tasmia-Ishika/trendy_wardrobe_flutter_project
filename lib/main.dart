import 'package:final_flutter_project/users/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Trendy Wardrobe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: FutureBuilder( future: null,
          builder: (context, dataSnapShot){
            return LoginScreen();
          },
      ),
    );
  }
}

