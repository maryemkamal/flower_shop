// hello
import 'package:flutter/material.dart';

class TextScreen extends StatelessWidget {
  const TextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحة النصوص'),
        backgroundColor: Colors.green,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'مرحبًا بك في مشروع الزهور 🌸\n\n'
              'هذا مثال على صفحة تحتوي على نص فقط. يمكنك تعديل هذا النص وإضافة أي معلومات أخرى هنا.',
          style: TextStyle(
            fontSize: 20,
            height: 1.5,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
