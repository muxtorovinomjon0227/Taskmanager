import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database/main_provide.dart';
import 'database/screens/screens.dart';

/// Shu joyda yoziladdi
/// Shu joyda o'zgaradi
/// va yana


void main() {
  runApp(
    MultiProvider(providers: [

      /// Shu yarga yana boshqa prividerlar yossa bo'ladi
      ChangeNotifierProvider(
        create: (_) => MainProvider(),
      )
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }

// group2
}