import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_blog/provider/post_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'package:pet_blog/screens/auth/login_screen.dart';
import 'package:pet_blog/screens/home/home_screen.dart';
import 'package:pet_blog/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const PetBlogApp());
}

class PetBlogApp extends StatelessWidget {
  const PetBlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PostProvider())],
      child: MaterialApp(
        title: 'Pet Blog',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorSchemeSeed: Colors.orange, useMaterial3: true),
        home: const AuthGate(),
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) return const HomeScreen();
        return const LoginScreen();
      },
    );
  }
}
