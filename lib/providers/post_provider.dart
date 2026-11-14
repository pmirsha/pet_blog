import 'package:flutter/foundation.dart';
import 'package:pet_blog/models/post.dart';
import 'package:pet_blog/services/post_service.dart';

class PostProvider extends ChangeNotifier {
  final PostService _service = PostService();

  Stream<List<Post>> get postsStream => _service.getPosts();

  Future<void> addPost(Post post) async {
    await _service.addPost(post);
    notifyListeners();
  }
}
