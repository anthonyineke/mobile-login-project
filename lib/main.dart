import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CSC 315 Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.amber, useMaterial3: true),
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLogin = true;

  static const Color _yellow = Color(0xFFFFC107);
  static const Color _dark = Color(0xFF212121);

  void _toggle() => setState(() => _isLogin = !_isLogin);

  // Underline-style text field
  Widget _field(String label, IconData icon,
      {bool obscure = false, TextInputType? type}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        obscureText: obscure,
        keyboardType: type,
        cursorColor: _dark,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey.shade700),
          floatingLabelStyle: const TextStyle(color: _dark),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: _dark, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Column(
      key: const ValueKey('login'),
      children: [
        _field('Email', Icons.email_outlined, type: TextInputType.emailAddress),
        _field('Password', Icons.lock_outline, obscure: true),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text('Forgot password?',
                style: TextStyle(color: _dark)),
          ),
        ),
        const SizedBox(height: 8),
        _button('Login'),
        _switchRow("Don't have an account?", 'Register'),
      ],
    );
  }

  Widget _registerForm() {
    return Column(
      key: const ValueKey('register'),
      children: [
        _field('Full name', Icons.person_outline),
        _field('Email', Icons.email_outlined, type: TextInputType.emailAddress),
        _field('Password', Icons.lock_outline, obscure: true),
        _field('Confirm password', Icons.lock_outline, obscure: true),
        const SizedBox(height: 8),
        _button('Register'),
        _switchRow('Already have an account?', 'Login'),
      ],
    );
  }

  // Static button
  Widget _button(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: _dark,
        foregroundColor: _yellow,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _switchRow(String question, String action) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(question, style: TextStyle(color: Colors.grey.shade700)),
          TextButton(
            onPressed: _toggle,
            child: Text(action,
                style: const TextStyle(
                    color: _dark, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                // Yellow header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 70, 24, 36),
                  decoration: const BoxDecoration(
                    color: _yellow,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(60)),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.lock_outline, size: 44, color: _dark),
                      const SizedBox(height: 12),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Text(
                          _isLogin ? 'Welcome Back' : 'Create Account',
                          key: ValueKey(_isLogin),
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: _dark),
                        ),
                      ),
                    ],
                  ),
                ),
                // Form
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _isLogin ? _loginForm() : _registerForm(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
