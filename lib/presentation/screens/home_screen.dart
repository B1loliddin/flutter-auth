import 'package:flutter/material.dart';
import 'package:post_app/core/service_locator.dart';
import 'package:post_app/domain/models/post.dart';
import 'package:post_app/presentation/screens/login_screen.dart';
import 'package:post_app/presentation/screens/registration_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    getAllPosts();
  }

  void getAllPosts() async {
    posts = await repository.fetchAllPosts();
    setState(() {});
  }

  void logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const RegistrationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final Post post = posts[index];

          return Card(
            child: ListTile(
              title: Text('Title: ${post.title}'),
              subtitle: Text('Body: ${post.body}'),
            ),
          );
        },
      ),
    );
  }
}
