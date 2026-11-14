class AppUser {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl = '',
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'name': name,
    'email': email,
    'photoUrl': photoUrl,
  };
}
