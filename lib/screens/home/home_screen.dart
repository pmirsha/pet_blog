import 'package:flutter/material.dart';
import 'package:pet_blog/provider/post_provider.dart';
import 'package:provider/provider.dart';
import 'package:pet_blog/models/post.dart';

import 'package:pet_blog/services/auth_service.dart';
import 'package:pet_blog/widgets/post_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    final provider = context.read<PostProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Blog 🐾'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
            onPressed: auth.signOut,
          ),
        ],
      ),
      body: StreamBuilder<List<Post>>(
        stream: provider.postsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final posts = snapshot.data ?? [];
          if (posts.isEmpty) {
            return const Center(
              child: Text('No posts yet. Be the first to share! 🐶'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: posts.length,
            itemBuilder: (context, i) => PostCard(post: posts[i]),
          );
        },
      ),
      // TEMPORARY: remove on Day 4
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final user = auth.currentUser!;
          provider.addPost(
            Post(
              authorId: user.uid,
              authorName: user.displayName ?? 'Anonymous',
              title: 'Test post',
              content: 'This is a sample post to test the feed.',
              petName: 'Bruno',
              petType: 'Dog',
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
