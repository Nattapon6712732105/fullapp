import 'package:flutter/material.dart';
import 'package:shopf/my_home_page.dart';
import 'package:shopf/screens/auth/welcome.dart';
import 'package:shopf/helpers/db_helper.dart';
import 'package:get/get.dart';

import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shopf',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF87CF3E),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: DBHelper().isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Color(0xFF151515),
              body: Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF87CF3E),
                ),
              ),
            );
          }
          if (snapshot.data == true) {
            return const MyHomePage(title: 'Shopf Home');
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
