import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String title = '', content = '';
  String error = '';

  void _submit() async {
    final success = await ApiService.createPost(title, content);
    if (success) {
      Navigator.pop(context);
    } else {
      setState(() => error = 'Failed to create post');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Create Post')),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            TextField(onChanged: (v) => title = v, decoration: InputDecoration(labelText: 'Title')),
            TextField(onChanged: (v) => content = v, decoration: InputDecoration(labelText: 'Content'), maxLines: 6),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: Text('Submit')),
            if (error.isNotEmpty) Text(error, style: TextStyle(color: Colors.red)),
          ]),
        ),
      );
}
