import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/post_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blog App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: PostListScreen(),
      );
}
