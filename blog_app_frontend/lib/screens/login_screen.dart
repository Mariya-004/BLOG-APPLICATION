import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import 'post_list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '', password = '';
  String error = '';

  void _login() async {
    final token = await ApiService.login(username, password);
    if (token != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PostListScreen()));
    } else {
      setState(() => error = 'Invalid credentials');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            TextField(onChanged: (v) => username = v, decoration: InputDecoration(labelText: 'Username')),
            TextField(onChanged: (v) => password = v, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text('Login')),
            if (error.isNotEmpty) Text(error, style: TextStyle(color: Colors.red))
          ]),
        ),
      );
}
