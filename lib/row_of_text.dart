import 'package:flutter/material.dart';
import 'package:flower_shop/singUp_screen.dart';

class ForgetPasswordRow extends StatelessWidget {
  final String? firstWhiteText;
  final String? secoednBlcakText;

  const ForgetPasswordRow({
    super.key,
    this.firstWhiteText,
    this.secoednBlcakText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstWhiteText ?? 'text 1 ',
            style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SingupScreen()),
            );
          },
          child: Text(
            secoednBlcakText ?? '',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),

      ],
    );
  }
}
