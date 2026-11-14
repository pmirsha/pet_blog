import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String authorId;
  final String authorName;
  final String title;
  final String content;
  final String imageUrl;
  final String petName;
  final String petType;
  final DateTime createdAt;
  final List<String> likedBy;

  Post({
    this.id = '',
    required this.authorId,
    required this.authorName,
    required this.title,
    required this.content,
    this.imageUrl = '',
    required this.petName,
    required this.petType,
    DateTime? createdAt,
    this.likedBy = const [],
  }) : createdAt = createdAt ?? DateTime.now();

  int get likeCount => likedBy.length;

  factory Post.fromMap(String id, Map<String, dynamic> map) {
    return Post(
      id: id,
      authorId: map['authorId'] ?? '',
      authorName: map['authorName'] ?? 'Unknown',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      petName: map['petName'] ?? '',
      petType: map['petType'] ?? 'Other',
      // createdAt is null briefly while the server timestamp is pending
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      likedBy: List<String>.from(map['likedBy'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'authorId': authorId,
      'authorName': authorName,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'petName': petName,
      'petType': petType,
      'createdAt': FieldValue.serverTimestamp(),
      'likedBy': likedBy,
    };
  }
}
