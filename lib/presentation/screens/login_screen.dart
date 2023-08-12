// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:post_app/domain/models/user.dart';
import 'package:post_app/presentation/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  final User? user;

  const LoginScreen({super.key, this.user});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.user?.email);
    _passwordController = TextEditingController(text: widget.user?.password);
  }

  void checker() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (!(RegExp(r'^\w{3,}@[a-z]{3,}\.[a-z]{2,}$').hasMatch(email)) ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email is not valid'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (!(RegExp(r'[A-Z]').hasMatch(password) &&
            RegExp(r'[a-z]').hasMatch(password) &&
            RegExp(r'[0-9]').hasMatch(password) &&
            password.length >= 8) ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Password must contain at least 8 characters, including uppercase, lowercase and numbers'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final Box userBox = Hive.box('userBox');

    final List<dynamic> usersFromStorage = await userBox.get('users') ?? [];

    for (final Map item in usersFromStorage) {
      if ((item['email'] == email) && (item['password'] == password)) {
        if (mounted) {
          goToHomeScreen();
        }
        return;
      }
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('This email is not registered yet. Please register first'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void goToHomeScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ),
      (route) => false,
    );
  }

  void changeVisibility() {
    isVisible = !isVisible;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF432C81),
                  ),
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Color(0xFF432C81),
                  ),
                ),
                const SizedBox(height: 30),
                Image(
                  image: const AssetImage('assets/images/main_character.png'),
                  height: MediaQuery.sizeOf(context).height * 0.35,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Color(0xFFEDECF4)),
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Color(0xFF7B6BA8)),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: isVisible,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Color(0xFFEDECF4)),
                    ),
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Color(0xFF7B6BA8)),
                    suffixIcon: IconButton(
                      onPressed: changeVisibility,
                      icon: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off,
                        color: const Color(0xFFA095C1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: checker,
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    fixedSize: Size(MediaQuery.sizeOf(context).width, 50),
                    backgroundColor: const Color(0xFF432C81),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
