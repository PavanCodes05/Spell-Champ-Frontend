import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text(
          'This is the Reset Password Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
