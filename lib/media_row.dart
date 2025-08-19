import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLoginRow extends StatelessWidget {
  final void Function()? onGoogleTap;
  final void Function()? onFacebookTap;

  const SocialLoginRow({
    super.key,
    this.onGoogleTap,
    this.onFacebookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 15,
      children: [
        GestureDetector(
          onTap: onGoogleTap,
          child: const FaIcon(
            FontAwesomeIcons.google,
            color: Colors.red,
            size: 30,
          ),
        ),
        // GestureDetector(
        //   onTap: onFacebookTap,
        //   child: const FaIcon(
        //     FontAwesomeIcons.facebookF,
        //     color: Colors.blue,
        //     size: 30,
        //   ),
        // ),
      ],
    );
  }
}
