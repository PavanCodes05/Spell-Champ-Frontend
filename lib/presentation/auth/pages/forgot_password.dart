import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text(
          'This is the Forgot Password Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}