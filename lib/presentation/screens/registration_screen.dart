import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:post_app/domain/models/user.dart';
import 'package:post_app/presentation/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void checker() async {
    final String username = _usernameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username cannot be empty'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (!(RegExp(r'^\w{3,}@[a-z]{3,}\.[a-z]{2,}$').hasMatch(email))) {
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
        password.length >= 8)) {
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
      if (item['email'] == email) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User with this email already exists'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }
    }

    final User user = User(
      id: usersFromStorage.length + 1,
      username: username,
      email: email,
      password: password,
    );

    usersFromStorage.add(user.toJson());

    userBox.put('users', usersFromStorage);

    goToLoginScreen(user: user);
  }

  void goToLoginScreen({User? user}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(user: user),
      ),
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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Hello Beautiful',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF432C81),
                  ),
                ),
                const Text(
                  'Registration',
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
                  controller: _usernameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Color(0xFFEDECF4)),
                    ),
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Color(0xFF7B6BA8)),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
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
                    'Register',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: Color(0xFF82799D),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'Login',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => goToLoginScreen(),
                        style: const TextStyle(
                          color: Color(0xFF432C81),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
