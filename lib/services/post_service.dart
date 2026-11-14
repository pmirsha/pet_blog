import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_blog/models/post.dart';

class PostService {
  final CollectionReference<Map<String, dynamic>> _posts =
      FirebaseFirestore.instance.collection('posts');

  Stream<List<Post>> getPosts() {
    return _posts
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => Post.fromMap(d.id, d.data())).toList());
  }

  Future<void> addPost(Post post) => _posts.add(post.toMap());
}