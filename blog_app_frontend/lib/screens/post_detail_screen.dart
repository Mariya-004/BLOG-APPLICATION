import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class PostDetailScreen extends StatelessWidget {
  final int postId;
  PostDetailScreen({required this.postId});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Post Details')),
        body: FutureBuilder<Post?>(
          future: ApiService.fetchPostDetail(postId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
            final post = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('By ${post.author} • ${post.createdAt}', style: TextStyle(color: Colors.grey)),
                  Divider(),
                  SizedBox(height: 10),
                  Text(post.content),
                ],
              ),
            );
          },
        ),
      );
}
