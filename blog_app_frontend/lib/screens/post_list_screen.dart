import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import 'create_post_screen.dart';
import 'login_screen.dart';
import 'post_detail_screen.dart';

class PostListScreen extends StatefulWidget {
  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  List<Post> posts = [];
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final token = await AuthService.getToken();
    final result = await ApiService.fetchPosts();
    setState(() {
      posts = result;
      isLoggedIn = token != null;
    });
  }

  void _logout() async {
    await AuthService.logout();
    setState(() => isLoggedIn = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
          actions: [
            isLoggedIn
                ? IconButton(icon: Icon(Icons.logout), onPressed: _logout)
                : IconButton(icon: Icon(Icons.login), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen())))
          ],
        ),
        body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (_, i) => ListTile(
            title: Text(posts[i].title),
            subtitle: Text(posts[i].summary),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PostDetailScreen(postId: posts[i].id)),
            ),
          ),
        ),
        floatingActionButton: isLoggedIn
            ? FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CreatePostScreen())),
              )
            : null,
      );
}
