import 'package:flutter/material.dart';

import 'presentation/screens/home/home_screen.dart';

class DDD extends StatelessWidget {
  const DDD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
